//
//  MSPChatCell.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/8.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPChatCell.h"
#import "MSPChatModel.h"

#import "UIView+Extension.h"
#import "UIImage+getImage.h"

#import <objc/runtime.h>

#import <Masonry.h>

#define TEXTSIZE 15
#define IMAGESIZE 40

@interface MSPChatCell ()

@property (nonatomic, readwrite, strong) UITextView *textView;
@property (nonatomic, readwrite, strong) UIImageView *paoPaoView;
@property (nonatomic, readwrite, strong) UIImageView *userImageView;
@property (nonatomic, readwrite, strong) UILabel *audioTimeView;
@property (nonatomic, readwrite, assign) BOOL sendByMe;

@end

@implementation MSPChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _sendByMe = NO;

        self.backgroundColor = [UIColor clearColor];
        _userImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_userImageView];
        
        _paoPaoView = [[UIImageView alloc] init];
        _paoPaoView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_paoPaoView];
        
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.scrollEnabled = NO;
        _textView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_textView];
        
        _audioTimeView = [[UILabel alloc] init];
        [_audioTimeView setFont:[UIFont systemFontOfSize:12]];
        [_audioTimeView setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:_audioTimeView];
        _audioTimeView.hidden = YES;
    }
    return self;
}

- (void)setModel:(MSPChatModel *)model {
    
    _userImageView.image = [UIImage msp_image:model.userImage];
    
    UIImage *paoPaoImage;
    // 我发送的
    if (model.posterUid == [[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] integerValue]) {
        paoPaoImage = [UIImage imageNamed:@"SenderTextNodeBkg"];
        _sendByMe = YES;
    }
    // 别人发送的
    else {
        UIImage *image = [UIImage imageNamed:@"SenderTextNodeBkg"];
        paoPaoImage = [UIImage imageWithCIImage:image.CIImage scale:image.scale orientation:UIImageOrientationUpMirrored];
        _sendByMe = NO;
    }
    paoPaoImage = [paoPaoImage stretchableImageWithLeftCapWidth:20 topCapHeight:30];
    _paoPaoView.image = paoPaoImage;
    
    _textView.text = model.content;
    _textView.textContainerInset = UIEdgeInsetsMake(12, 0, 10, 0);
    [_textView sizeToFit];
    
    // 语音消息
    if (model.isAudio) _audioTimeView.hidden = NO;
    // 文字消息
    else _audioTimeView.hidden = YES;
}

- (void)updateConstraints {
    if (_sendByMe) {
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.right.equalTo(self.mas_right).with.offset(-10);
            maker.top.equalTo(self.mas_top).with.offset(10);
            maker.size.equalTo(@(IMAGESIZE));
        }];
        [_textView mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.right.equalTo(_userImageView.mas_left).with.offset(-10);
            maker.top.equalTo(_userImageView.mas_top);
            maker.width.lessThanOrEqualTo(@(SCREEN_WIDTH - 120));
            maker.height.greaterThanOrEqualTo(@(40));
        }];
        [_paoPaoView mas_makeConstraints:^(MASConstraintMaker *maker) {
            maker.right.equalTo(_textView.mas_right).with.offset(5);
            maker.top.equalTo(_textView.mas_top);
            maker.bottom.equalTo(_textView.mas_bottom).with.offset(10);
            maker.left.equalTo(_textView.mas_left).with.offset(-10);
        }];
    }
    else {
//        [_userImageView mas_makeConstraints:^(MASConstraintMaker *maker){
//            maker.left.equalTo(self.mas_left).with.offset(10);
//            maker.top.equalTo(self.mas_top).with.offset(10);
//            maker.size.equalTo(@(IMAGESIZE));
//        }];
    }
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.preferedHeight = CGRectGetHeight(_paoPaoView.frame) + 10;
}

@end

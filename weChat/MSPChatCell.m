//
//  MSPChatCell.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/8.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPChatCell.h"
#import "MSPChatModel.h"
#import "MSPPaopaoView.h"

#import "UIView+Extension.h"
#import "UIImage+getImage.h"
#import "NSString+timeSign.h"

#import <objc/runtime.h>

#import <Masonry.h>

#define TEXTSIZE 15
#define IMAGESIZE 40

static NSArray *playViewImage;
static NSUInteger count;

@interface MSPChatCell ()

@property (nonatomic, readwrite, strong) MSPPaopaoView *paopaoView;
@property (nonatomic, readwrite, strong) UITextView *textView;
@property (nonatomic, readwrite, strong) UIImageView *paoPaoView;
@property (nonatomic, readwrite, strong) UIImageView *userImageView;
@property (nonatomic, readwrite, strong) UILabel *audioTimeView;
@property (nonatomic, readwrite, assign) BOOL sendByMe;
@property (nonatomic, readwrite, strong) UIImageView *playVoiceView;
@property (nonatomic, readwrite, strong) UITapGestureRecognizer *gesture;

@end

@implementation MSPChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _sendByMe = NO;

        self.backgroundColor = [UIColor clearColor];
        _userImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_userImageView];
        
//        _paoPaoView = [[UIImageView alloc] init];
//        _paoPaoView.contentMode = UIViewContentModeScaleToFill;
//        [self.contentView addSubview:_paoPaoView];
        
//        _textView = [[UITextView alloc] init];
//        _textView.font = [UIFont systemFontOfSize:16];
//        _textView.scrollEnabled = NO;
//        _textView.editable = NO;
//        _textView.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:_textView];
        
        _audioTimeView = [[UILabel alloc] init];
        [_audioTimeView setFont:[UIFont systemFontOfSize:12]];
        [_audioTimeView setTextColor:[UIColor grayColor]];
        _audioTimeView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_audioTimeView];
        _audioTimeView.hidden = YES;
        
//        _playVoiceView = [[UIImageView alloc] init];
//        _playVoiceView.backgroundColor = [UIColor clearColor];
//        _playVoiceView.userInteractionEnabled = NO;
//        [self.contentView addSubview:_playVoiceView];
//        _playVoiceView.hidden = YES;
        
//        playViewImage = @[@"ReceiverVoiceNodePlaying001",
//                          @"ReceiverVoiceNodePlaying002",
//                          @"ReceiverVoiceNodePlaying003"];
//        count = 0;
    }
    return self;
}

- (void)setModel:(MSPChatModel *)model {
    
    _userImageView.image = [UIImage msp_image:model.userImage];
    
    _paopaoView = [[MSPPaopaoView alloc] initWithModel:model];
    [self.contentView addSubview:_paopaoView];
    
    UIImage *paoPaoImage = [UIImage imageNamed:@"SenderTextNodeBkg"];
    // 我发送的
    if (model.posterUid == [[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] integerValue]) {
        _sendByMe = YES;
    }
    // 别人发送的
    else {
        paoPaoImage = [UIImage imageWithCIImage:paoPaoImage.CIImage scale:1 orientation:UIImageOrientationUpMirrored];
        _sendByMe = NO;
    }
    paoPaoImage = [paoPaoImage stretchableImageWithLeftCapWidth:20 topCapHeight:30];
    _paoPaoView.image = paoPaoImage;
    
    // 语音消息
    if (model.isAudio) {
        _playVoiceView.hidden = NO;
        _audioTimeView.hidden = NO;
        _gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVoice)];
        [_textView addGestureRecognizer:_gesture];
        _textView.text = @"              ";
        NSInteger time = (NSInteger)model.audioTimeInterval;
        for (NSInteger i = 0; i < time; i++) {
            if (i < 10) _textView.text = [NSString stringWithFormat:@"  %@",_textView.text];
            else if (i < 60) _textView.text = [NSString stringWithFormat:@" %@",_textView.text];
        }
        NSString *timeString = [NSString MinuteSecondStringWithNSIteger:time];
        [_audioTimeView setText:[NSString stringWithFormat:@"%@",timeString]];
        _playVoiceView.image = [UIImage imageNamed:@"ReceiverVoiceNodePlaying"];
        if (_sendByMe) _playVoiceView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    // 文字消息
    else {
        _audioTimeView.hidden = YES;
        _playVoiceView.hidden = YES;
        _textView.text = model.content;
        _textView.textContainerInset = UIEdgeInsetsMake(12, 0, 10, 0);
        [_textView sizeToFit];
        if (_gesture) {
            [_textView removeGestureRecognizer:_gesture];
            _gesture = nil;
        }
    }
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
        [_audioTimeView mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.right.equalTo(_textView.mas_left).with.offset(-10);
            maker.centerY.equalTo(_userImageView.mas_centerY);
        }];
        [_playVoiceView mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.centerY.equalTo(_userImageView.mas_centerY);
            maker.right.equalTo(_paoPaoView.mas_right).with.offset(-15);
            maker.width.equalTo(@(12));
            maker.height.equalTo(@(17));
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

- (void)playVoice {
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVoice:indexPath:)]) {
        [self.delegate playVoice:self.model indexPath:self.indexPath];
    }
}

- (void)updatePlayingStatusView {
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateStatus) userInfo:nil repeats:YES];
}

- (void)resetVoiceView {
    _playVoiceView.image = [UIImage imageNamed:@"ReceiverVoiceNodePlaying"];
    count = 0;
}

- (void)updateStatus {
    _playVoiceView.image = [playViewImage objectAtIndex:count%3];
    count++;
}

@end

//
//  MSPChatCell.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/8.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPChatCell.h"
#import "MSPChatModel.h"
#import "MSPChatPaoPaoView.h"

#import "UIView+Extension.h"
#import "UIImage+getImage.h"

#import <objc/runtime.h>

#import <Masonry.h>

#define TEXTSIZE 15
#define IMAGESIZE 40

@interface MSPChatCell ()

@property (nonatomic, readwrite, strong) MSPChatPaoPaoView *paoPao;
@property (nonatomic, readwrite, strong) UIImageView *userImageView;
@property (nonatomic, readwrite, strong) UILabel *audioTimeView;

@end

@implementation MSPChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.backgroundColor = [UIColor clearColor];
        _userImageView = [[UIImageView alloc] init];
        _userImageView.width = IMAGESIZE;
        _userImageView.height = IMAGESIZE;
        _userImageView.y = THESPACE;
        [self.contentView addSubview:_userImageView];
        
        _audioTimeView = [[UILabel alloc] init];
        [_audioTimeView setFont:[UIFont systemFontOfSize:12]];
        [_audioTimeView setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:_audioTimeView];
        _audioTimeView.hidden = YES;
    }
    return self;
}

- (void)setModel:(MSPChatModel *)model {
    
    _paoPao = [[MSPChatPaoPaoView alloc] initWithModel:model];
    [self.contentView addSubview:_paoPao];
    
    _userImageView.image = [UIImage msp_image:model.userImage];
    
    // 语音消息
    if (model.isAudio) _audioTimeView.hidden = NO;
    
    // 文字消息
    else _audioTimeView.hidden = YES;
    
    // 我发送的
    if (model.posterUid == [[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] integerValue]) {
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.right.equalTo(self.mas_right).with.offset(-10);
            maker.top.equalTo(self.mas_top);
            maker.size.equalTo(@(IMAGESIZE));
        }];
        [_paoPao mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.right.equalTo(_userImageView.mas_left).with.offset(-3);
            maker.top.equalTo(_userImageView.mas_top);
        }];
    }
    // 别人发送的
    else {
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(self.mas_left).with.offset(10);
            maker.top.equalTo(self.mas_top);
            maker.size.equalTo(@(IMAGESIZE));
        }];
        [_paoPao mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.top.equalTo(_userImageView.mas_top);
            maker.left.equalTo(_userImageView.mas_right).with.offset(3);
        }];
    }
    CGFloat height = _paoPao.height;
    objc_setAssociatedObject(self, "cellheight", @(height), OBJC_ASSOCIATION_ASSIGN);
}

@end

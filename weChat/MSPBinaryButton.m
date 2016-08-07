//
//  MSPBinaryButton.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/7.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPBinaryButton.h"

@interface MSPBinaryButton ()

@property (nonatomic, readwrite, strong) UIButton *chat;
@property (nonatomic, readwrite, strong) UIButton *video;

@end

@implementation MSPBinaryButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization:frame];
    }
    return self;
}

- (void)initialization:(CGRect)frame {
    
    CGFloat buttonHeight = (frame.size.height - 15) / 2;
    
    _chat = [UIButton buttonWithType:UIButtonTypeSystem];
    _chat.frame = CGRectMake(25, 0, SCREEN_WIDTH - 50, buttonHeight);
    [_chat setTitle:@"发消息" forState:UIControlStateNormal];
    [_chat.titleLabel setFont:[UIFont systemFontOfSize:19]];
    [_chat setTintColor:[UIColor whiteColor]];
    _chat.layer.masksToBounds = YES;
    _chat.layer.cornerRadius = 6;
    _chat.backgroundColor = [UIColor colorWithRed:0 green:0.7 blue:0 alpha:1];
    [_chat addTarget:self action:@selector(sendMessageView) forControlEvents:UIControlEventTouchUpInside];
    
    _video = [UIButton buttonWithType:UIButtonTypeSystem];
    _video.frame = CGRectMake(25, buttonHeight + 15, SCREEN_WIDTH - 50, buttonHeight);
    [_video setTitle:@"视频聊天" forState:UIControlStateNormal];
    [_video.titleLabel setFont:[UIFont systemFontOfSize:19]];
    [_video setTintColor:[UIColor blackColor]];
    _video.layer.masksToBounds = YES;
    _video.layer.cornerRadius = 6;
    _video.backgroundColor = [UIColor whiteColor];
    [_video addTarget:self action:@selector(sendVideo) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_chat];
    [self addSubview:_video];
}

- (void)sendMessageView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithMessage)]) {
        [self.delegate clickWithMessage];
    }
}

- (void)sendVideo {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithVideo)]) {
        [self.delegate clickWithVideo];
    }
}

@end

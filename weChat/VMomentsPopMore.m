//
//  VMomentsPopMore.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/15.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "VMomentsPopMore.h"

#define PopMoreWidth 120
#define PopMoreHeight 34

@interface VMomentsPopMore ()

@property (nonatomic,strong) UIButton *replayButton;
@property (nonatomic,strong) UIButton *likeButton;
@property (nonatomic,assign) CGRect targetRect;


@end


@implementation VMomentsPopMore

- (instancetype)init
{
    if (self = [super init]) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView
{
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.800];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    
    _replayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _replayButton.tag = 0;
    _replayButton.frame = CGRectMake(0, 0, PopMoreWidth / 2, PopMoreHeight);
    [_replayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _replayButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_replayButton setTitle:@"评论" forState:UIControlStateNormal];
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _likeButton.tag = 1;
    _likeButton.frame = CGRectMake(CGRectGetMaxX(_replayButton.frame), 0, PopMoreWidth / 2, PopMoreHeight);
    [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _likeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_likeButton setTitle:@"赞" forState:UIControlStateNormal];
    
}

- (void)showAtView:(UITableView *)containerView rect:(CGRect)targetRect isFavour:(BOOL)isFavour {
    self.targetRect = targetRect;
    if (self.shouldShowed) {
        return;
    }
    
    [containerView addSubview:self];
    
    self.frame = CGRectMake(targetRect.origin.x, targetRect.origin.y, 0, PopMoreHeight);
}

- (void)dismiss
{
    
}



@end

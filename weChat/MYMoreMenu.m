//
//  MYMoreMenu.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/21.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "MYMoreMenu.h"
#import "UIView+Extension.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define THESPACE 10
@interface MYMoreMenu ()

@property (nonatomic,weak) UIImageView *containerView;

@end

@implementation MYMoreMenu

//  lazy load
- (UIImageView *)containerView {
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamed:@"MoreFunctionFrame"];
        UIEdgeInsets insets = UIEdgeInsetsMake(20, 20, 20, 110);
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
        containerView.image = image;
        containerView.width = 140;
        containerView.height = 180;
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menu {
    return [[self alloc]init];
}

- (void)setContent:(UIView *)content {
    _content = content;
    
    // 设置内容的位置
    content.x = THESPACE;
    content.y = THESPACE + 3;
    
    // 设置内容的宽度
    content.width = self.containerView.width - THESPACE * 2;
    
    // 设置黑色背景图的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 7;
    
    [self.containerView addSubview:content];
    
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    _contentViewController = contentViewController;
    self.content = contentViewController.view;
}

- (void)showFrom:(UIView *)from {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    self.frame = window.bounds;
    
    // 坐标系转换
    CGRect newFrame = [from.superview.superview convertRect:from.frame fromView:nil];
    self.containerView.x = SCREENWIDTH - self.containerView.width;
    self.containerView.y = CGRectGetMaxY(newFrame) + THESPACE * 2.5;

}

- (void)dismiss {
    [self removeFromSuperview];
}


@end

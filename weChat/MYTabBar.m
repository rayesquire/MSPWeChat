//
//  MYTabBar.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/22.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "MYTabBar.h"

@implementation MYTabBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.plusButton = [[UIButton alloc]init];
        [self.plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [self.plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [self.plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [self.plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        self.plusButton.size = self.plusButton.currentBackgroundImage.size;
        [self.plusButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.plusButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.plusButton.centerX = self.width / 2;
    self.plusButton.centerY = self.height / 2;
    
    CGFloat width = self.width / 5;
    CGFloat index = 0;
    for (UIView *view in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.width = width;
            view.x = index * width;
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

- (void)click
{
    if ([self.customDelegate respondsToSelector:@selector(plusButtonClick:)]) {
        [self.customDelegate plusButtonClick:self];
    }
}



@end

//
//  MYMoreMenu.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/21.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYMoreMenu : UIView

+ (instancetype)menu;

// 显示
- (void)showFrom:(UIView *)from;

// 销毁
- (void)dismiss;

// 内容
@property (nonatomic,strong) UIView *content;

// 内容控制器
@property (nonatomic,strong) UIViewController *contentViewController;


@end

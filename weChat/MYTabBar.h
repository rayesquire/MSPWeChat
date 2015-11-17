//
//  MYTabBar.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/22.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
@class MYTabBar;
@protocol MYTabBarDelegate <NSObject>

- (void)plusButtonClick:(MYTabBar *)tabBar;

@end

@interface MYTabBar : UITabBar

@property (nonatomic,strong) UIButton *plusButton;

@property (nonatomic,weak) id<MYTabBarDelegate> customDelegate;

@end

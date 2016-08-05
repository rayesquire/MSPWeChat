//
//  MYNavigationController.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/20.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "MYNavigationController.h"

@interface MYNavigationController ()

@end

@implementation MYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

@end

//
//  MainViewController.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/26.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//
#import "MainViewController.h"
#import "MYNavigationController.h"
#import "CWeChat.h"
#import "findView.h"
#import "CContacts.h"
#import "MSPMineVC.h"

//#import "MYTabBar.h"
#define MYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//@interface MainViewController () <MYTabBarDelegate>
//@end
@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CWeChat *view1 = [[CWeChat alloc]init];
    [self addViewContronller:view1 withTitle:@"微信" andImage:@"tabbar_mainframe" andSelectedImage:@"tabbar_mainframeHL"];
    
    CContacts *view2 = [[CContacts alloc]init];
    [self addViewContronller:view2 withTitle:@"通讯录" andImage:@"tabbar_contacts" andSelectedImage:@"tabbar_contactsHL"];
    
    findView *view3 = [[findView alloc]init];
    [self addViewContronller:view3 withTitle:@"发现" andImage:@"tabbar_discover" andSelectedImage:@"tabbar_discoverHL"];
    
    MSPMineVC *view4 = [[MSPMineVC alloc]init];
    [self addViewContronller:view4 withTitle:@"我" andImage:@"tabbar_me" andSelectedImage:@"tabbar_meHL"];
    
//    MYTabBar *tabBar = [[MYTabBar alloc]init];
//    tabBar.customDelegate = self;
//    [self setValue:tabBar forKey:@"tabBar"];
    
}

//- (void)plusButtonClick:(MYTabBar *)tabBar
//{
//    ;
//}

- (void)addViewContronller:(UIViewController *)viewController withTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage
{
    viewController.title = title;

    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = MYColor(76, 178, 15);
    [viewController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    MYNavigationController *navigationController = [[MYNavigationController alloc]initWithRootViewController:viewController];

    [self addChildViewController:navigationController];
}

@end
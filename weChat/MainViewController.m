//
//  MainViewController.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/26.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//
#import "MainViewController.h"
#import "MYNavigationController.h"
#import "MSPChatListVC.h"
#import "MSPContactsVC.h"
#import "MSPDiscoverVC.h"
#import "MSPMineVC.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MSPChatListVC *view1 = [[MSPChatListVC alloc]init];
    [self addViewContronller:view1 withTitle:@"微信" andImage:@"tabbar_mainframe" andSelectedImage:@"tabbar_mainframeHL"];
    
    MSPContactsVC *view2 = [[MSPContactsVC alloc]init];
    [self addViewContronller:view2 withTitle:@"通讯录" andImage:@"tabbar_contacts" andSelectedImage:@"tabbar_contactsHL"];
    
    MSPDiscoverVC *view3 = [[MSPDiscoverVC alloc]init];
    [self addViewContronller:view3 withTitle:@"发现" andImage:@"tabbar_discover" andSelectedImage:@"tabbar_discoverHL"];
    
    MSPMineVC *view4 = [[MSPMineVC alloc]init];
    [self addViewContronller:view4 withTitle:@"我" andImage:@"tabbar_me" andSelectedImage:@"tabbar_meHL"];
    
}

- (void)addViewContronller:(UIViewController *)viewController withTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage {
    
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
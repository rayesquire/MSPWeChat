//
//  groupChatViewController.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/2.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "groupChatViewController.h"

@interface groupChatViewController ()

@end

@implementation groupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.title = @"群聊";

    UILabel *label = [[UILabel alloc]init];
    label.text = @"你可通过群聊中的“保存到通讯录”选项，将其保存到这里";
    [label setTextColor:[UIColor grayColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [label setFrame:CGRectMake(15, (self.view.frame.size.height-64)/2, 290, 50)];
    [self.view addSubview:label];

}

@end

//
//  searchPublicViewController.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/2.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "searchPublicViewController.h"

@interface searchPublicViewController ()

@end

@implementation searchPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title = @"查找公众号";
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 44)];
    search.placeholder = @"搜索";
    [self.view addSubview:search];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, 320, 20)];
    label.text = @"关注微信公众号，获取更多服务和咨询";
    label.textColor = [UIColor grayColor];
    [label setFont:[UIFont systemFontOfSize:12]];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

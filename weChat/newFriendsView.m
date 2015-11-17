//
//  newFriendsView.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/31.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "newFriendsView.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
@interface newFriendsView () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation newFriendsView

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addSearchBarAndTableView];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:@"添加朋友" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = button;
    [self.view addSubview:_tableView];
    
}

- (void)addSearchBarAndTableView
{
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.placeholder = @"微信号/手机号/QQ号";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = search;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    else {
    return 50;
    }
}

#pragma mark - 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.000001;
    }else {
        return 15;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
        if (indexPath.section == 0) {
            UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button1 setTitle:@"添加手机联系人" forState:UIControlStateNormal];
            [button2 setTitle:@"添加QQ好友" forState:UIControlStateNormal];
            [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button1.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [button2.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [button1 setImage:[UIImage imageNamed:@"NewFriend_Contacts_icon"] forState:UIControlStateNormal];
            [button2 setImage:[UIImage imageNamed:@"NewFriend_QQ_icon"] forState:UIControlStateNormal];
            [button1 setFrame:CGRectMake(50, -8, 160, 80)];
            [button2 setFrame:CGRectMake(200, -8, 160, 80)];
            button1.titleEdgeInsets = UIEdgeInsetsMake(55, -83, -3, 30);
            button2.titleEdgeInsets = UIEdgeInsetsMake(55, -71, -3, 30);
            UILabel *cut = [[UILabel alloc]initWithFrame:CGRectMake(160, 108, 0.5, 80)];
            [cut setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
            [self.view addSubview:cut];
            [cell addSubview:button1];
            [cell addSubview:button2];
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
    return 6;
    }
}

@end
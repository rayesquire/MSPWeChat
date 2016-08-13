//
//  MoreFunctionTableViewController.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/21.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "MoreFunctionTableViewController.h"
#import "MoreMenuTableViewCell.h"
#define MOREMENUSIZE 14
#define MYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation MoreFunctionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.bounces = NO;
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 5)];
        [self.tableView setSeparatorColor:MYColor(100, 100, 100)];
        [self setExtraCellLineHidden:self.tableView];
    }
    return self;
}


-(void)setExtraCellLineHidden: (UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    MoreMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[MoreMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if (indexPath.section == 0) {
        cell.label.text = @"发起群聊";
        cell.userImageView.image = [UIImage imageNamed:@"contacts_add_newmessage"];
    }else if (indexPath.section == 1){
        cell.label.text = @"添加朋友";
        cell.userImageView.image = [UIImage imageNamed:@"contacts_add_friend"];
    }else if (indexPath.section == 2){
        cell.label.text = @"扫一扫";
        cell.userImageView.image = [UIImage imageNamed:@"contacts_add_scan"];
    }else if (indexPath.section == 3){
        cell.label.text = @"收钱";
        cell.userImageView.image = [UIImage imageNamed:@"contacts_add_money"];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreMenuTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
}



@end
//
//  detailSettings.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/30.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "detailSettings.h"
// 删除无高亮，长度不能调整，
@interface detailSettings () <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView *_settingsTableView;
}

@end

@implementation detailSettings

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];

    _settingsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-100) style:UITableViewStyleGrouped];
    _settingsTableView.delegate = self;
    _settingsTableView.dataSource = self;
    _settingsTableView.scrollEnabled = NO;
    
    [self.view addSubview:_settingsTableView];
    
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [delete.layer setCornerRadius:5];
    CGSize deleteSize = CGSizeMake(290, 44);
    delete.frame = CGRectMake(15, 480, deleteSize.width, deleteSize.height);
    delete.tintColor = [UIColor whiteColor];
    delete.titleLabel.font = [UIFont systemFontOfSize:16];
    delete.backgroundColor = [UIColor redColor];
    
    [delete setTitle:@"删除" forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(deleteContact) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delete];
//    _settingsTableView.tableFooterView = delete;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3 || section == 4) {
        return 2;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    UISwitch *sw = [[UISwitch alloc]init];
    
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"设置备注及标签";
    }else if (indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"把他/她推荐给朋友";
    }else if (indexPath.section == 2){
        cell.accessoryView = sw;
        cell.textLabel.text = @"设为星标朋友";
    }else if (indexPath.section == 3){
        cell.accessoryView = sw;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"不让他/她看我的朋友圈";
        }else {
            cell.textLabel.text = @"不看他/她的朋友圈";
        }
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"加入黑名单";
            cell.accessoryView = sw;
        }else{
            cell.textLabel.text = @"举报";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    // 不可点击
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 12;
    }else{
    return 5;
    }
}

// button
- (void)deleteContact
{
    ;
}

@end
//
//  MSPContactsInformationSettingVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/7.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPContactsInformationSettingVC.h"

#import <Masonry.h>

@interface MSPContactsInformationSettingVC () <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) UIButton *delete;
@property (nonatomic, readwrite, strong) UIView *deleteBackgroundView;

@end

@implementation MSPContactsInformationSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.title = @"资料设置";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.equalTo(self.view.mas_top);
        maker.left.equalTo(self.view.mas_left);
        maker.right.equalTo(self.view.mas_right);
        maker.height.equalTo(self.view.mas_height);
    }];
    
    _delete = [UIButton buttonWithType:UIButtonTypeSystem];
    _delete.layer.cornerRadius = 6;
    _delete.frame = CGRectMake(30, 0, SCREEN_WIDTH - 60, 50);
    _delete.tintColor = [UIColor whiteColor];
    _delete.titleLabel.font = [UIFont systemFontOfSize:16];
    _delete.backgroundColor = [UIColor colorWithRed:0.85 green:0 blue:0 alpha:1];
    [_delete setTitle:@"删除" forState:UIControlStateNormal];
    [_delete addTarget:self action:@selector(deleteContact) forControlEvents:UIControlEventTouchUpInside];
    _deleteBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _deleteBackgroundView.backgroundColor = BACKGROUND_COLOR;
    [_deleteBackgroundView addSubview:_delete];
    _tableView.tableFooterView = _deleteBackgroundView;
}

#pragma mark - UITabeView delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3 || section == 4) return 2;
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) return 20;
    return 1;
}

// button
- (void)deleteContact
{
    ;
}



@end

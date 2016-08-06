//
//  MSPPersonalInfomationVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/5.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPPersonalInfomationVC.h"
#import "MSPPersonalInformationModel.h"
#import "MSPPersonalInformationCell.h"
#import "MSPAvatorVC.h"
#import "MSPRegionSelectVC.h"

#define TITLESIZE 15
#define DETAILSIZE 12

@interface MSPPersonalInfomationVC () <UITableViewDataSource,
                                       UITableViewDelegate,
                                       UIImagePickerControllerDelegate,
                                       UINavigationControllerDelegate>

@property (nonatomic, readwrite, strong) NSArray *listArray;
@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) UIImageView *userImage;

@end

@implementation MSPPersonalInfomationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.title = @"个人信息";
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _listArray = @[@"头像",@"名字",@"微信号",@"我的二维码",@"我的地址",@"性别",@"地区",@"个性签名"];
}

- (void)viewWillAppear:(BOOL)animated {
    if (_tableView) {
        [_tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 5;
    else return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) return 70;
    else return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *msppersonalinformationcellIdentifier = @"cellIdentifier";
    MSPPersonalInformationCell *cell = [[MSPPersonalInformationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:msppersonalinformationcellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.font = [UIFont systemFontOfSize:TITLESIZE];
        cell.textLabel.text = _listArray[indexPath.row];
        if (indexPath.row == 0) {
            UIImage *image;
            if (!_personalInfo.userImage || [_personalInfo.userImage isEqualToString:@""]) {
                image = [UIImage imageNamed:_personalInfo.userImage];
            }
            else {
                image = [UIImage imageWithContentsOfFile:_personalInfo.userImage];
            }
            [cell setRightIcon:image size:CGSizeMake(55, 55)];
        }
        else if (indexPath.row == 3) {
            UIImage *image = [UIImage imageNamed:@"qrcode"];
            [cell setRightIcon:image size:CGSizeMake(20, 20)];
        }
        else if (indexPath.row == 1) {
            cell.detailTextLabel.text = self.personalInfo.name;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILSIZE];
        }
        else if (indexPath.row == 2) {
            cell.detailTextLabel.text = self.personalInfo.account;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILSIZE];
            cell.accessoryType = NO;
        }
    }
    else {
        cell.textLabel.font = [UIFont systemFontOfSize:TITLESIZE];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILSIZE];
        cell.textLabel.text = _listArray[indexPath.row + 5];
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = _personalInfo.sex;
        }
        else if (indexPath.row == 1){
            cell.detailTextLabel.text = _personalInfo.region;
        }
        else {
            cell.detailTextLabel.text = _personalInfo.autograph;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MSPAvatorVC *con = [[MSPAvatorVC alloc] init];
            [self.navigationController pushViewController:con animated:YES];
        }
    }
    else {
        if (indexPath.row == 1) {
            MSPRegionSelectVC *con = [[MSPRegionSelectVC alloc] init];
            [self.navigationController pushViewController:con animated:YES];
        }
    }
}

@end

//
//  MSPMineVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/5.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPMineVC.h"
#import "MSPPersonalInfomationVC.h"
#import "MSPPersonalInformationModel.h"
#import "MSPPersonalInformationCell.h"

#define TITLESIZE 15

@interface MSPMineVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, readwrite, strong) NSArray *listArray;
@property (nonatomic, readwrite, strong) NSArray *iconArray;
@property (nonatomic, readwrite, strong) MSPPersonalInformationModel *personalInfo;

@end

@implementation MSPMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _listArray = @[@"相册", @"收藏", @"钱包", @"表情", @"设置"];
    _iconArray = @[[UIImage imageNamed:@"MoreMyAlbum"],
                   [UIImage imageNamed:@"MoreMyFavorites"],
                   [UIImage imageNamed:@"MoreMyBankCard"],
                   [UIImage imageNamed:@"MoreExpressionShops"],
                   [UIImage imageNamed:@"MoreSetting"]];
    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    RLMResults *result = [MSPPersonalInformationModel allObjectsInRealm:realm];
    RLMResults *result = [MSPPersonalInformationModel objectsWhere:@"ID = 1"];
    _personalInfo = result.firstObject;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_tableView) {
        [_tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 80;
    else return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) return 3;
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *mspminecellIdentifier = @"cellIdentifier";
    MSPPersonalInformationCell *cell = [[MSPPersonalInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mspminecellIdentifier];
    if (indexPath.section == 0) {
        cell.model = _personalInfo;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        int index = (int)indexPath.row;
        if (indexPath.section == 2 || indexPath.section == 3) index = 1 + (int)indexPath.section;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _listArray[index];
        cell.imageView.image = _iconArray[index];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 17;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        MSPPersonalInfomationVC *con = [[MSPPersonalInfomationVC alloc] init];
        con.personalInfo = _personalInfo;
        [self.navigationController pushViewController:con animated:YES];
    }
}

@end

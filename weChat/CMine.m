//
//  meView.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/26.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "CMine.h"
#import "MSPPersonalInfomationVC.h"
#import "MSPPersonalInformationModel.h"
#import "CPersonalInformation.h"
#define TITLESIZE 15

@interface CMine () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, readwrite, strong) NSArray *listArray;
@property (nonatomic, readwrite, strong) NSArray *iconArray;
@property (nonatomic, readwrite, strong) MMine *personalInfo;

@end

@implementation CMine

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
    _personalInfo = [[MMine alloc] init];
    _personalInfo.name = @"尾巴超大号";
    _personalInfo.account = @"msp656692784";
    _personalInfo.userImage = @"dog.jpg";
    _personalInfo.sex = @"男";
    _personalInfo.region = @"江苏 南京";
    _personalInfo.autograph = @"In me the tiger sniffs the rose";
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
    static NSString *cellIdentifier = @"cellIdentifier";
    if (indexPath.section == 0) {
        VMine *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[VMine alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.model = _personalInfo;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else {
        int index = (int)indexPath.row;
        if (indexPath.section == 2 || indexPath.section == 3) index = 1 + (int)indexPath.section;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _listArray[index];
        cell.imageView.image = _iconArray[index];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 17;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CPersonalInformation *con = [[CPersonalInformation alloc] init];
        con.personalInfo = _personalInfo;
        [self.navigationController pushViewController:con animated:YES];
    }
}

@end

//
//  meView.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/26.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "CMine.h"
#import "VMine.h"
#import "MMine.h"
#import "CPersonalInformation.h"
#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT self.view.frame.size.height
#define TITLESIZE 15
#define QRCODEX 270
#define QRCODEY 30

@interface CMine () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation CMine

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark - the height of row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 44;
    }
}

#pragma mark - number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark - number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 3;
    }else {
        return 1;
    }
}

#pragma mark - cell for row at indexpath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    if (indexPath.section == 0) {
        VMine *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[VMine alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier qrcodex:QRCODEX qrcodey:QRCODEY];
        // data
        MMine *tmp = [[MMine alloc]init];
        tmp.name = @"尾巴超大号";
        tmp.account = @"msp656692784";
        tmp.userImage = @"dog.jpg";
        cell.mMine = tmp;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        return cell;
    }else {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 1){
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"MoreMyAlbum"];
                cell.textLabel.text = @"相册";
            }else if (indexPath.row == 1){
                cell.imageView.image = [UIImage imageNamed:@"MoreMyFavorites"];
                cell.textLabel.text = @"收藏";
            }else if (indexPath.row == 2){
                cell.imageView.image = [UIImage imageNamed:@"MoreMyBankCard"];
                cell.textLabel.text = @"钱包";
            }
        }else if (indexPath.section == 2){
            cell.textLabel.text = @"表情";
            cell.imageView.image = [UIImage imageNamed:@"MoreExpressionShops"];
        }else if (indexPath.section == 3){
            cell.imageView.image = [UIImage imageNamed:@"MoreSetting"];
            cell.textLabel.text = @"设置";
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 17;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}



@end

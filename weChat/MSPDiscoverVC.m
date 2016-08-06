//
//  MSPDiscoverVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/6.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPDiscoverVC.h"

@interface MSPDiscoverVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) NSArray *listArray;
@property (nonatomic, readwrite, strong) NSArray *iconArray;

@end

@implementation MSPDiscoverVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _listArray = @[@"朋友圈", @"扫一扫", @"摇一摇", @"附近的人", @"购物", @"游戏"];
    _iconArray = @[@"ff_IconShowAlbum", @"ff_IconQRCode", @"ff_IconShake", @"ff_IconLocationService", @"CreditCard_ShoppingBag", @"MoreGame"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1 || section == 3) return 2;
    else return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0 || indexPath.section == 1) {
        cell.textLabel.text = _listArray[indexPath.section + indexPath.row];
        cell.imageView.image = _iconArray[indexPath.section + indexPath.row];
    }
    else {
        cell.textLabel.text = _listArray[indexPath.section + indexPath.row + 1];
        cell.imageView.image = _iconArray[indexPath.section + indexPath.row + 1];
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
//        Cmoments *moments = [[Cmoments alloc]init];
//        [self.navigationController pushViewController:moments animated:YES];
    }
}

@end

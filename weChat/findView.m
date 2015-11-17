//
//  findView.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/26.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "findView.h"
#import "Cmoments.h"

@interface findView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation findView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];

    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UITableView *tableFindView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableFindView.delegate = self;
    tableFindView.dataSource = self;
    [self.view addSubview:tableFindView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1 || section == 3) {
        return 2;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.section == 0) {
            cell.textLabel.text = @"朋友圈";
            cell.imageView.image = [UIImage imageNamed:@"ff_IconShowAlbum"];
        } else if (indexPath.section == 1){
            if (indexPath.row == 0) {
                cell.textLabel.text = @"扫一扫";
                cell.imageView.image = [UIImage imageNamed:@"ff_IconQRCode"];
            }
            else if (indexPath.row == 1)
            {
                cell.textLabel.text = @"摇一摇";
                cell.imageView.image = [UIImage imageNamed:@"ff_IconShake"];
            }
        } else if (indexPath.section == 2){
            cell.textLabel.text = @"附近的人";
            cell.imageView.image = [UIImage imageNamed:@"ff_IconLocationService"];
        } else if (indexPath.section == 3){
            if (indexPath.row == 0) {
            cell.textLabel.text = @"购物";
            cell.imageView.image = [UIImage imageNamed:@"CreditCard_ShoppingBag"];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"游戏";
            cell.imageView.image = [UIImage imageNamed:@"MoreGame"];
        }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 17;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     //点击后取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        Cmoments *moments = [[Cmoments alloc]init];
        [self.navigationController pushViewController:moments animated:YES];
    }
}

@end

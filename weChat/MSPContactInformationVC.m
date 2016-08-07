//
//  MSPContactInformationVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/6.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPContactInformationVC.h"
#import "MSPContactsInformationCell.h"
#import "MSPContactModel.h"
#import "MSPBinaryButton.h"
#import "MSPContactsInformationSettingVC.h"

#import <Masonry.h>

@interface MSPContactInformationVC () <UITableViewDelegate,
                                       UITableViewDataSource,
                                       MSPBinaryButtonDelegate>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) MSPBinaryButton *button;


@end

@implementation MSPContactInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.title = @"详细资料";

    UIBarButtonItem *more = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleDone target:self action:@selector(more)];
    self.navigationItem.rightBarButtonItem = more;

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(self.view.mas_height);
    }];
    
    _button = [[MSPBinaryButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
    _button.delegate = self;
    _tableView.tableFooterView = _button;
    
}

#pragma mark - MSPBinaryButtonDelegate
// chat view
- (void)clickWithMessage {
//    _model
    
}

- (void)clickWithVideo {
//    _model
}

#pragma mark - UITableView delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) return 3;
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MSPContactInformationCell";
    MSPContactsInformationCell *cell = [[MSPContactsInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if (indexPath.section == 0) {
        cell.model = _model;
    }
    else if (indexPath.section == 1){
        cell.textLabel.text = @"设置备注和标签";
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"地区";
                break;
            }
            case 1: {
                cell.textLabel.text = @"个人相册";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case 2: {
                cell.textLabel.text = @"更多";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 90;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) return 20;
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)more {
    MSPContactsInformationSettingVC *con = [[MSPContactsInformationSettingVC alloc] init];
    con.model = _model;
    [self.navigationController pushViewController:con animated:YES];
}

@end

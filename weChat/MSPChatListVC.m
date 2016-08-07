//
//  MSPChatListVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/7.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPChatListVC.h"
#import "MSPContactChatModel.h"
#import "MSPChatListCell.h"

#import <SWTableViewCell.h>
#import <Masonry.h>

#import "UIView+Extension.h"

#import <RLMRealm.h>

@interface MSPChatListVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) UISearchBar *searchBar;
@property (nonatomic, readwrite, strong) NSArray *chatListArray;

@property (nonatomic, readwrite, strong) RLMResults *results;
@property (nonatomic, readwrite, strong) RLMRealm *realm;

@end

@implementation MSPChatListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //        UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:0];
    //        item.badgeValue = [NSString stringWithFormat:@"%d",99];
    self.view.backgroundColor = MYColor(234, 234, 234);
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.equalTo(self.view.mas_top);
        maker.left.equalTo(self.view.mas_left);
        maker.right.equalTo(self.view.mas_right);
        maker.bottom.equalTo(self.view.mas_bottom);
    }];
    [self setExtraCellLineHidden:_tableView];

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    _searchBar.placeholder = @"搜索";
    [_tableView setTableHeaderView:_searchBar];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.width = 30;
    moreBtn.height = 30;
    [moreBtn setImage:[UIImage imageNamed:@"barbuttonicon_add"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _realm = [RLMRealm defaultRealm];
    _results = [[MSPContactChatModel allObjectsInRealm:_realm] sortedResultsUsingProperty:@"time" ascending:YES];
    
    [_tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MSPChatListCell";
    MSPChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) cell = [[MSPChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    MSPContactChatModel *model = [_results objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    //    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] title:@"标为未读" font:16];
    //    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor redColor] title:@"删除" font:16];
    return rightUtilityButtons;
}

- (NSArray *)rightButtonsUnread
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    //    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] title:@"标为已读" font:16];
    //    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor redColor] title:@"删除" font:16];
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
//    NSIndexPath *idx = [_tableView indexPathForCell:cell];
//    switch (index) {
//        case 0:
//        {
//            // unread ball
//            
//            
//            // change sw button
//            cell.rightUtilityButtons = [self rightButtonsUnread];
//            // change frame
//            //            NSLog(@"%f %f %f %f",cell.frame.origin.x,cell.frame.origin.y,cell.frame.size.width,cell.frame.size.height);
//            NSLog(@"%@ %@",cell.rightUtilityButtons.firstObject,cell.rightUtilityButtons.lastObject);
//            
//            
//        }
//            break;
//        case 1:
//        {
//            MWeChat *obj = _array[idx.row];
//            NSString *uid = [NSString stringWithFormat:@"%ld",(long)obj.ID];
//            [_array removeObjectAtIndex:idx.row];
//            NSString *deleteList = [NSString stringWithFormat:@"DELETE FROM recentContacts WHERE uid=%d",[uid intValue]];
//            [self execSql:deleteList];
//            NSString *deleteRecordFromMe = [NSString stringWithFormat:@"DELETE FROM chatRecord WHERE toid=%d",[uid intValue]];
//            [self execSql:deleteRecordFromMe];
//            NSString *deleteRecordFromOther = [NSString stringWithFormat:@"DELETE FROM chatRecord WHERE fromid=%d",[uid intValue]];
//            [self execSql:deleteRecordFromOther];
//            [_tableView deleteRowsAtIndexPaths:@[idx] withRowAnimation:UITableViewRowAnimationTop];
//        }
//            break;
//    }
}

#pragma mark - hide extral cell
- (void)setExtraCellLineHidden: (UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    CChat *cChat = [[CChat alloc]init];
//    self.delegate = cChat;
//    MWeChat *tmp = _array[indexPath.row];
//    NSString *image = tmp.userImage;
//    [cChat setTitle:tmp.remark];
//    [self.delegate passIDAndUserImage:tmp.ID userImage:image];
//    [self.navigationController pushViewController:cChat animated:YES];
}

- (void)click:(UIView *)moreButton {
//    MYMoreMenu *menu = [MYMoreMenu menu];
//    MoreFunctionTableViewController *controller = [[MoreFunctionTableViewController alloc]init];
//    controller.view.height = 160;
//    menu.contentViewController = controller;
//    [menu showFrom:moreButton];
}

@end

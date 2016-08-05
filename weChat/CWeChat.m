//
//  CChatList.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/21.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "CWeChat.h"
#import "MWeChat.h"
#import "VWeChat.h"
#import "CChat.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "MYMoreMenu.h"
#import "MoreFunctionTableViewController.h"
#import "sqlite3.h"
#import "SWTableViewCell.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define MYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define DATABASENAME @"chatRecord.sqlite"
@interface CWeChat () <UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic) sqlite3 *database;
@property (nonatomic,copy) NSMutableArray *array;  // all data
@end

@implementation CWeChat

- (void)viewDidLoad {
    [super viewDidLoad];
//        UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:0];
//        item.badgeValue = [NSString stringWithFormat:@"%d",99];
    self.view.backgroundColor = MYColor(234, 234, 234);
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    [self addtableView];
    [self addSearchbar];
    [self addAddIcon];
    [self createTableAndSearch];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createAllTableInSQLiteDatabase];
    [self createTableAndSearch];
    [_tableView reloadData];
}

#pragma mark - 创建数据库中的所有表格
- (void)createAllTableInSQLiteDatabase
{
    // 最近联系人
    NSString *sqlCreateRecentContacts = @"CREATE TABLE IF NOT EXISTS recentContacts (uid INTEGER,remark TEXT,time TEXT,content TEXT,userimage TEXT)";
    [self execSql:sqlCreateRecentContacts];
    //  聊天记录
    NSString *sqlCreateChatRecord = @"CREATE TABLE IF NOT EXISTS chatRecord (time TEXT,content TEXT,fromid INTEGER,toid INTEGER,audiourl TEXT,audiointerval TEXT)";
    [self execSql:sqlCreateChatRecord];
    // 联系人
    NSString *sqlCreateContacts = @"CREATE TABLE IF NOT EXISTS contacts (uid INTEGER,name TEXT,remark TEXT,userimage TEXT,location TEXT,sex TEXT,account TEXT)";
    [self execSql:sqlCreateContacts];
}


- (void)addtableView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self setExtraCellLineHidden:_tableView];
    [self.view addSubview:_tableView];
}

- (void)addSearchbar
{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    searchBar.placeholder = @"搜索";
    [_tableView setTableHeaderView:searchBar];
}

- (void)addAddIcon
{
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.width = 30;
    moreBtn.height = 30;
    [moreBtn setImage:[UIImage imageNamed:@"barbuttonicon_add"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark 加载数据
- (void)createTableAndSearch
{
    NSString *database_path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:DATABASENAME];
    if (sqlite3_open([database_path UTF8String], &_database) != SQLITE_OK) {
        sqlite3_close(_database);
        NSLog(@"database open failed");
    }
    _array = [[NSMutableArray alloc]init];
    [self searchData];
}

#pragma mark - sqlite3 exec
- (void)execSql:(NSString *)sql
{
    char *error;
    if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        sqlite3_close(_database);
        NSLog(@"database exec failed");
    }
}

- (void)searchData
{
    NSString *searchSQL = @"SELECT * FROM recentContacts";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [searchSQL UTF8String], -1, &statement, nil) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            MWeChat *tmp = [[MWeChat alloc]init];

            int uid = (int)sqlite3_column_int(statement, 0);
            tmp.ID = uid;
            
            char *remark = (char *)sqlite3_column_text(statement, 1);
            tmp.remark = [[NSString alloc]initWithUTF8String:remark];
            
            char *time = (char *)sqlite3_column_text(statement, 2);
            tmp.time = [[NSString alloc]initWithUTF8String:time];
            
            char *content = (char *)sqlite3_column_text(statement, 3);
            tmp.content = [[NSString alloc]initWithUTF8String:content];

            char *userimage = (char *)sqlite3_column_text(statement, 4);
            tmp.userImage = [[NSString alloc]initWithUTF8String:userimage];

            [_array addObject:tmp];
        }
        sqlite3_finalize(statement);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VWeChat *cell = [VWeChat cellWithTableView:_tableView];
    MWeChat *obj = _array[indexPath.row];
    cell.mWeChat = obj;
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
    NSIndexPath *idx = [_tableView indexPathForCell:cell];
    switch (index) {
        case 0:
        {
            // unread ball
            
            
            // change sw button
            cell.rightUtilityButtons = [self rightButtonsUnread];
            // change frame
//            NSLog(@"%f %f %f %f",cell.frame.origin.x,cell.frame.origin.y,cell.frame.size.width,cell.frame.size.height);
            NSLog(@"%@ %@",cell.rightUtilityButtons.firstObject,cell.rightUtilityButtons.lastObject);
            
            
        }
            break;
        case 1:
        {
            MWeChat *obj = _array[idx.row];
            NSString *uid = [NSString stringWithFormat:@"%ld",(long)obj.ID];
            [_array removeObjectAtIndex:idx.row];
            NSString *deleteList = [NSString stringWithFormat:@"DELETE FROM recentContacts WHERE uid=%d",[uid intValue]];
            [self execSql:deleteList];
            NSString *deleteRecordFromMe = [NSString stringWithFormat:@"DELETE FROM chatRecord WHERE toid=%d",[uid intValue]];
            [self execSql:deleteRecordFromMe];
            NSString *deleteRecordFromOther = [NSString stringWithFormat:@"DELETE FROM chatRecord WHERE fromid=%d",[uid intValue]];
            [self execSql:deleteRecordFromOther];
            [_tableView deleteRowsAtIndexPaths:@[idx] withRowAnimation:UITableViewRowAnimationTop];
        }
            break;
    }
}

#pragma mark - hide extral cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CChat *cChat = [[CChat alloc]init];
    self.delegate = cChat;
    MWeChat *tmp = _array[indexPath.row];
    NSString *image = tmp.userImage;
    [cChat setTitle:tmp.remark];
    [self.delegate passIDAndUserImage:tmp.ID userImage:image];
    [self.navigationController pushViewController:cChat animated:YES];
}

- (void)receivedNotif:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)click:(UIView *)moreButton
{
    MYMoreMenu *menu = [MYMoreMenu menu];
    MoreFunctionTableViewController *controller = [[MoreFunctionTableViewController alloc]init];
    controller.view.height = 160;
    menu.contentViewController = controller;
    [menu showFrom:moreButton];
}

@end
//
//  CContacts.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/9.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "CContacts.h"
#import "VContacts.h"
#import "ChineseString.h"
#import "pinyin.h"
#import "CDetails.h"
#import "newFriendsView.h"
#import "groupChatViewController.h"
#import "tagViewController.h"
#import "publicViewController.h"
#import "sqlite3.h"
#define DATABASENAME @"chatRecord.sqlite"
#define TABLENAME @"contacts"
@interface CContacts () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSMutableArray *contacts;
@property (nonatomic) sqlite3 *database;
@property (nonatomic,copy) NSMutableArray *dataArr;
@property (nonatomic,copy) NSMutableArray *sortedArrForArrays;
@property (nonatomic,copy) NSMutableArray *sectionHeadsKeys;
// tmp waiting to delete
@property (nonatomic,strong) MContacts *tmp;
@end

@implementation CContacts

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *addContactItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:NO target:self action:@selector(addContact)];
    self.navigationItem.rightBarButtonItem = addContactItem;
    
    _contacts = [[NSMutableArray alloc]init];
    
    [self addSearchBarAndTableView];
    [self createTableAndSearch];
}

- (void)addSearchBarAndTableView
{
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    [searchBar setFrame:CGRectMake(0, 0, 280, 44)];
    searchBar.placeholder = @"搜索";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    self.title = @"通讯录";
    _tableView.tableHeaderView = searchBar;
}

#pragma mark - sqlite3 exec
- (void)execSql:(NSString *)sql
{
    char *error;
    if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        sqlite3_close(_database);
        NSLog(@"error:%s",error);
    }
}

- (void)addContact
{
    NSString *add = [NSString stringWithFormat:@"INSERT INTO '%@' (uid,name,remark,userimage,location,sex,account) VALUES(%d,'%@','%@','%@','%@','%@','%@')",TABLENAME,2,@"wade",@"lighting man",@"dog.jpg",@"miami",@"man",@"lightman"];
    [self execSql:add];
    MContacts *tmp = [[MContacts alloc]init];
    tmp.uid = 2;
    tmp.name = @"wade";
    tmp.remark = @"lighting man";
    tmp.userimage = @"dog.jpg";
    tmp.location = @"miami";
    tmp.sex = @"man";
    tmp.account = @"lightman";
    [_contacts addObject:tmp];
    [self.tableView reloadData];
}

#pragma mark 加载数据
- (void)createTableAndSearch
{
    NSString *database_path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:DATABASENAME];
    if (sqlite3_open([database_path UTF8String], &_database) != SQLITE_OK) {
        sqlite3_close(_database);
        NSLog(@"database open failed");
    }
    [self searchData];
    [self sortData];
    [self.tableView reloadData];
}

- (void)searchData
{
    NSString *searchSQL = [NSString stringWithFormat:@"SELECT * FROM contacts"];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [searchSQL UTF8String], -1, &statement, nil) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            MContacts *tmp = [[MContacts alloc]init];
            
            int uid = sqlite3_column_int(statement, 0);
            tmp.uid = uid;
            
            char *name = (char *)sqlite3_column_text(statement, 1);
            tmp.name = [[NSString alloc]initWithUTF8String:name];
            
            char *remark = (char *)sqlite3_column_text(statement, 2);
            tmp.remark = [[NSString alloc]initWithUTF8String:remark];
            
            char *userimage = (char *)sqlite3_column_text(statement, 3);
            tmp.userimage = [[NSString alloc]initWithUTF8String:userimage];
            
            char *location = (char *)sqlite3_column_text(statement, 4);
            tmp.location = [[NSString alloc]initWithUTF8String:location];
            
            char *sex = (char *)sqlite3_column_text(statement, 5);
            tmp.sex = [[NSString alloc]initWithUTF8String:sex];
            
            char *account = (char *)sqlite3_column_text(statement, 6);
            tmp.account = [[NSString alloc]initWithUTF8String:account];
            
            [_contacts addObject:tmp];
        }
        sqlite3_finalize(statement);
    }
    [self sortData];
}

- (void)sortData
{
    _dataArr = [[NSMutableArray alloc]init];
    _sortedArrForArrays = [[NSMutableArray alloc]init];
    _sectionHeadsKeys = [[NSMutableArray alloc]init];
    _sortedArrForArrays = [self getChineseStringArr:_contacts];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.000000001;
    }else {
    return 10;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sortedArrForArrays count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else {
    return [[self.sortedArrForArrays objectAtIndex:section - 1] count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    return [_sectionHeadsKeys objectAtIndex:section - 1];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionHeadsKeys;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VContacts *cell = [VContacts vContactsWithTableView:tableView];
    if (indexPath.section == 0) {
        MContacts *tmp = [[MContacts alloc]init];
        if (indexPath.row == 0) {
            tmp.remark = @"新的朋友";
            tmp.userimage = @"plugins_FriendNotify";
        }else if (indexPath.row == 1){
            tmp.remark = @"群聊";
            tmp.userimage = @"add_friend_icon_addgroup";
        }else if (indexPath.row == 2){
            tmp.remark = @"标签";
            tmp.userimage = @"Contact_icon_ContactTag";
        }else if (indexPath.row == 3){
            tmp.remark = @"公众号";
            tmp.userimage = @"add_friend_icon_offical";
        }
        cell.contacts = tmp;
    }else {
        if ([self.sortedArrForArrays count] >= indexPath.section) {
            NSArray *arr = [self.sortedArrForArrays objectAtIndex:indexPath.section - 1];
            if ([arr count] > indexPath.row) {
                MContacts *str = [arr objectAtIndex:indexPath.row];
                cell.contacts = str;
                cell.uid = str.uid;
                
            }
        }
    }
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    return cell;
}

#pragma mark - sort
- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort
{
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for(int i = 0; i < [arrToSort count]; i++) {
        MContacts *mcontacts=[[MContacts alloc]init];
        mcontacts = [arrToSort objectAtIndex:i];

        if(mcontacts.remark==nil){
            mcontacts.remark= mcontacts.name;
        }
        
        if(![mcontacts.remark isEqualToString:@""]){
            //join the pinYin
            NSString *pinYinResult = [NSString string];
            for(int j = 0;j < mcontacts.remark.length; j++) {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                 pinyinFirstLetter([mcontacts.remark characterAtIndex:j])]uppercaseString];
                
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            mcontacts.pinYin = pinYinResult;
        } else {
            mcontacts.pinYin = @"";
        }
        [chineseStringsArray addObject:mcontacts];
    }
    
    //sort the ChineseStringArr by pinYin
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex= NO;  //flag to check
    NSMutableArray *TempArrForGrouping = nil;
    
    for(int index = 0; index < [chineseStringsArray count]; index++)
    {
        MContacts *chineseStr = (MContacts *)[chineseStringsArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pinYin];
        NSString *sr= [strchar substringToIndex:1];
//        NSLog(@"%@",sr);        //sr containing here the first character of each string
        if(![_sectionHeadsKeys containsObject:[sr uppercaseString]])//here I'm checking whether the character already in the selection header keys or not
        {
            [_sectionHeadsKeys addObject:[sr uppercaseString]];
            TempArrForGrouping = [[NSMutableArray alloc] init];
            checkValueAtIndex = NO;
        }
        if([_sectionHeadsKeys containsObject:[sr uppercaseString]])
        {
            [TempArrForGrouping addObject:[chineseStringsArray objectAtIndex:index]];
            if(checkValueAtIndex == NO)
            {
                [arrayForArrays addObject:TempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
    }
    return arrayForArrays;
}

#pragma mark - 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击后取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            newFriendsView *newFriends = [[newFriendsView alloc]init];
            newFriends.title = @"新的朋友";
            [self.navigationController pushViewController:newFriends animated:YES];
        }else if (indexPath.row == 1){
            groupChatViewController *groupChat = [[groupChatViewController alloc]init];
            [self.navigationController pushViewController:groupChat animated:YES];
        }else if (indexPath.row == 2){
            tagViewController *view = [[tagViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }else if (indexPath.row == 3){
            publicViewController *publicView = [[publicViewController alloc]init];
            [self.navigationController pushViewController:publicView animated:YES];
        }
    }else {
        CDetails *detail = [[CDetails alloc]init];
        // 隐藏tabbar
        detail.title = @"详细资料";
        VContacts *tmp = [tableView cellForRowAtIndexPath:indexPath];
        self.delegate = detail;
        [self.delegate loadContactDetailInformation:tmp.uid];
        [self.delegate passMContact:tmp.contacts];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
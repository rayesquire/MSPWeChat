//
//  contactsView.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/26.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "contactsView.h"
#import "detailView.h"
#import "newFriendsView.h"
#import "groupChatViewController.h"
#import "tagViewController.h"
#import "publicViewController.h"


@interface contactsView ()
{
    UITableView *_tableView;
    NSMutableArray *_group;
    
}

@end

@implementation contactsView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    UIBarButtonItem *addContactItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:NO target:self action:@selector(addContact)];
    self.navigationItem.rightBarButtonItem = addContactItem;

    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.placeholder = @"搜索";
    
    UITableView *tableContactsView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
//    tableContactsView.delegate = self;
//    tableContactsView.dataSource = self;
    tableContactsView.tableHeaderView = search;
    
//    [self initData];
    
    // 字母索引背景色透明
//    if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
//        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//        _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
//    }
    
    [self.view addSubview:tableContactsView];
    

//    detailView *detail = [[detailView alloc]init];
//    detail.title = @"详细资料";
//    UINavigationController *detailNavigationController = [[UINavigationController alloc]initWithRootViewController:self];
//    
    
    
//    if ([self.view respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.view setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([self.view respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.view setLayoutMargins:UIEdgeInsetsZero];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - 加载数据
//- (void)initData
//{
//    _group = [[NSMutableArray alloc]init];
//    
//    contact *contact0_1 = [[contact alloc]initWithName:@"新的朋友" andImage:@""];
//    contact *contact0_2 = [[contact alloc]initWithName:@"群聊" andImage:@""];
//    contact *contact0_3 = [[contact alloc]initWithName:@"标签" andImage:@""];
//    contact *contact0_4 = [[contact alloc]initWithName:@"公众号" andImage:@""];
//    contactGroup *defaultgroup = [[contactGroup alloc]initWithGroupName:@"" andContactGroup:[NSMutableArray arrayWithObjects:contact0_1,contact0_2,contact0_3,contact0_4,nil]];
//    [_group addObject:defaultgroup];
//    
//    contact *contact1_1 = [[contact alloc]initWithName:@"脖子没事只是在卖萌" andImage:@""];
//    contactGroup *contactgroup1 = [[contactGroup alloc]initWithGroupName:@"B" andContactGroup:[NSMutableArray arrayWithObjects:contact1_1, nil]];
//    [_group addObject:contactgroup1];
//    
//    contact *contact2_1 = [[contact alloc]initWithName:@"蔡青娥" andImage:@""];
//    contact *contact2_2 = [[contact alloc]initWithName:@"陈偲颖" andImage:@""];
//    contact *contact2_3 = [[contact alloc]initWithName:@"陈慧" andImage:@""];
//    contactGroup *contactgroup2 = [[contactGroup alloc]initWithGroupName:@"C" andContactGroup:[NSMutableArray arrayWithObjects:contact2_1,contact2_2,contact2_3, nil]];
//    [_group addObject:contactgroup2];
//
//    contact *contact3_1 = [[contact alloc]initWithName:@"邓洁茹" andImage:@""];
//    contact *contact3_2 = [[contact alloc]initWithName:@"丁琦栋" andImage:@""];
//    contactGroup *contactgroup3 = [[contactGroup alloc]initWithGroupName:@"D" andContactGroup:[NSMutableArray arrayWithObjects:contact3_1,contact3_2, nil]];
//    [_group addObject:contactgroup3];
//}

-(void)addContact{
    ;
}

#pragma mark - 返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _group.count;
}

//#pragma mark - 返回各组行数
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    contactGroup *tmp = _group[section];
//    return tmp.group.count;
//}

#pragma mark - 单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else {
    return 50;
    }
}
//
//#pragma mark - 定义各个单元格
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    contactGroup *tmpGroup = _group[indexPath.section];
//    contact *tmpContact = tmpGroup.group[indexPath.row];
//    
//    NSString *cellIdentifier = @"identifier";
//    UITableViewCell *cell;
//    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//        
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            cell.imageView.image = [UIImage imageNamed:@"plugins_FriendNotify"];
//        }else if (indexPath.row == 1){
//            cell.imageView.image = [UIImage imageNamed:@"add_friend_icon_addgroup"];
//        }else if (indexPath.row == 2){
//            cell.imageView.image = [UIImage imageNamed:@"Contact_icon_ContactTag"];
//        }else if (indexPath.row == 3){
//            cell.imageView.image = [UIImage imageNamed:@"add_friend_icon_offical"];
//        }
//        }
//    else if (indexPath.section == 1){
//        cell.imageView.image = [UIImage imageNamed:@"dog"];
//        }
//    else if (indexPath.section == 2)
//    {
//        if (indexPath.row == 0) {
//            cell.imageView.image = [UIImage imageNamed:@"dog"];
//        }else if (indexPath.row == 1){
//            cell.imageView.image = [UIImage imageNamed:@"dog"];
//        }else if (indexPath.row == 2){
//            cell.imageView.image = [UIImage imageNamed:@"dog"];
//        }
//    }else if (indexPath.section == 3){
//        if (indexPath.row == 0) {
//            cell.imageView.image = [UIImage imageNamed:@"dog"];
//        }else if (indexPath.row == 1){
//            cell.imageView.image = [UIImage imageNamed:@"dog"];
//        }
//    }
//
//    cell.textLabel.text = tmpContact.getName;
////    cell.selectionStyle = UITableViewCellEditingStyleNone;
//    }
//    
//    return cell;
//}

#pragma mark - 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.000001;
    }else {
    return 6;
    }
}

//#pragma mark 返回每组头标题名称
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
////    contactGroup *group=_group[section];
////    return group.getName;
//}

#pragma mark - 设置尾部说明内容高度
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0)
//    {
//        return 15;
//    }else{
//    return 10;
//    }
//}

#pragma mark - 分割线
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

#pragma mark 设置字母索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *indexs=[[NSMutableArray alloc]init];
//    for(contactGroup *group in _group){
//        [indexs addObject:group.getName];
//    }
    return indexs;
}


#pragma mark - 侧滑按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"delete");
    }
    else {
        NSLog(@"other");
    }
}



@end

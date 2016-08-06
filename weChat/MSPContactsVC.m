//
//  MSPContactsVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/6.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPContactsVC.h"
#import "MSPContactModel.h"
#import "MSPContactsCell.h"
#import "MSPContactInformationVC.h"

//#import "pinyin.c"

char pinyinFirstLetter(unsigned short hanzi);

@interface MSPContactsVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) NSArray *listArray;
@property (nonatomic, readwrite, strong) NSArray *iconArray;
@property (nonatomic, readwrite, strong) NSMutableArray *contactsArray;
@property (nonatomic, readwrite, strong) NSMutableArray *sortedArray;
@property (nonatomic, readwrite, strong) NSMutableArray *headerKeyArray;

@end

@implementation MSPContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"通讯录";
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    UIBarButtonItem *addContactItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:NO target:self action:@selector(addContact)];
    self.navigationItem.rightBarButtonItem = addContactItem;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    searchBar.placeholder = @"搜索";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = searchBar;
    
    _listArray = @[@"新的朋友", @"群聊", @"标签", @"公众号"];
    _iconArray = @[@"plugins_FriendNotify", @"add_friend_icon_addgroup", @"Contact_icon_ContactTag", @"add_friend_icon_offical"];
    
    // get contacts datas
    _contactsArray = [NSMutableArray array];
    RLMResults<MSPContactModel *> *results = [MSPContactModel allObjects];
    for (int i = 0; i < results.count; i++) [_contactsArray addObject:[results objectAtIndex:i]];
    // sort
    _sortedArray = [NSMutableArray array];
    _headerKeyArray = [NSMutableArray array];
    _sortedArray = [self getChineseStringArr:_contactsArray];
}

#pragma mark - UITableView delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sortedArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 4;
    else return [_sortedArray[section - 1] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *mspcontactcellIdentifier = @"mspcontactcell";
    MSPContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:mspcontactcellIdentifier];
    if (!cell) cell = [[MSPContactsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:mspcontactcellIdentifier];

    if (indexPath.section == 0) {
        MSPContactModel *model = [[MSPContactModel alloc] init];
        model.remark = _listArray[indexPath.row];
        model.userImage = _iconArray[indexPath.row];
        cell.model = model;
    }
    else if (_sortedArray.count >= indexPath.section) {
        NSArray *array = _sortedArray[indexPath.section - 1];
        if (array.count > indexPath.row) {
            MSPContactModel *model = array[indexPath.row];
            cell.model = model;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 0.000000001;
    else return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return nil;
    else return _headerKeyArray[section - 1];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _headerKeyArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MSPContactModel *model = [_sortedArray[indexPath.section - 1] objectAtIndex:indexPath.row];
    MSPContactInformationVC *con = [[MSPContactInformationVC alloc] init];
    con.model = model;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - sort
- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort {
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for (int i = 0; i < arrToSort.count; i++) {
        MSPContactModel *contact = [[MSPContactModel alloc] init];
        contact = arrToSort[i];
        
        if (!contact.remark) contact.remark = contact.name;
        
        if (![contact.remark isEqualToString:@""]) {
            //join the pinYin
            NSString *pinYinResult = [NSString string];
            for (int j = 0; j < contact.remark.length; j++) {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                 pinyinFirstLetter([contact.remark characterAtIndex:j])]uppercaseString];
                
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            [realm beginWriteTransaction];
            contact.pinYin = pinYinResult;
            [realm commitWriteTransaction];
        }
        else  {
            [realm beginWriteTransaction];
            contact.pinYin = @"";
            [realm commitWriteTransaction];
        }
        
        [chineseStringsArray addObject:contact];
    }
    
    //sort the ChineseStringArr by pinYin
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex = NO;  //flag to check
    NSMutableArray *TempArrForGrouping = nil;
    
    for (int index = 0; index < chineseStringsArray.count; index++) {
        MSPContactModel *chineseStr = (MSPContactModel *)chineseStringsArray[index];
        NSMutableString *strchar = [NSMutableString stringWithString:chineseStr.pinYin];
        NSString *sr = [strchar substringToIndex:1];
        //        NSLog(@"%@",sr);        //sr containing here the first character of each string
        
        //here I'm checking whether the character already in the selection header keys or not
        if (![_headerKeyArray containsObject:sr.uppercaseString]) {
            [_headerKeyArray addObject:sr.uppercaseString];
            TempArrForGrouping = [NSMutableArray array];
            checkValueAtIndex = NO;
        }
        if ([_headerKeyArray containsObject:sr.uppercaseString]) {
            [TempArrForGrouping addObject:chineseStringsArray[index]];
            if (checkValueAtIndex == NO) {
                [arrayForArrays addObject:TempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
    }
    return arrayForArrays;
}


- (void)addContact {

}

@end

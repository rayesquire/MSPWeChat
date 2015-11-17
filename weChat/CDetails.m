//
//  CDetails.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/9.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "CDetails.h"
#import "detailSettings.h"
#import "CChat.h"
#import "sqlite3.h"
#import "MContacts.h"
#define DATABASENAME @"chatRecord.sqlite"
@interface CDetails () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger uid;
@property (nonatomic) sqlite3 *database;
@property (nonatomic,copy) NSMutableArray *contacts;
@property (nonatomic,strong) MContacts *object;
@end

@implementation CDetails

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layout];
}

- (void)layout
{
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    UIBarButtonItem *more = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleDone target:self action:@selector(more)];
    self.navigationItem.rightBarButtonItem = more;
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    self.title = @"详细资料";
    
    UIButton *sendMessage = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendMessage setTitle:@"发消息" forState:UIControlStateNormal];
    [sendMessage.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [sendMessage setFrame:CGRectMake(15, 400, 290, 40)];
    [sendMessage setTintColor:[UIColor whiteColor]];
    sendMessage.layer.masksToBounds = YES;
    sendMessage.layer.cornerRadius = 4;
    sendMessage.backgroundColor = [UIColor greenColor];
    [sendMessage addTarget:self action:@selector(sendMessageView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *facetime = [UIButton buttonWithType:UIButtonTypeSystem];
    [facetime setTitle:@"视频聊天" forState:UIControlStateNormal];
    [facetime.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [facetime setTintColor:[UIColor blackColor]];
    [facetime setFrame:CGRectMake(15, 455, 290, 40)];
    facetime.layer.masksToBounds = YES;
    facetime.layer.cornerRadius = 4;
    facetime.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:facetime];
    [self.view addSubview:sendMessage];
}

- (void)sendMessageView
{
    CChat *chatView = [[CChat alloc]init];
    self.delegate = chatView;
    [self.delegate chatViewWithuid:_uid remark:@"丁凡男神"];
    [chatView setTitle:@"丁凡男神"];
    [self.navigationController pushViewController:chatView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
        VDetails *cell = [[VDetails alloc]init];
        return cell;
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"设置备注和标签";
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"地区";
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"相册";
            }
                break;
        }
    }
    return cell;
}


- (void)more
{
    detailSettings *settings = [[detailSettings alloc]init];
    settings.title = @"资料设置";
    [self.navigationController pushViewController:settings animated:YES];
}

- (void)loadContactDetailInformation:(NSInteger)uid
{
    _uid = uid;
}

- (void)passMContact:(MContacts *)object
{
    _object = object;
}


@end

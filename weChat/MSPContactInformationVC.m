//
//  MSPContactInformationVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/6.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPContactInformationVC.h"
#import "MSPContactModel.h"

@interface MSPContactInformationVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, readwrite, strong) UITableView *tableView;

@end

@implementation MSPContactInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.title = @"详细资料";

    UIBarButtonItem *more = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleDone target:self action:@selector(more)];
    self.navigationItem.rightBarButtonItem = more;

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIButton *sendMessage = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendMessage setTitle:@"发消息" forState:UIControlStateNormal];
    [sendMessage.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [sendMessage setFrame:CGRectMake(15, 400, SCREEN_WIDTH - 30, 40)];
    [sendMessage setTintColor:[UIColor whiteColor]];
    sendMessage.layer.masksToBounds = YES;
    sendMessage.layer.cornerRadius = 4;
    sendMessage.backgroundColor = [UIColor greenColor];
    [sendMessage addTarget:self action:@selector(sendMessageView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *facetime = [UIButton buttonWithType:UIButtonTypeSystem];
    [facetime setTitle:@"视频聊天" forState:UIControlStateNormal];
    [facetime.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [facetime setTintColor:[UIColor blackColor]];
    [facetime setFrame:CGRectMake(15, 455, SCREEN_WIDTH - 30, 40)];
    facetime.layer.masksToBounds = YES;
    facetime.layer.cornerRadius = 4;
    facetime.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:facetime];
    [self.view addSubview:sendMessage];
    
}

- (void)sendMessageView
{
//    CChat *chatView = [[CChat alloc]init];
//    self.delegate = chatView;
//    [self.delegate chatViewWithuid:_uid remark:@"丁凡男神"];
//    [chatView setTitle:@"丁凡男神"];
//    [self.navigationController pushViewController:chatView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) return 2;
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
//        VDetails *cell = [[VDetails alloc]init];
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
//    detailSettings *settings = [[detailSettings alloc]init];
//    settings.title = @"资料设置";
//    [self.navigationController pushViewController:settings animated:YES];
}

@end

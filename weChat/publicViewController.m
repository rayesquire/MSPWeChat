//
//  publicViewController.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/2.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "publicViewController.h"
#import "searchPublicViewController.h"

@interface publicViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation publicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title = @"公众号";
    UITableView *publicView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    publicView.delegate = self;
    publicView.dataSource = self;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(searchPublic)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    
    
    [self.view addSubview:publicView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchPublic
{
    searchPublicViewController *viewController = [[searchPublicViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *identifier = @"identifier";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end
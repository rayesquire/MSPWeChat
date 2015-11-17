//
//  detailView.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/30.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "detailView.h"
#import "detailSettings.h"

@interface detailView ()

@end

@implementation detailView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    UIBarButtonItem *more = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleDone target:self action:@selector(more)];
    self.navigationItem.rightBarButtonItem = more;

}



- (void)more
{
    detailSettings *settings = [[detailSettings alloc]init];
    settings.title = @"资料设置";
    [self.navigationController pushViewController:settings animated:YES];
}

@end

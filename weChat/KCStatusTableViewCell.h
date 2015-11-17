//
//  KCStatusTableViewCell.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/3.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KCStatus;

@interface KCStatusTableViewCell : UITableViewCell

@property (nonatomic,strong) KCStatus *status;

@property (assign,nonatomic) CGFloat height;

@end

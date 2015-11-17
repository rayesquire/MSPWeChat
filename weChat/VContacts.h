//
//  VContacts.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/9.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MContacts;

@interface VContacts : UITableViewCell

@property (nonatomic,strong) MContacts *contacts;

@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) NSInteger uid;

+ (instancetype)vContactsWithTableView:(UITableView *)tableView;

@end
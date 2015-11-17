//
//  VChatList.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/21.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWTableViewCell.h>
@class MWeChat;

@interface VWeChat : SWTableViewCell

@property (nonatomic,copy) MWeChat *mWeChat;

@property (nonatomic,strong) UIImageView *userImage;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UILabel *time;
@property (nonatomic,strong) UILabel *remark;
@property (nonatomic,strong) UILabel *unreadNumber;
@property (nonatomic,assign) NSInteger number;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
//
//  MSPChatListCell.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/7.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSPContactChatModel;

@interface MSPChatListCell : UITableViewCell

@property (nonatomic, readwrite, strong) MSPContactChatModel *model;

@end

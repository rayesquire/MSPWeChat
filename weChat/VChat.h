//
//  VChat.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/14.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MChat.h"

@protocol VChatDelegate <NSObject>

@optional
- (void)longTouch;

@end

@interface VChat : UITableViewCell

@property (nonatomic,strong) MChat *mChat;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UITextView *messageContent;
@property (nonatomic,strong) UIImageView *messageBackground;
@property (nonatomic,strong) UIImageView *audioAnimation;
@property (nonatomic,strong) UILabel *time;
@property (nonatomic,copy) NSString *audiourl;

+ (instancetype)vChatWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) id<VChatDelegate> delegate;

@end
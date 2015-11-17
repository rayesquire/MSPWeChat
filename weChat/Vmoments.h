//
//  Vmoments.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/6.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VmomentsDelegate <NSObject>

@optional
- (void)imageTapGesture:(NSInteger)tag;

@end

@class Mmoments;

@interface Vmoments : UITableViewCell

#pragma mark - declare moments obj
@property (nonatomic,strong) Mmoments *moments;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,strong) UIImageView *userImage;

@property (nonatomic,strong) UILabel *remark;

@property (nonatomic,strong) UILabel *text;

@property (nonatomic,strong) UILabel *where;

@property (nonatomic,strong) UILabel *time;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) id<VmomentsDelegate> delegate;

@end
//
//  VContacts.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/9.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "VContacts.h"
#import "MContacts.h"
#import "ChineseString.h"

#define theRemarkSize 15
#define theUserImageSize 35
#define theSpace 10

@interface VContacts ()
@property (nonatomic,copy) UIImageView *userImage;
@property (nonatomic,copy) UILabel *remark;
@end

@implementation VContacts
+ (instancetype)vContactsWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"cellInChatView";
    VContacts *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[VContacts alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView
{
    _userImage = [[UIImageView alloc]init];
    [self addSubview:_userImage];
    
    _remark = [[UILabel alloc]init];
    _remark.font = [UIFont systemFontOfSize:theRemarkSize];
    [self addSubview:_remark];
    
}

- (void)setContacts:(MContacts *)contacts
{
    CGFloat userImageX = theSpace;
    CGFloat userImageY = theSpace;
    CGRect userImageRect = CGRectMake(userImageX, userImageY, theUserImageSize, theUserImageSize);
    _userImage.frame = userImageRect;
    _userImage.image = [UIImage imageNamed:contacts.userimage];
    
    CGFloat remarkX = CGRectGetMaxX(userImageRect) + theSpace;
    CGSize remarkSize = [contacts.remark sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:theRemarkSize]}];
    CGFloat remarkY = (55 - remarkSize.height) / 2;
    CGRect remarkRect = CGRectMake(remarkX, remarkY, remarkSize.width, remarkSize.height);
    _remark.frame = remarkRect;
    _remark.text = contacts.remark;
    
    _height = CGRectGetMaxY(userImageRect) + theSpace;
}


#pragma mark 重写选择事件，取消选中
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}

@end
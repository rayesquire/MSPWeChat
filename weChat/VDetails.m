//
//  VDetails.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/9.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "VDetails.h"
#import "MDetails.h"

#define theNameSize 12
#define theAccountSize 12
#define theRemarkSize 13
#define thePlaceSize 13
#define theSpace 10

@interface VDetails ()
@property (nonatomic,strong) UIImageView *userImage;
@property (nonatomic,strong) UIImageView *sexImage;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *account;
@property (nonatomic,strong) UILabel *place;
@property (nonatomic,strong) UILabel *remark;
@end

@implementation VDetails

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
    [_remark setTextColor:[UIColor blackColor]];
    [self addSubview:_remark];
    
    _sexImage = [[UIImageView alloc]init];
    [self addSubview:_sexImage];
    
    
    _account = [[UILabel alloc]init];
    _account.font = [UIFont systemFontOfSize:theAccountSize];
    [_account setTextColor:[UIColor grayColor]];
    [self addSubview:_account];

    _name = [[UILabel alloc]init];
    _name.font = [UIFont systemFontOfSize:theNameSize];
    [_name setTextColor:[UIColor grayColor]];
    [self addSubview:_name];
    
    _place = [[UILabel alloc]init];
    _place.font = [UIFont systemFontOfSize:thePlaceSize];
    [_place setTextColor:[UIColor blackColor]];
    [self addSubview:_place];
    
}

- (void)setDetail:(MDetails *)detail
{
    CGFloat userImageX = 15;
    CGFloat userImageY = 10;
    CGRect userImageRect = CGRectMake(userImageX, userImageY, 60, 60);
    _userImage.frame = userImageRect;
    _userImage.image = [UIImage imageNamed:detail.userImage];
    
    CGFloat remarkX = CGRectGetMaxX(userImageRect) + theSpace;
    CGFloat remarkY = 18;
    CGSize remarkSize = [detail.remark sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theRemarkSize]}];
    CGRect remarkRect = CGRectMake(remarkX, remarkY, remarkSize.width, remarkSize.height);
    _remark.frame = remarkRect;
    _remark.text = detail.remark;
    
    CGFloat sexImageX = CGRectGetMaxX(remarkRect) + 1;
    CGFloat sexImageY = remarkY;
    CGSize sexImageSize = [UIImage imageNamed:@"Contact_Male"].size;
    CGRect sexImageRect = CGRectMake(sexImageX, sexImageY, sexImageSize.width, sexImageSize.height);
    _sexImage.frame = sexImageRect;
    if ([detail.sex isEqualToString:@"男"]) {
        _sexImage.image = [UIImage imageNamed:@"Contact_Male"];
    } else if ([detail.sex isEqualToString:@"女"]){
        _sexImage.image = [UIImage imageNamed:@"Contact_Female"];
    }
    
    CGFloat accountX = remarkX;
    CGFloat accountY = CGRectGetMaxY(remarkRect) + theSpace;
    CGSize accountSize = [detail.account sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theAccountSize]}];
    CGRect accountRect = CGRectMake(accountX, accountY, accountSize.width, accountSize.height);
    _account.frame = accountRect;
    _account.text = detail.account;
    
    CGFloat nameX = remarkX;
    CGFloat nameY = CGRectGetMaxY(accountRect) + theSpace / 2;
    CGSize nameSize = [detail.name sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theNameSize]}];
    CGRect nameRect = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    _name.frame = nameRect;
    _name.text = detail.name;

    _height = CGRectGetMaxY(nameRect) +theSpace;
    
}

#pragma mark 重写选择事件，取消选中
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}

@end
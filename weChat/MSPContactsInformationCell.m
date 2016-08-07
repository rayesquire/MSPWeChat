//
//  MSPContactsInformationCell.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/7.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPContactsInformationCell.h"
#import "MSPContactModel.h"

#import "UIImage+getImage.h"

#define theNameSize 13
#define theAccountSize 13
#define theRemarkSize 15

@interface MSPContactsInformationCell ()

@property (nonatomic, readwrite, strong) UIImageView *userImage;
@property (nonatomic, readwrite, strong) UIImageView *sexImage;
@property (nonatomic, readwrite, strong) UILabel *remark;
@property (nonatomic, readwrite, strong) UILabel *account;
@property (nonatomic, readwrite, strong) UILabel *name;

@end

@implementation MSPContactsInformationCell

- (void)setModel:(MSPContactModel *)model {
    
    CGFloat userImageX = THESPACE * 1.5;
    CGFloat userImageY = THESPACE;
    CGRect userImageRect = CGRectMake(userImageX, userImageY, 70, 70);
    _userImage = [[UIImageView alloc] initWithFrame:userImageRect];
    _userImage.image = [UIImage msp_image:model.userImage];
    _userImage.layer.cornerRadius = 5;
    _userImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_userImage];
    
    CGFloat remarkX = CGRectGetMaxX(userImageRect) + THESPACE * 1.5;
    CGFloat remarkY = 16;
    CGSize remarkSize = [model.remark sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theRemarkSize]}];
    CGRect remarkRect = CGRectMake(remarkX, remarkY, remarkSize.width, remarkSize.height);
    _remark = [[UILabel alloc] initWithFrame:remarkRect];
    _remark.font = [UIFont systemFontOfSize:theRemarkSize];
    [_remark setTextColor:[UIColor blackColor]];
    _remark.text = model.remark;
    [self.contentView addSubview:_remark];
    
    CGFloat sexImageX = CGRectGetMaxX(remarkRect) + 1;
    CGFloat sexImageY = remarkY;
    CGSize sexImageSize = [UIImage imageNamed:@"Contact_Male"].size;
    CGRect sexImageRect = CGRectMake(sexImageX, sexImageY, sexImageSize.width, sexImageSize.height);
    _sexImage = [[UIImageView alloc] initWithFrame:sexImageRect];
    if ([model.sex isEqualToString:@"1"]) _sexImage.image = [UIImage imageNamed:@"Contact_Male"];
    else if ([model.sex isEqualToString:@"0"]) _sexImage.image = [UIImage imageNamed:@"Contact_Female"];
    [self.contentView addSubview:_sexImage];
    
    CGFloat accountX = remarkX;
    CGFloat accountY = CGRectGetMaxY(remarkRect) + THESPACE * 0.8;
    CGSize accountSize = [model.account sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theAccountSize]}];
    CGRect accountRect = CGRectMake(accountX, accountY, accountSize.width + 100, accountSize.height);
    _account = [[UILabel alloc] initWithFrame:accountRect];
    _account.font = [UIFont systemFontOfSize:theAccountSize];
    [_account setTextColor:[UIColor grayColor]];
    _account.text = [NSString stringWithFormat:@"微信号:   %@",model.account];
    [self.contentView addSubview:_account];
    
    CGFloat nameX = remarkX;
    CGFloat nameY = CGRectGetMaxY(accountRect) + THESPACE / 2;
    CGSize nameSize = [model.name sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theNameSize]}];
    CGRect nameRect = CGRectMake(nameX, nameY, nameSize.width + 100, nameSize.height);
    _name = [[UILabel alloc] initWithFrame:nameRect];
    _name.font = [UIFont systemFontOfSize:theNameSize];
    [_name setTextColor:[UIColor grayColor]];
    _name.text =[NSString stringWithFormat:@"昵称:   %@",model.name];
    [self.contentView addSubview:_name];
    
}


@end

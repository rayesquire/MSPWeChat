//
//  MSPPersonalInformationCell.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/5.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPPersonalInformationCell.h"
#import "MSPPersonalInformationModel.h"
#import "UIImageView+Webcache.h"
#define NAMEFONT 16
#define ACCOUNTFONT 13
#define IMAGESIZE 60
#define QRCODESIZE 20
#define QRCodeX 40
#define QRCodeY 30

@interface MSPPersonalInformationCell ()

@property (nonatomic,copy) UIImageView *userImage;  // 头像
@property (nonatomic,copy) UIImageView *QRCode;     // 二维码
@property (nonatomic,copy) UILabel *name;           // 昵称
@property (nonatomic,copy) UILabel *account;        // 账号

@end

@implementation MSPPersonalInformationCell

- (void)setRightIcon:(UIImage *)image size:(CGSize)size {
    _QRCode = [[UIImageView alloc] initWithImage:image];
    _QRCode.frame = CGRectMake(SCREEN_WIDTH - QRCodeX - size.width, 7.5, size.width, size.height);
    _QRCode.layer.masksToBounds = YES;
    _QRCode.layer.cornerRadius = 3;
    [self.contentView addSubview:_QRCode];
}

- (void)setModel:(MSPPersonalInformationModel *)model {
    CGFloat userImageX = THESPACE;
    CGFloat userImageY = THESPACE;
    CGRect userImageRect = CGRectMake(userImageX, userImageY, IMAGESIZE, IMAGESIZE);
    _userImage = [[UIImageView alloc] init];
    _userImage.frame = userImageRect;
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = 3;
    _userImage.image = [UIImage imageNamed:model.userImage];
    [self.contentView addSubview:_userImage];
    
    _QRCode = [[UIImageView alloc] init];
    _QRCode.image = [UIImage imageNamed:@"qrcode"];
    _QRCode.frame = CGRectMake(SCREEN_WIDTH - QRCodeX - QRCODESIZE, QRCodeY, QRCODESIZE, QRCODESIZE);
    [self.contentView addSubview:_QRCode];
    
    CGFloat nameX = THESPACE * 2 + IMAGESIZE;
    CGFloat nameY = THESPACE * 2;
    CGSize nameSize = [model.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:NAMEFONT]}];
    CGRect nameRect = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    _name = [[UILabel alloc]init];
    _name.font = [UIFont systemFontOfSize:NAMEFONT];
    _name.textColor = [UIColor blackColor];
    _name.text = model.name;
    _name.frame = nameRect;
    [self.contentView addSubview:_name];
    
    CGFloat accountX = nameX;
    CGFloat accountY = CGRectGetMaxY(nameRect) + THESPACE * 1.5;
    CGSize accountSize = [model.account sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ACCOUNTFONT]}];
    CGRect accountRect = CGRectMake(accountX, accountY, accountSize.width * 2, accountSize.height);
    _account = [[UILabel alloc] init];
    _account.font = [UIFont systemFontOfSize:ACCOUNTFONT];
    _account.textColor = [UIColor blackColor];
    _account.text = [NSString stringWithFormat:@"微信号： %@",model.account];
    _account.frame = accountRect;
    [self.contentView addSubview:_account];
}

@end

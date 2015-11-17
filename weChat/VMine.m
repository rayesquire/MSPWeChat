//
//  VMine.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/9.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "VMine.h"
#import "MMine.h"
#import "UIImageView+Webcache.h"
#define SCREEN_WIDTH 320
#define NAMEFONT 16
#define ACCOUNTFONT 13
#define THESPACE 10
#define IMAGESIZE 60
#define QRCODESIZE 20

@implementation VMine

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier qrcodex:(CGFloat)qrcodex qrcodey:(CGFloat)qrcodey
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.QRCodeX = qrcodex;
        self.QRCodeY = qrcodey;
        [self initView];
    }
    return self;
}

+ (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier qrcodex:(CGFloat)qrcodex qrcodey:(CGFloat)qrcodey
{
    VMine *tmp = [[VMine alloc]initWithStyle:style reuseIdentifier:reuseIdentifier qrcodex:qrcodex qrcodey:qrcodey];
    return tmp;
}

- (void)initView
{
    
    _userImage = [[UIImageView alloc]init];
    [self addSubview:_userImage];
    
    _QRCode = [[UIImageView alloc]init];
    _QRCode.image = [UIImage imageNamed:@"qrcode"];
    [_QRCode setFrame:CGRectMake(self.QRCodeX, self.QRCodeY, QRCODESIZE, QRCODESIZE)];
    [self addSubview:_QRCode];
    
    _name = [[UILabel alloc]init];
    _name.font = [UIFont systemFontOfSize:NAMEFONT];
    [_name setTextColor:[UIColor blackColor]];
    [self addSubview:_name];
    
    _account = [[UILabel alloc]init];
    _account.font = [UIFont systemFontOfSize:ACCOUNTFONT];
    [_account setTextColor:[UIColor blackColor]];
    [self addSubview:_account];
}

- (void)setMMine:(MMine *)mMine
{
    CGFloat userImageX = THESPACE;
    CGFloat userImageY = THESPACE;
    CGRect userImageRect = CGRectMake(userImageX, userImageY, IMAGESIZE, IMAGESIZE);
    _userImage.image = [UIImage imageNamed:@"dog.jpg"];
    _userImage.frame = userImageRect;
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = 3;
    
    
    CGFloat nameX = THESPACE * 2 + IMAGESIZE;
    CGFloat nameY = THESPACE * 2;
    CGSize nameSize = [mMine.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:NAMEFONT]}];
    CGRect nameRect = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    _name.text = mMine.name;
    _name.frame = nameRect;

    CGFloat accountX = nameX;
    CGFloat accountY = CGRectGetMaxY(nameRect) + THESPACE * 1.5;
    CGSize accountSize = [mMine.account sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ACCOUNTFONT]}];
    CGRect accountRect = CGRectMake(accountX, accountY, accountSize.width * 2, accountSize.height);
    _account.text =[NSString stringWithFormat:@"微信号： %@",mMine.account];
    _account.frame = accountRect;

}

@end
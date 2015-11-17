//
//  VMine.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/9.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class VMine;
//
//@protocol vMineDelegate <NSObject>
//
//- (void)clickUserImage:(VMine *)cell;
//
//@end

@class MMine;

@interface VMine : UITableViewCell

@property (nonatomic,strong) MMine *mMine;
@property (nonatomic,assign) CGFloat QRCodeX;
@property (nonatomic,assign) CGFloat QRCodeY;
@property (nonatomic,copy) UIImageView *userImage;  // 头像
@property (nonatomic,copy) UIImageView *QRCode;     // 二维码
@property (nonatomic,copy) UILabel *name;           // 昵称
@property (nonatomic,copy) UILabel *account;        // 账号

//@property (nonatomic,assign) id<vMineDelegate> delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier qrcodex:(CGFloat)qrcodex qrcodey:(CGFloat)qrcodey;

+ (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier qrcodex:(CGFloat)qrcodex qrcodey:(CGFloat)qrcodey;







@end

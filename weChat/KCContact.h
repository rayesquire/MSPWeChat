//
//  KCContact.h
//  weChat
//
//  Created by 尾巴超大号 on 15/7/27.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCContact : NSObject

#pragma mark 姓
@property (nonatomic,copy) NSString *firstName;
#pragma mark 名
@property (nonatomic,copy) NSString *lastName;
#pragma mark 手机号码
@property (nonatomic,copy) NSString *phoneNumber;

- (KCContact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber;

- (NSString *)getName;

+ (KCContact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber;

@end
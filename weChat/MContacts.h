//
//  contact.h
//  weChat
//
//  Created by 尾巴超大号 on 15/7/29.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MContacts : NSObject

@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *userimage;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,assign) NSInteger uid;
@property (nonatomic,copy) NSString *account;

@property (nonatomic,copy) NSString *pinYin;

- (MContacts *)initWithDictionary:(NSDictionary *)dic;

+ (MContacts *)initWithDictionary:(NSDictionary *)dic;


@end

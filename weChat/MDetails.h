//
//  MDetails.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/9.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDetails : NSObject

@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *place;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *userImage;

- (MDetails *)initWithDictionary:(NSDictionary *)dic;

+ (MDetails *)detailsWithDictionary:(NSDictionary *)dic;

@end
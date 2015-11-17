//
//  KCStatus.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/3.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCStatus : NSObject

#pragma mark - 属性
@property (nonatomic,copy) NSString *profileImageUrl;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *createdAt;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *mbtype;

- (KCStatus *)initWithDictionary:(NSDictionary *)dic;

+ (KCStatus *)initWithDictionary:(NSDictionary *)dic;

@end

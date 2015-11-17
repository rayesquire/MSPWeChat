//
//  Mmoments.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/6.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mmoments : NSObject

#pragma mark - property

@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *where;
@property (nonatomic,copy) NSMutableArray *images;
@property (nonatomic,copy) NSString *userImage;
@property (nonatomic,copy) NSString *text;

#pragma mark - mathods

- (Mmoments *)initWithDictionary:(NSDictionary *)dic;

+ (Mmoments *)momentsWithDictionary:(NSDictionary *)dic;

@end
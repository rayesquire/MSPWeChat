//
//  Mmoments.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/6.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "Mmoments.h"

@implementation Mmoments

#pragma mark - use methods

- (Mmoments *)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.remark = dic[@"remark"];
        self.images = dic[@"images"];
        self.text = dic[@"text"];
        self.where = dic[@"where"];
        self.time = dic[@"time"];
        self.userImage = dic[@"userImage"];
    }
    return self;
}

+ (Mmoments *)momentsWithDictionary:(NSDictionary *)dic
{
    Mmoments *moments = [[Mmoments alloc]initWithDictionary:dic];
    return moments;
}

@end
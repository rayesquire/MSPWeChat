//
//  MDetails.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/9.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "MDetails.h"

@implementation MDetails

- (MDetails *)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.sex = dic[@"sex"];
        self.place = dic[@"place"];
        self.account = dic[@"account"];
        self.remark = dic[@"remark"];
        self.userImage = dic[@"userImage"];
    }
    return self;
}

+ (MDetails *)detailsWithDictionary:(NSDictionary *)dic
{
    MDetails *detail = [[MDetails alloc]initWithDictionary:dic];
    return detail;
}

@end
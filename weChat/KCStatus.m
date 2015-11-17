//
//  KCStatus.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/3.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "KCStatus.h"

@implementation KCStatus

- (KCStatus *)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.profileImageUrl = dic[@"profileImaegUrl"];
        self.userName = dic[@"userName"];
        self.mbtype = dic[@"mbtype"];
        self.text = dic[@"text"];
    }
    return self;
}

+ (KCStatus *)initWithDictionary:(NSDictionary *)dic
{
    KCStatus *status = [[KCStatus alloc]initWithDictionary:dic];
    return status;
}

- (NSString *)source{
    return [NSString stringWithFormat:@"前"];
}
@end

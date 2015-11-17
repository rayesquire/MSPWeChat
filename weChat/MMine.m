//
//  MMine.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/9.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "MMine.h"

@implementation MMine

- (MMine *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.name = dic[@"name"];
        self.userImage = dic[@"userImage"];
        self.account = dic[@"account"];
    }
    return self;
}

+ (MMine *)MineWithDictionary:(NSDictionary *)dic
{
    MMine *mine = [[MMine alloc]initWithDictionary:dic];
    return mine;
}

@end

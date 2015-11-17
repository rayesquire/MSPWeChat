//
//  MChatList.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/21.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "MWeChat.h"

@implementation MWeChat

- (MWeChat *)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.remark = dic[@"remark"];
        self.userImage = dic[@"userImage"];
        self.content = dic[@"content"];
        self.time = dic[@"time"];
    }
    return self;
}

+ (MWeChat *)initWithDictionary:(NSDictionary *)dic
{
    MWeChat *mChatList = [[MWeChat alloc]initWithDictionary:dic];
    return mChatList;
}

@end

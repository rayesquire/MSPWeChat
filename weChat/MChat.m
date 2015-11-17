
//
//  MChat.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/14.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "MChat.h"

@implementation MChat

- (MChat *)initWithDictionary:(NSMutableDictionary *)dic 
{
    self = [super init];
    if (self) {
        self.content = dic[@"text"];
    }
    return self;
}

+ (MChat *)mChatWithDictionary:(NSMutableDictionary *)dic
{
    MChat *tmp = [[MChat alloc]initWithDictionary:dic];
    return tmp;
}

- (MChat *)initWithTime:(NSString *)time content:(NSString *)content from:(NSInteger)fromid to:(NSInteger)toid audiourl:(NSString *)url audioInterval:(NSString *)audioInterval
{
    self = [super init];
    if (self) {
        self.time = time;
        self.from = fromid;
        self.to = toid;
        self.content = content;
        self.audiourl = url;
        self.audioInterval = audioInterval;
    }
    return self;
}

@end
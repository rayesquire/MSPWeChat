//
//  contact.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/29.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "MContacts.h"

@implementation MContacts


- (MContacts *)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        ;
    }
    return self;
}

+ (MContacts *)initWithDictionary:(NSDictionary *)dic
{
    MContacts *contact = [[MContacts alloc]initWithDictionary:dic];
    return contact;
}

@end
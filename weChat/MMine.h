//
//  MMine.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/9.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMine : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *userImage;

- (MMine *)initWithDictionary:(NSDictionary *)dic;

+ (MMine *)MineWithDictionary:(NSDictionary *)dic;

@end
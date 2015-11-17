//
//  MChatList.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/21.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWeChat : NSObject

@property (nonatomic,copy) NSString *remark;     // name
@property (nonatomic,copy) NSString *time;       // time
@property (nonatomic,copy) NSString *content;       // text
@property (nonatomic,copy) NSString *userImage;  // image
@property (nonatomic,assign) NSInteger ID;

- (MWeChat *)initWithDictionary:(NSDictionary *)dic;

+ (MWeChat *)initWithDictionary:(NSDictionary *)dic;

@end
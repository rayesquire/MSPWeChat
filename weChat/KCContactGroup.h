//
//  KCContactGroup.h
//  weChat
//
//  Created by 尾巴超大号 on 15/7/27.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCContact.h"

@interface KCContactGroup : NSObject

#pragma mark 组名
@property (nonatomic,copy) NSString *name;
#pragma mark 分组描述
@property (nonatomic,copy) NSString *detail;
#pragma mark 联系人
@property (nonatomic,copy) NSMutableArray *contacts;

- (KCContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

+ (KCContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

@end

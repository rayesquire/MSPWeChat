//
//  CDetails.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/9.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDetails.h"
#import "VDetails.h"
#import "CContacts.h"

@protocol ChatViewWithuid <NSObject>

@optional
- (void)chatViewWithuid:(NSInteger)uid remark:(NSString *)remark;

@end
@interface CDetails : UIViewController <LoadContactDetailInformationDelegate>

@property (nonatomic) id<ChatViewWithuid> delegate;

@end
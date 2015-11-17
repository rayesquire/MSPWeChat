//
//  CContacts.h
//  weChat
//
//  Created by 尾巴超大号 on 15/8/9.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MContacts.h"

@protocol LoadContactDetailInformationDelegate <NSObject>
@optional
- (void)loadContactDetailInformation:(NSInteger)uid;

- (void)passMContact:(MContacts *)object;
@end

@interface CContacts : UIViewController

@property (nonatomic) id<LoadContactDetailInformationDelegate> delegate;

@end

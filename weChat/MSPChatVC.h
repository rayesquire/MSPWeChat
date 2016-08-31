//
//  MSPChatVC.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/8.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSPContactChatModel.h"
@interface MSPChatVC : UIViewController

@property (nonatomic, readwrite, assign) NSInteger uid;

@property (nonatomic, readwrite, strong) MSPContactChatModel *model;

@end

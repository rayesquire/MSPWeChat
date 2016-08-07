//
//  MSPContactChatModel.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/7.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPContactModel.h"

@interface MSPContactChatModel : MSPContactModel

@property (nonatomic, readwrite, assign) NSInteger time;
@property (nonatomic, readwrite, copy) NSString *content;


@end

//
//  MSPChatModel.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/8.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPContactModel.h"

@interface MSPChatModel : MSPContactModel

@property (nonatomic, readwrite, copy) NSString *content;
@property (nonatomic, readwrite, copy) NSString *time;
@property (nonatomic, readwrite, assign) NSInteger posterUid; //发送方的uid
@property (nonatomic, readwrite, assign) NSInteger accepterUid; //
@property (nonatomic, readwrite, assign) BOOL isAudio;
@property (nonatomic, readwrite, copy) NSString *audioURL;
@property (nonatomic, readwrite, assign) NSTimeInterval audioTimeInterval;


@end

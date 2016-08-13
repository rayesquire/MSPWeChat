//
//  MSPChatPaoPaoView.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/8.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSPChatModel;

@interface MSPChatPaoPaoView : UIView

- (instancetype)initWithModel:(MSPChatModel *)model;

@property (nonatomic, readonly, assign) CGSize size;

@end

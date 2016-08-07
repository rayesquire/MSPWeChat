//
//  MSPBinaryButton.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/7.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSPContactModel;

@protocol MSPBinaryButtonDelegate <NSObject>

- (void)clickWithMessage;
- (void)clickWithVideo;

@end

@interface MSPBinaryButton : UIView

@property (nonatomic, readwrite, weak) id <MSPBinaryButtonDelegate> delegate;

@end

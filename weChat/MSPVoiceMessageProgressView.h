//
//  MSPVoiceMessageProgressView.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/14.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MSPVoiceViewStatusValue) {
    MSPVoiceViewRecordBegin = 0,
    MSPVoiceViewRecordHoldInside = 1,
    MSPVoiceViewRecordHoldOutside = 2,
    MSPVoiceViewRecordReleaseInside = 3,
    MSPVoiceViewRecordReleaseOutside = 4
};

@interface MSPVoiceMessageProgressView : UIView

- (void)updateProgress:(CGFloat)power;

- (void)updateStatus:(MSPVoiceViewStatusValue)status value:(NSTimeInterval)value;

@end

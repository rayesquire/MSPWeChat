//
//  Input.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/25.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@protocol InputBarDelegate <NSObject>

@optional
- (void)voiceTouchUpInside;
- (void)voiceHoldOnTouchDown;
- (void)voiceHoldOnTouchUpInside;
- (void)voiceHoldOnTouchUpOutside;
- (void)voiceHoldOnTouchDragInside;
- (void)voiceHoldOnTouchDragOutside;
- (void)faceClick;
- (void)addClick;
@end

@interface InputBar : UIView

@property (nonatomic,strong) UIButton *voice;
@property (nonatomic,strong) UIButton *voiceHoldOn;
@property (nonatomic,strong) UITextView *input;
@property (nonatomic,strong) UIButton *face;
@property (nonatomic,strong) UIButton *add;
@property (nonatomic,assign) CGRect originalFrame;
@property (nonatomic,assign) BOOL keyboard;
@property (nonatomic,assign) CGRect currentFrame;

@property (nonatomic) id<InputBarDelegate> delegate;

@end

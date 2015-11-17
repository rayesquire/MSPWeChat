//
//  Input.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/25.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "InputBar.h"
#import "AppDelegate.h"
#define MYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation InputBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MYColor(234, 234, 234);
        self.frame = CGRectMake(0, CGRectGetMinY(frame), SCREENWIDTH, CGRectGetHeight(frame));
        
        self.voice.tag = 1;
        self.face.tag = 2;
        self.add.tag = 3;
        self.input.tag = 5;
        self.keyboard = NO;
        self.currentFrame = self.frame;

    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _originalFrame = frame;
}

- (void)setOriginalFrame:(CGRect)originalFrame
{
    self.frame = CGRectMake(0, CGRectGetMinY(originalFrame), SCREENWIDTH, CGRectGetHeight(originalFrame));
}

#pragma mark - voice button
- (UIButton *)voice
{
    if (!_voice) {
        _voice = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voice setFrame:CGRectMake(2, 8, 33, 33)];
        [_voice setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [_voice setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateSelected];
        [_voice addTarget:self.delegate action:@selector(voiceTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_voice];
    }
    return _voice;
}

- (void)voiceTouchUpInside
{
    if ([self.delegate respondsToSelector:@selector(voiceTouchUpInside)]) {
        [self.delegate voiceTouchUpInside];
    }
}

#pragma mark - voiceHoldOn button
- (UIButton *)voiceHoldOn
{
    if (!_voiceHoldOn) {
        _voiceHoldOn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceHoldOn setFrame:self.input.frame];
        [_voiceHoldOn setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_voiceHoldOn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_voiceHoldOn setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1] forState:UIControlStateNormal];
        UIImage *normal = [UIImage imageNamed:@"VoiceBtn_Black"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30) resizingMode:UIImageResizingModeStretch];
        [_voiceHoldOn setBackgroundImage:normal forState:UIControlStateNormal];
        UIImage *selected = [UIImage imageNamed:@"VoiceBtn_BlackHL"];
        selected = [selected resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30) resizingMode:UIImageResizingModeStretch];
        [_voiceHoldOn setBackgroundImage:selected forState:UIControlStateSelected];
        [_voiceHoldOn setHidden:YES];
        [_voiceHoldOn addTarget:self.delegate action:@selector(voiceHoldOnTouchDown) forControlEvents:UIControlEventTouchDown];
        [_voiceHoldOn addTarget:self.delegate action:@selector(voiceHoldOnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [_voiceHoldOn addTarget:self.delegate action:@selector(voiceHoldOnTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [_voiceHoldOn addTarget:self.delegate action:@selector(voiceHoldOnTouchDragInside) forControlEvents:UIControlEventTouchDragInside];
        [_voiceHoldOn addTarget:self.delegate action:@selector(voiceHoldOnTouchDragOutside) forControlEvents:UIControlEventTouchDragOutside];
        [self addSubview:_voiceHoldOn];
    }
    return _voiceHoldOn;
}

- (void)voiceHoldOnTouchDown
{
    if ([self.delegate respondsToSelector:@selector(voiceHoldOnTouchDown)]) {
        [self.delegate voiceHoldOnTouchDown];
    }
}

- (void)voiceHoldOnTouchUpInside
{
    if ([self.delegate respondsToSelector:@selector(voiceHoldOnTouchUpInside)]) {
        [self.delegate voiceHoldOnTouchUpInside];
    }
}

- (void)voiceHoldOnTouchUpOutside
{
    if ([self.delegate respondsToSelector:@selector(voiceHoldOnTouchUpOutside)]) {
        [self.delegate voiceHoldOnTouchUpOutside];
    }
}

- (void)voiceHoldOnTouchDragInside
{
    if ([self.delegate respondsToSelector:@selector(voiceHoldOnTouchDragInside)]) {
        [self.delegate voiceHoldOnTouchDragInside];
    }
}

- (void)voiceHoldOnTouchDragOutside
{
    if ([self.delegate respondsToSelector:@selector(voiceHoldOnTouchDragOutside)]) {
        [self.delegate voiceHoldOnTouchDragOutside];
    }
}

#pragma mark - face button
- (UIButton *)face
{
    if (!_face) {
        _face = [UIButton buttonWithType:UIButtonTypeCustom];
        [_face setFrame:CGRectMake(SCREENWIDTH - 66 - 5, 8, 33, 33)];
        [_face setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [_face setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateSelected];
        [self addSubview:_face];
    }
    return _face;
}

- (UIButton *)add
{
    if (!_add) {
        _add = [UIButton buttonWithType:UIButtonTypeCustom];
        [_add setFrame:CGRectMake(SCREENWIDTH - 2 - 33, 8, 33, 33)];
        [_add setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [_add setImage:[UIImage imageNamed:@"TypeSelectorBtn_BlackHL"] forState:UIControlStateSelected];
        [self addSubview:_add];
    }
    return _add;
}

- (UITextView *)input
{
    if (!_input) {
        _input = [[UITextView alloc]initWithFrame:CGRectMake(33 + 5, 5, SCREENWIDTH - 15 - 99, 39)];
        [_input setFont:[UIFont systemFontOfSize:16]];
        _input.layer.borderColor = MYColor(200, 200, 200).CGColor;
        _input.layer.borderWidth = 1;
        _input.layer.masksToBounds = YES;
        _input.layer.cornerRadius = 5;
        _input.scrollEnabled = NO;
        _input.showsHorizontalScrollIndicator = NO;
        _input.enablesReturnKeyAutomatically = YES;
        _input.returnKeyType = UIReturnKeySend;
        [self addSubview:_input];
    }
    return _input;
}

//#pragma mark - convert xy
//- (CGFloat)convertYToWindow:(float)Y
//{
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    CGPoint O = [self.superview convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
//    return O.y;
//}
//
//- (CGFloat)convertYFromWindow:(float)Y
//{
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    CGPoint O = [appDelegate.window convertPoint:CGPointMake(0, Y) toView:self.superview];
//    return O.y;
//}

- (float)getHeightOfWindow
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate.window.frame.size.height;
}

@end

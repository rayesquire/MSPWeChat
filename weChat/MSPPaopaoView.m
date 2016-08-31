//
//  MSPPaopaoView.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/15.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPPaopaoView.h"

@interface MSPPaopaoView ()

@property (nonatomic, readwrite, strong) UITextView *textView;
@property (nonatomic, readwrite, strong) UIImageView *playVoiceView;

@end

@implementation MSPPaopaoView

- (instancetype)initWithModel:(MSPChatModel *)model {
    if (self = [super init]) {
        
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.scrollEnabled = NO;
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor clearColor];
        [self addSubview:_textView];
        
    }
    return self;
}

- (void)updateConstraints {
    CAShapeLayer *_maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;
    //非常关键设置自动拉伸的效果且不变形
    _maskLayer.contents = (id)[UIImage imageNamed:@"gray_bubble_right@2x.png"].CGImage;
    CALayer *_contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
    

}

@end

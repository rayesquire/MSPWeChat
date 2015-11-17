//
//  RecordVoice.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/29.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "RecordVoice.h"

@implementation RecordVoice

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:50/255 green:50/255 blue:50/255 alpha:0.5];

        self.leftImage = self.setLeftImage;
        self.rightImage = self.setRightImage;
        self.centerImage = self.setCenterImage;
        self.label = self.setLabel;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (UIImageView *)setLeftImage
{
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc]init];
        [_leftImage setImage:[UIImage imageNamed:@"RecordingBkg"]];
        [_leftImage setFrame:CGRectMake(self.frame.size.width / 12, self.frame.size.height / 8, self.frame.size.width / 2, self.frame.size.height * 0.7)];
        [_leftImage setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_leftImage];
    }
    return _leftImage;
}

- (UIImageView *)setRightImage
{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
        [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal001"]];
        [_rightImage setFrame:CGRectMake(self.frame.size.width * 0.6, self.frame.size.height / 8, self.frame.size.width / 2, self.frame.size.height * 0.7)];
        [_rightImage setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_rightImage];
    }
    return _rightImage;
}

- (UIImageView *)setCenterImage
{
    if (!_centerImage) {
        _centerImage = [[UIImageView alloc]init];
        [_centerImage setImage:[UIImage imageNamed:@"RecordCancel"]];
        [_centerImage setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_centerImage setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_centerImage];
    }
    return _centerImage;
}

- (UILabel *)setLabel
{
    if (!_label) {
        _label = [[UILabel alloc]init];
        [self setLabelFrame:@"手指上滑，取消发送" font:14];
        [_label setTextColor:[UIColor whiteColor]];
        [_label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_label];
    }
    return _label;
}

- (void)setLabelFrame:(NSString *)title font:(CGFloat)font
{
    [_label setText:title];
    [_label setFont:[UIFont systemFontOfSize:font]];
    CGSize size = [_label.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    [_label setFrame:CGRectMake(self.frame.size.width / 2 - size.width / 2, self.frame.size.height - 5 - size.height, size.width, size.height)];
}

@end

//
//  MSPVoiceMessageProgressView.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/14.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPVoiceMessageProgressView.h"

@interface MSPVoiceMessageProgressView ()

@property (nonatomic, readwrite, strong) UIImageView *leftImage;
@property (nonatomic, readwrite, strong) UIImageView *rightImage;
@property (nonatomic, readwrite, strong) UIImageView *centerImage;
@property (nonatomic, readwrite, strong) UILabel *label;

@end

@implementation MSPVoiceMessageProgressView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 2 - SCREEN_WIDTH / 4, SCREEN_WIDTH / 2, SCREEN_WIDTH / 2)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TheColor(70, 70, 70, 0.5);
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH / 2, SCREEN_WIDTH / 2);
        self.leftImage.tag = 1;
        self.rightImage.tag = 2;
        self.centerImage.tag = 3;
        self.label.tag = 4;
    }
    return self;
}

- (void)updateProgress:(CGFloat)power {
    if (power <= 95)       [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal001"]];
    else if (power <= 100) [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal002"]];
    else if (power <= 105) [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal003"]];
    else if (power <= 110) [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal004"]];
    else if (power <= 115) [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal005"]];
    else if (power <= 120) [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal006"]];
    else if (power <= 125) [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal007"]];
    else                   [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal008"]];
}

- (void)updateStatus:(MSPVoiceViewStatusValue)status value:(NSTimeInterval)value {
    switch (status) {
        case MSPVoiceViewRecordBegin: {
            [self setHidden:NO];
            [_centerImage setHidden:YES];
            [_leftImage setHidden:NO];
            [_rightImage setHidden:NO];
            [self setLabelFrame:@"手指上滑，取消发送" font:14];
            [_label setBackgroundColor:[UIColor clearColor]];
            break;
        }
        case MSPVoiceViewRecordHoldInside: {
            [_leftImage setHidden:NO];
            [_rightImage setHidden:NO];
            [_centerImage setHidden:YES];
            [_label setText:@"手指上滑，取消发送"];
            [_label setBackgroundColor:[UIColor clearColor]];
            break;
        }
        case MSPVoiceViewRecordHoldOutside: {
            [_leftImage setHidden:YES];
            [_rightImage setHidden:YES];
            [_centerImage setHidden:NO];
            [_label setText:@"松开手指，取消发送"];
            [_label setBackgroundColor:MYColor(200, 0, 0)];
            break;
        }
        case MSPVoiceViewRecordReleaseInside: {
            if (value < 1) {
                [_leftImage setHidden:YES];
                [_rightImage setHidden:YES];
                [_centerImage setImage:[UIImage imageNamed:@"MessageTooShort"]];
                [_centerImage setHidden:NO];
                [self setLabelFrame:@"说话时间太短" font:14];
                [_label setBackgroundColor:[UIColor clearColor]];
            }
            else [self setHidden:YES];
            break;
        }
        case MSPVoiceViewRecordReleaseOutside: {
            [self setHidden:YES];
            break;
        }
    }
}

- (UIImageView *)leftImage {
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] init];
        [_leftImage setImage:[UIImage imageNamed:@"RecordingBkg"]];
        [_leftImage setFrame:CGRectMake(self.frame.size.width / 12, self.frame.size.height / 8, self.frame.size.width / 2, self.frame.size.height * 0.7)];
        [_leftImage setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_leftImage];
    }
    return _leftImage;
}

- (UIImageView *)rightImage {
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc] init];
        [_rightImage setImage:[UIImage imageNamed:@"RecordingSignal001"]];
        [_rightImage setFrame:CGRectMake(self.frame.size.width * 0.6, self.frame.size.height / 8, self.frame.size.width / 2, self.frame.size.height * 0.7)];
        [_rightImage setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_rightImage];
    }
    return _rightImage;
}

- (UIImageView *)centerImage {
    if (!_centerImage) {
        _centerImage = [[UIImageView alloc] init];
        [_centerImage setImage:[UIImage imageNamed:@"RecordCancel"]];
        [_centerImage setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_centerImage setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_centerImage];
    }
    return _centerImage;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        [self setLabelFrame:@"手指上滑，取消发送" font:14];
        [_label setTextColor:[UIColor whiteColor]];
        [_label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_label];
    }
    return _label;
}

- (void)setLabelFrame:(NSString *)title font:(CGFloat)font {
    [_label setText:title];
    [_label setFont:[UIFont systemFontOfSize:font]];
    CGSize size = [_label.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    [_label setFrame:CGRectMake(self.frame.size.width / 2 - size.width / 2, self.frame.size.height - 5 - size.height, size.width, size.height)];
}


@end

//
//  MSPChatPaoPaoView.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/8.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPChatPaoPaoView.h"
#import "MSPChatModel.h"

#import "UIView+Extension.h"

#import <Masonry.h>

@interface MSPChatPaoPaoView ()

@property (nonatomic, readwrite, strong) UIImageView *backgroundView;
@property (nonatomic, readwrite, strong) UITextView *textView;

@end

@implementation MSPChatPaoPaoView

- (instancetype)initWithModel:(MSPChatModel *)model {
    if ([super init]) {
        self.backgroundColor = [UIColor clearColor];
        if (model.posterUid == [[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] integerValue]) {
            _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SenderTextNodeBkg"]];
        }
        else {
            UIImage *image = [UIImage imageNamed:@"SenderTextNodeBkg"];
            UIImage *bkg = [UIImage imageWithCIImage:image.CIImage scale:image.scale orientation:UIImageOrientationUpMirrored];
            _backgroundView = [[UIImageView alloc] initWithImage:bkg];
        }
        _backgroundView.image = nil;
        _backgroundView.backgroundColor = [UIColor yellowColor];
//        [self addSubview:_backgroundView];
        _textView = [[UITextView alloc] init];
        _textView.scrollEnabled = NO;
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor yellowColor];
        _textView.font = [UIFont systemFontOfSize:16];
        [self addSubview:_textView];
        if (model.isAudio) {
            
        }
        else {
            _textView.text = model.content;
            [_textView sizeToFit];
        }
        [_textView mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(self.mas_left);
            maker.top.equalTo(self.mas_top);
            maker.width.lessThanOrEqualTo(@(SCREEN_WIDTH - 120));
            maker.height.greaterThanOrEqualTo(@(40));
        }];
        self.frame = _textView.frame;
    }
    return self;
}

@end

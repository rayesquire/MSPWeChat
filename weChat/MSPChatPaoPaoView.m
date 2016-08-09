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
        [self addSubview:_backgroundView];
        _textView = [[UITextView alloc] init];
        _textView.scrollEnabled = NO;
        _textView.editable = NO;
        _textView.userInteractionEnabled = YES;
        _textView.backgroundColor = [UIColor clearColor];
        if (model.isAudio) {
            
        }
        else {
            _textView.text = model.content;
            CGSize size = [model.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            if (size.width > SCREEN_WIDTH - 110) {
                _textView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 110, 200);
            }
            else {
                _textView.frame = CGRectMake(0, 0, size.width, 200);
            }
            _textView.height = _textView.contentSize.height;
        }
        [_backgroundView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(_backgroundView.mas_left).width.offset(5);
            maker.right.equalTo(_backgroundView.mas_right).width.offset(-5);
            maker.top.equalTo(_backgroundView.mas_top);
            maker.bottom.equalTo(_backgroundView.mas_bottom);
        }];
    }
    return self;
}

@end

//
//  VChat.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/14.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "VChat.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"
#define THESPACE 10
#define IMAGESIZE 41
#define TEXTSIZE 15
#define SCREEMWIDTH [UIScreen mainScreen].bounds.size.width

@interface VChat ()

@end

#pragma mark - calculate textsize
@implementation NSString (Extension)
- (CGSize)sizeWithContent:(NSString *)content fontOfSize:(CGFloat)fontSize
{
    CGSize size = [content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    return size;
}
@end

//////////////////////////////////////
@implementation VChat

+ (instancetype)vChatWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"cellInChatView";
    VChat *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[VChat alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        _userImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_userImageView];

        _messageBackground = [[UIImageView alloc]init];
        [self.contentView addSubview:_messageBackground];
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self.delegate action:@selector(longTouch)];
        [_messageBackground addGestureRecognizer:gesture];
        _messageBackground.userInteractionEnabled = YES;
        
        _messageContent = [[UITextView alloc]init];
        _messageContent.editable = NO;
        _messageContent.scrollEnabled = NO;
        [_messageContent setContentInset:UIEdgeInsetsMake(0, 0, 0, 1)];
        [_messageContent setTextColor:[UIColor blackColor]];
        [_messageContent setBackgroundColor:[UIColor clearColor]];
        [_messageBackground addSubview:_messageContent];
        _messageContent.userInteractionEnabled = NO;
        
        _audioAnimation = [[UIImageView alloc]init];
        [_messageBackground addSubview:_audioAnimation];
        
        _time = [[UILabel alloc]init];
        [_time setFont:[UIFont systemFontOfSize:12]];
        [_time setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:_time];

    }
    return self;
}

- (void)setMChat:(MChat *)mChat
{
    CGFloat userImageX,messageContentX,messageContentY,contentWidth;
    // audio message
    if (![mChat.audiourl isEqualToString:@"no"])
    {
        _messageContent.text = @"           ";
        for (int i = 0; i < [mChat.audioInterval intValue]; i++) {
            if (i < 10) {
                _messageContent.text = [NSString stringWithFormat:@"  %@",_messageContent.text];
            }else if (i < 60){
                _messageContent.text = [NSString stringWithFormat:@" %@",_messageContent.text];
            }
        }
        [_time setText:[NSString stringWithFormat:@"%d''",[mChat.audioInterval intValue] + 1]];
        [_time setHidden:NO];
        [_audioAnimation setHidden:NO];
    }
    // text message
    else
    {
        _messageContent.text = mChat.content;
        [_time setText:@"no"];
        [_time setHidden:YES];
        [_audioAnimation setHidden:YES];
    }
    CGSize contentSize = [mChat.content sizeWithContent:mChat.content fontOfSize:TEXTSIZE];
    messageContentY = THESPACE + IMAGESIZE / 2 - contentSize.height / 2;
    // message from me
    if (mChat.from == 1) {
        _userImageView.image = [UIImage imageNamed:@"dog.jpg"];
        userImageX = SCREEMWIDTH - THESPACE - IMAGESIZE;
        if (contentSize.width >= SCREEMWIDTH - IMAGESIZE * 2 - 2.5 * THESPACE) {
            messageContentX = IMAGESIZE + THESPACE;
            contentWidth = SCREEMWIDTH - IMAGESIZE * 2 - THESPACE * 2.5;
        }else {
            contentWidth = contentSize.width + 3 * THESPACE;
            messageContentX = SCREEMWIDTH - IMAGESIZE - THESPACE * 4.5 - contentSize.width;
        }
        UIImage *image = [UIImage resizableImage:@"SenderTextNodeBkg"];
        [_messageBackground setImage:image];
    } // message from others
    else{
        _userImageView.image = [UIImage imageNamed:@"gjqt.jpg"];
        userImageX = THESPACE;
        messageContentX = THESPACE * 1.5 + IMAGESIZE;
        if (contentSize.width >= SCREEMWIDTH - IMAGESIZE * 2 - 2.5 * THESPACE) {
            contentWidth = SCREEMWIDTH - IMAGESIZE * 2 - THESPACE * 2;
        }else {
            contentWidth = contentSize.width + 3 * THESPACE;
        }
        UIImage *image = [UIImage imageNamed:@"SenderTextNodeBkg"];
        image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUpMirrored];
        [_messageBackground setImage:[UIImage resizable:image]];
    }
    
    // set
//    [_userImageView setFrame:CGRectMake(userImageX, THESPACE, IMAGESIZE, IMAGESIZE)];
//    [_messageBackground setFrame:CGRectMake(messageContentX, THESPACE * 0.8, contentWidth, IMAGESIZE * 1.3)];
    [_messageContent setFrame:CGRectMake(THESPACE, THESPACE / 2, contentWidth - 1.75 * THESPACE, IMAGESIZE * 1.4)];
    // line spacing
//    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
//    paragraph.lineSpacing = 3;
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:TEXTSIZE],NSParagraphStyleAttributeName:paragraph};
//    _messageContent.attributedText = [[NSAttributedString alloc]initWithString:mChat.content attributes:attributes];
    // reset frame
    CGSize newSize = [_messageContent sizeThatFits:CGSizeMake(_messageContent.frame.size.width, MAXFLOAT)];
    CGRect newFrame = _messageContent.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, _messageContent.frame.size.width), newSize.height);
    [_messageContent setFrame:newFrame];
    
    _messageBackground.height = fmaxf(newSize.height + THESPACE * 1.6, IMAGESIZE * 1.3);
    self.height = _messageBackground.height;

    if (mChat.from == 1) {
        [_time setFrame:CGRectMake(CGRectGetMinX(_messageBackground.frame) - 10, 30, 40, 20)];
        UIImage *image = [UIImage imageNamed:@"ReceiverVoiceNodePlaying"];
        image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUpMirrored];
        [_audioAnimation setImage:image];
        [_audioAnimation setFrame:CGRectMake(_messageBackground.frame.size.width - 30, 15, 13, 13)];
    } else {
        [_time setFrame:CGRectMake(30, 15, 13, 13)];
        [_audioAnimation setImage:[UIImage imageNamed:@"ReceiverVoiceNodePlaying"]];
    }
    
    self.audiourl = mChat.audiourl;
}

- (void)longTouch
{
    if ([self.delegate respondsToSelector:@selector(longTouch)]) {
        [self.delegate longTouch];
    }
}

@end

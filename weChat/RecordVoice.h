//
//  RecordVoice.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/29.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordVoice : UIView

@property (nonatomic,strong) UIImageView *leftImage;
@property (nonatomic,strong) UIImageView *rightImage;
@property (nonatomic,strong) UIImageView *centerImage;
@property (nonatomic,strong) UILabel *label;


- (void)setLabelFrame:(NSString *)title font:(CGFloat)font;

@end

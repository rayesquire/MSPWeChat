//
//  UIImage+getImage.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/6.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "UIImage+getImage.h"

@implementation UIImage (getImage)

+ (UIImage *)msp_image:(NSString *)image {
    if (!image || [image isEqualToString:@""]) return nil;
    if ([image hasPrefix:@"/"]) return [UIImage imageWithContentsOfFile:image];
    else return [UIImage imageNamed:image];
}

@end

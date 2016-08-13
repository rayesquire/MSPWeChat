//
//  MYTool.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/20.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "MYTool.h"

@implementation MYTool

+ (void)addRadiusInUIImageView:(UIImageView *)imageView withImage:(UIImage *)image withCornerRadius:(CGFloat)radius toView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                                cornerRadius:radius] addClip];
    [image drawInRect:imageView.bounds];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [view addSubview:imageView];
}


@end

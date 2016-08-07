//
//  MYTool.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/20.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Extension.h"

@interface MYTool : NSObject

+ (void)addRadiusInUIImageView:(UIImageView *)imageView withImage:(UIImage *)image withCornerRadius:(CGFloat)radius toView:(UIView *)view;

@end

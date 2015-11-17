//
//  UIImage+Extension.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/31.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)resizableImage:(NSString *)imageName;
+ (UIImage *)resizable:(UIImage *)image;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
@end

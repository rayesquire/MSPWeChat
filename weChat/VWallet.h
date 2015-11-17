//
//  VWallet.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/11.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VWallet : UICollectionViewCell

@property (nonatomic,copy) UIImageView *iconImage;
@property (nonatomic,copy) UILabel *title;


- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image title:(NSString *)title;

+ (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image title:(NSString *)title;

@end

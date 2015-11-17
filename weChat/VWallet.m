//
//  VWallet.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/11.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "VWallet.h"

@implementation VWallet

- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        self.iconImage.image = image;
        self.title.text = title;
    }
    return self;
}

+ (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image title:(NSString *)title
{
    VWallet *tmp = [[VWallet alloc]initWithFrame:frame Image:image title:title];
    return tmp;
}


- (void)initView
{
    _iconImage = [[UIImageView alloc]init];
    [self addSubview:_iconImage];
    
    _title = [[UILabel alloc]init];
    

}

@end

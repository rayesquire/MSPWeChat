//
//  MoreMenuTableViewCell.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/21.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "MoreMenuTableViewCell.h"
#define MYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@implementation MoreMenuTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    self.userImageView = [[UIImageView alloc]init];
    [self.userImageView setFrame:CGRectMake(10, 5, 30, 30)];
    [self addSubview:self.userImageView];
    
    self.label = [[UILabel alloc]init];
    [self.label setFrame:CGRectMake(50, 10, 100, 100)];
    self.label.textColor = [UIColor whiteColor];
    [self.label setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:self.label];
    
    self.selectedBackgroundView.backgroundColor = MYColor(20, 20, 20);
}









@end

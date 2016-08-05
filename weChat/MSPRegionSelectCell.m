//
//  MSPRegionSelectCell.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/5.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPRegionSelectCell.h"

@interface MSPRegionSelectCell ()

@property (nonatomic,copy) UIImageView *userImage;
@property (nonatomic,copy) UILabel *label;

@end

@implementation MSPRegionSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    _userImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i <= 12; i++) {
        NSString *name = [NSString stringWithFormat:@"icon_loading%i",i];
        NSString *tmp = [NSString stringWithFormat:@"%@.jpg",name];
        UIImage *image = [UIImage imageNamed:tmp];
        [array addObject:image];
    }
    _userImage.animationRepeatCount = MAXFLOAT;
    _userImage.animationDuration = 1;
    _userImage.animationImages = array;
    [self addSubview:_userImage];
    [_userImage startAnimating];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100, 20)];
    _label.text = @"定位中...";
    [self addSubview:_label];
}

@end

//
//  MSPContactsCell.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/6.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPContactsCell.h"
#import "MSPContactModel.h"
#import "UIImage+getImage.h"

#define theRemarkSize 15
#define theUserImageSize 35

@interface MSPContactsCell ()

@property (nonatomic, readwrite, strong) UIImageView *userImage;
@property (nonatomic, readwrite, strong) UILabel *remark;

@end

@implementation MSPContactsCell

- (void)setModel:(MSPContactModel *)model {
    
    CGFloat userImageX = THESPACE;
    CGFloat userImageY = THESPACE;
    CGRect userImageRect = CGRectMake(userImageX, userImageY, theUserImageSize, theUserImageSize);
    _userImage = [[UIImageView alloc] initWithFrame:userImageRect];
    _userImage.image = [UIImage msp_image:model.userImage];
    [self.contentView addSubview:_userImage];
    
    CGFloat remarkX = CGRectGetMaxX(userImageRect) + THESPACE;
    CGSize remarkSize = [model.remark sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:theRemarkSize]}];
    CGFloat remarkY = (55 - remarkSize.height) / 2;
    CGRect remarkRect = CGRectMake(remarkX, remarkY, remarkSize.width, remarkSize.height);
    _remark = [[UILabel alloc] initWithFrame:remarkRect];
    _remark.text = model.remark;
    _remark.font = [UIFont systemFontOfSize:theRemarkSize];
    [self.contentView addSubview:_remark];
}


@end

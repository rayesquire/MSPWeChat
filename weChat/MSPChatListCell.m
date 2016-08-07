//
//  MSPChatListCell.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/7.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPChatListCell.h"
#import "MSPContactChatModel.h"
#import "UIImage+getImage.h"
#import "NSString+timeSign.h"

#define theTextSize 17
#define theTimeSize 14
#define theRemarkSize 17
#define theUserImageSize 50

@interface MSPChatListCell ()

@property (nonatomic, readwrite, strong) UIImageView *userImage;
@property (nonatomic, readwrite, strong) UILabel *content;
@property (nonatomic, readwrite, strong) UILabel *time;
@property (nonatomic, readwrite, strong) UILabel *remark;
//@property (nonatomic, readwrite, strong) UILabel *unreadNumber;
//@property (nonatomic, readwrite, strong) NSInteger number;

@end

@implementation MSPChatListCell

- (void)setModel:(MSPContactChatModel *)model {
    
    CGFloat userImageX = THESPACE;
    CGFloat userImageY = THESPACE;
    CGSize userImageSize = CGSizeMake(theUserImageSize,theUserImageSize);
    CGRect userImageRect = CGRectMake(userImageX, userImageY, userImageSize.width, userImageSize.height);
    _userImage = [[UIImageView alloc] initWithFrame:userImageRect];
    _userImage.image = [UIImage msp_image:model.userImage];
    _userImage.layer.cornerRadius = 4;
    _userImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_userImage];
    
    CGFloat remarkX = theUserImageSize + 2 * THESPACE;
    CGFloat remarkY = userImageY + 2;
    CGSize remarkSize = [model.remark sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theRemarkSize]}];
    CGRect remarkRect = CGRectMake(remarkX, remarkY, remarkSize.width, remarkSize.height);
    self.remark = [[UILabel alloc] initWithFrame:remarkRect];
    self.remark.textColor = [UIColor blackColor];
    self.remark.font = [UIFont systemFontOfSize:theRemarkSize];
    self.remark.text = model.remark;
    [self.contentView addSubview:self.remark];
    
    NSString *tmp = [NSString timeWithNSInteger:model.time];
    CGSize timeSize = [tmp sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:theTimeSize]}];
    CGFloat timeX = SCREEN_WIDTH - timeSize.width - THESPACE;
    CGFloat timeY = userImageY;
    CGRect timeRect = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    _time = [[UILabel alloc] initWithFrame:timeRect];
    _time.font = [UIFont systemFontOfSize:theTimeSize];
    _time.textColor = [UIColor grayColor];
    _time.text = [NSString timeWithNSInteger:model.time];
    [self.contentView addSubview:_time];
    
    CGFloat textX = remarkX;
    CGSize textSize = [model.content sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theTextSize]}];
    CGFloat textY = THESPACE + theUserImageSize - textSize.height - 2;
    CGRect textRect = CGRectMake(textX, textY, textSize.width, textSize.height);
    _content = [[UILabel alloc] initWithFrame:textRect];
    _content.font = [UIFont systemFontOfSize:theTextSize];
    _content.textColor = [UIColor grayColor];
    _content.text = model.content;
    [self.contentView addSubview:_content];
}

@end

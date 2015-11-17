//
//  VChatList.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/21.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "VWeChat.h"
#import "MWeChat.h"

#define theTextSize 12
#define theTimeSize 12
#define theRemarkSize 14
#define theSpace 10
#define theUserImageSize 40
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define DAY 24*60*60
#define MINUTE 60
#define HOUR 3600
#define WEEK 7*24*60*60

@implementation VWeChat

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"wechat";
    VWeChat *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[VWeChat alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.userImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.userImage];
        
        self.content = [[UILabel alloc]init];
        [self.contentView addSubview:self.content];
        
        self.time = [[UILabel alloc]init];
        [self.contentView addSubview:self.time];
        
        self.remark = [[UILabel alloc]init];
        [self.contentView addSubview:self.remark];
        
        self.unreadNumber = [[UILabel alloc]init];
        [self.contentView addSubview:self.unreadNumber];
    }
    return self;
}

- (void)setMWeChat:(MWeChat *)mWeChat
{
    CGFloat userImageX = theSpace;
    CGFloat userImageY = theSpace;
    CGSize userImageSize = CGSizeMake(theUserImageSize,theUserImageSize);
    CGRect userImageRect = CGRectMake(userImageX, userImageY, userImageSize.width, userImageSize.height);
    self.userImage.frame = userImageRect;
    self.userImage.image = [UIImage imageNamed:mWeChat.userImage];
    
    CGFloat remarkX = theUserImageSize + 2 * theSpace;
    CGFloat remarkY = userImageY;
    CGSize remarkSize = [mWeChat.remark sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theRemarkSize]}];
    CGRect remarkRect = CGRectMake(remarkX, remarkY, remarkSize.width, remarkSize.height);
    self.remark.frame = remarkRect;
    self.remark.textColor = [UIColor blackColor];
    self.remark.font = [UIFont systemFontOfSize:theRemarkSize];
    self.remark.text = mWeChat.remark;
    
    NSString *tmp = [self timeToTime:mWeChat.time];
    CGSize timeSize = [tmp sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:theTimeSize]}];
    CGFloat timeX = SCREENWIDTH - timeSize.width - theSpace;
    CGFloat timeY = userImageY;
    CGRect timeRect = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.time.frame = timeRect;
    self.time.font = [UIFont systemFontOfSize:theTimeSize];
    self.time.textColor = [UIColor grayColor];
    self.time.text = tmp;
    
    CGFloat textX = remarkX;
    CGSize textSize = [mWeChat.content sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:theTextSize]}];
    CGFloat textY = theSpace + theUserImageSize - textSize.height;
    CGRect textRect = CGRectMake(textX, textY, textSize.width, textSize.height);
    self.content.frame = textRect;
    self.content.font = [UIFont systemFontOfSize:theTextSize];
    self.content.textColor = [UIColor grayColor];
    self.content.text = mWeChat.content;
    
    [self.unreadNumber setFrame:CGRectMake(50, 10, 20, 20)];
    [self.unreadNumber setBackgroundColor:[UIColor redColor]];
    self.unreadNumber.textColor = [UIColor whiteColor];
    [self.unreadNumber setFont:[UIFont systemFontOfSize:theRemarkSize]];
    self.unreadNumber.layer.masksToBounds = YES;
    self.unreadNumber.layer.cornerRadius = 10;
    self.unreadNumber.text = [NSString stringWithFormat:@"%d",(int)self.number];
    if (self.number) {
        [self.unreadNumber setHidden:NO];
    }else{
        [self.unreadNumber setHidden:YES];
    }
}

#pragma mark - calculate time
- (NSString *)timeToTime:(NSString *)aString
{
    NSString *over = [[NSString alloc]init];
    NSDateFormatter *trans = [[NSDateFormatter alloc]init];
    [trans setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *dateGet = [trans dateFromString:aString];
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *makeZeroFormatter = [[NSDateFormatter alloc]init];
    [makeZeroFormatter setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSString *zeroString = [makeZeroFormatter stringFromDate:dateNow];
    NSDateFormatter *normal = [[NSDateFormatter alloc]init];
    [normal setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *GMTZeroDate = [normal dateFromString:zeroString];
    if (([zeroString intValue] - [aString intValue]) > 8000000) {
        int a = [[aString substringWithRange:NSMakeRange(2, 2)] intValue];
        int b = [[aString substringWithRange:NSMakeRange(4, 2)] intValue];
        int c = [[aString substringWithRange:NSMakeRange(6, 2)] intValue];
        if (b < 10) {
            b = (int)b;
        }
        if (c < 10) {
            c = (int)c;
        }
        over = [NSString stringWithFormat:@"%i/%i/%i",a,b,c];
    }else {
        NSTimeInterval superInterval = [GMTZeroDate timeIntervalSinceDate:dateGet];
        if (superInterval <= 0){
            NSDateFormatter *tmp = [[NSDateFormatter alloc]init];
            [tmp setDateFormat:@"HH:mm"];
            NSString *dateString = [tmp stringFromDate:dateGet];
            over = dateString;
        }else if (superInterval > 0 && superInterval <= DAY){
            over = @"昨天";
        }else if (superInterval > DAY && superInterval < WEEK){
            NSCalendar *cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
            NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDate *tmp = [dateGet dateByAddingTimeInterval:28800];
            comps = [cal components:unitFlags fromDate:tmp];
            switch (comps.weekday) {
                case 1:
                    over = @"星期日";
                    break;
                case 2:
                    over = @"星期一";
                    break;
                case 3:
                    over = @"星期二";
                    break;
                case 4:
                    over = @"星期三";
                    break;
                case 5:
                    over = @"星期四";
                    break;
                case 6:
                    over = @"星期五";
                    break;
                case 7:
                    over = @"星期六";
                    break;
            }
        }else {
            int a = [[aString substringWithRange:NSMakeRange(2, 2)] intValue];
            int b = [[aString substringWithRange:NSMakeRange(4, 2)] intValue];
            int c = [[aString substringWithRange:NSMakeRange(6, 2)] intValue];
            if (b < 10) {
                b = (int)b;
            }
            if (c < 10) {
                c = (int)c;
            }
            over = [NSString stringWithFormat:@"%i/%i/%i",a,b,c];
        }
    }
    return over;
}

#pragma mark 重写选择事件，取消选中
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}

@end

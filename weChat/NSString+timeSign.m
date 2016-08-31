//
//  NSString+timeSign.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/7.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "NSString+timeSign.h"

#define DAY 24*60*60
#define MINUTE 60
#define HOUR 3600
#define WEEK 7*24*60*60

@implementation NSString (timeSign)

#pragma mark - calculate time
+ (NSString *)timeToTime:(NSString *)aString {
    NSString *over = [[NSString alloc] init];
    NSDateFormatter *trans = [[NSDateFormatter alloc] init];
    [trans setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *dateGet = [trans dateFromString:aString];
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *makeZeroFormatter = [[NSDateFormatter alloc] init];
    [makeZeroFormatter setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSString *zeroString = [makeZeroFormatter stringFromDate:dateNow];
    NSDateFormatter *normal = [[NSDateFormatter alloc]init];
    [normal setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *GMTZeroDate = [normal dateFromString:zeroString];
    if (([zeroString intValue] - [aString intValue]) > 8000000) {
        int a = [[aString substringWithRange:NSMakeRange(2, 2)] intValue];
        int b = [[aString substringWithRange:NSMakeRange(4, 2)] intValue];
        int c = [[aString substringWithRange:NSMakeRange(6, 2)] intValue];
        if (b < 10) b = (int)b;
        if (c < 10) c = (int)c;
        over = [NSString stringWithFormat:@"%i/%i/%i",a,b,c];
    }
    else {
        NSTimeInterval superInterval = [GMTZeroDate timeIntervalSinceDate:dateGet];
        if (superInterval <= 0){
            NSDateFormatter *tmp = [[NSDateFormatter alloc]init];
            [tmp setDateFormat:@"HH:mm"];
            NSString *dateString = [tmp stringFromDate:dateGet];
            over = dateString;
        }
        else if (superInterval > 0 && superInterval <= DAY) over = @"昨天";
        else if (superInterval > DAY && superInterval < WEEK) {
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
        }
        else {
            int a = [[aString substringWithRange:NSMakeRange(2, 2)] intValue];
            int b = [[aString substringWithRange:NSMakeRange(4, 2)] intValue];
            int c = [[aString substringWithRange:NSMakeRange(6, 2)] intValue];
            if (b < 10) b = (int)b;
            if (c < 10) c = (int)c;
            over = [NSString stringWithFormat:@"%i/%i/%i",a,b,c];
        }
    }
    return over;
}

+ (NSString *)timeWithNSInteger:(NSInteger)number {
    NSString *string = [NSString stringWithFormat:@"%ld",number];
    return [NSString timeToTime:string];
}

+ (NSString *)MinuteSecondStringWithNSIteger:(NSInteger)time {
    NSString *string;
    NSInteger minute = time / 60;
    NSInteger second = time % 60;
    if (time > 60) string = [NSString stringWithFormat:@"%d'%d''", (int)minute, (int)second];
    else string = [NSString stringWithFormat:@"%d\"", (int)second];
    return string;
}

@end

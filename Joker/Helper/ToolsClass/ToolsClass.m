//
//  ToolsClass.m
//  joker
//
//  Created by 肖松 on 15-7-18.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#import "ToolsClass.h"

@implementation ToolsClass
#pragma 获取当前时间
+ (NSString *)getNowDateWithType:(DateFormatType)type
                         andDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];

    int year = (int)[dateComponent year];
    int month = (int)[dateComponent month];
    int day = (int)[dateComponent day];
    switch (type) {
        case DateFormatWithAll:
         return    [NSString stringWithFormat:@"%d-%02d-%d",year,month,day];
            break;
        case DateFormatWithYear:
        return [NSString stringWithFormat:@"%d",year];
            break;
        case DateFormatWithDay:
            
         return [NSString stringWithFormat:@"%d",day];
            break;
        case DateFormatWithMouth:
         return [NSString stringWithFormat:@"%d",month];
            break;
            
        default:
              return [NSString stringWithFormat:@"%d-%02d-%d",year,month,day];
            break;
    }
  
}

#pragma 获取昨天明天
+ (NSString *)getDateYestday:(NSString *)date isTomorrow:(BOOL)isTomorrow{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate* inputDate = [inputFormatter dateFromString:date];
    NSTimeInterval secondsPerDay = 24*60*60;
    NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
    //   NSLog(@"myDate = %@ 明天=%@",tomorrow,[NSDate dateWithTimeInterval:secondsPerDay sinceDate:inputDate]);
    //根据已有日期创建日期
    NSTimeInterval secondsPerDay1 = 24*60*60;
    NSDate *now = [NSDate date];
    NSDate *yesterDay = [now addTimeInterval:-secondsPerDay1];
    //  NSLog(@"yesterDay = %@",yesterDay);
    return isTomorrow?[inputFormatter stringFromDate:tomorrow]:[inputFormatter stringFromDate:yesterDay];
}
@end

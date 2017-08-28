//
//  HHTGetString.m
//  Shipping
//
//  Created by 郭金涛 on 16/6/8.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "HHTGetString.h"

@implementation HHTGetString
+ (NSString *)getStringFormStringWihtFormate:(NSString *)formate units:(NSString *)units value:(NSString *)value
{
    
    if (formate.length > 0) {
        return value?[NSString stringWithFormat:@"%@: %@%@",formate,value,units]:[NSString stringWithFormat:@"%@:",formate];
    }
    else{
        
        return value?[NSString stringWithFormat:@"%@%@",value,units]:[NSString stringWithFormat:@"%@",formate];
    }
    
}


+ (NSString *)timeStrwithTimestamp:(NSString *)timestamp{
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* needFormatDate = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:needFormatDate];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];//这里的格式必须和DateString格式一致
    
    NSDate * nowDate = [NSDate date];
    
    
    // ------取当前时间和转换时间两个日期对象的时间间隔
    NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
    
    NSLog(@"time----%f",time);
    // ------再然后，把间隔的秒数折算成天数和小时数：
    
    NSString *dateStr = [[NSString alloc] init];
    
    if (time<=60) {  //1分钟以内的
        
        dateStr = @"刚刚";
        
    }else if(time<=60*60){  //一个小时以内的
        
        int mins = time/60;
        dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        
    }else if(time<=60*60*24){  //在两天内的
        
        [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
        NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
        NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([need_yMd isEqualToString:now_yMd]) {
            //在同一天
            dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
        }else{
            //昨天
            dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
        }
    }else {
        
        [dateFormatter setDateFormat:@"yyyy"];
        NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
        NSString *nowYear = [dateFormatter stringFromDate:nowDate];
        
        if ([yearStr isEqualToString:nowYear]) {
            //在同一年
            [dateFormatter setDateFormat:@"MM月dd日"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }else{
            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
    }

    return dateStr;
}


/**
 *  获取未来某个日期是星期几
 *  注意：featureDate 传递过来的格式 必须 和 formatter.dateFormat 一致，否则endDate可能为nil
 *
 */

+ (NSString *)passWeekdayWithDate:(NSString *)passDate{
    // 创建 格式 对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置 日期 格式 可以根据自己的需求 随时调整， 否则计算的结果可能为 nil
    formatter.dateFormat = @"yyyy-MM-dd";
    // 将字符串日期 转换为 NSDate 类型
    NSDate *endDate = [formatter dateFromString:passDate];
    // 判断当前日期 和 guoqu某个时刻日期 相差的天数
    long days = [self daysFromDate:endDate toDate:[NSDate date]];
    // 将总天数 换算为 以 周 计算（假如 相差10天，其实就是等于 相差 1周零3天，只需要取3天，更加方便计算）
    long day = days >= 7 ? days % 7 : days;
    long week = ([self getNowWeekday] - day) >= 0 ? [self getNowWeekday] - day: ([self getNowWeekday] + 7 - day);
    switch (week) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 0:
            return @"周六";
            break;
            
        default:
            break;
    }
    return nil;
}

+ (NSString *)featureWeekdayWithDate:(NSString *)featureDate{
    // 创建 格式 对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置 日期 格式 可以根据自己的需求 随时调整， 否则计算的结果可能为 nil
    formatter.dateFormat = @"yyyy-MM-dd";
    // 将字符串日期 转换为 NSDate 类型
    NSDate *endDate = [formatter dateFromString:featureDate];
    // 判断当前日期 和 未来某个时刻日期 相差的天数
    long days = [self daysFromDate:[NSDate date] toDate:endDate];
    // 将总天数 换算为 以 周 计算（假如 相差10天，其实就是等于 相差 1周零3天，只需要取3天，更加方便计算）
    long day = days >= 7 ? days % 7 : days;
    long week = [self getNowWeekday] + day;
    switch (week) {
        case 7:
            return @"周日";
            break;
        case 1:
            return @"周一";
            break;
        case 2:
            return @"周二";
            break;
        case 3:
            return @"周三";
            break;
        case 4:
            return @"周四";
            break;
        case 5:
            return @"周五";
            break;
        case 6:
            return @"周六";
            break;
            
        default:
            break;
    }
    return nil;
}

/**
 *  计算2个日期相差天数
 *  startDate   起始日期
 *  endDate     截至日期
 */
+(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    if (days <= 0 && hours <= 0&&minute<= 0) {
        NSLog(@"0天0小时0分钟");
        return 0;
    }
    else {
        NSLog(@"%@",[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute]);
        // 之所以要 + 1，是因为 此处的days 计算的结果 不包含当天 和 最后一天\
        （如星期一 和 星期四，计算机 算的结果就是2天（星期二和星期三），日常算，星期一——星期四相差3天，所以需要+1）\
        对于时分 没有进行计算 可以忽略不计
        return days;
    }
}

// 获取当前是星期几
+ (NSInteger)getNowWeekday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}

+ (NSString *)assembleMonthDayStrWithDate:(NSString *)date{
    
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    
    if ([[self firstCharactorWithString:month] isEqualToString:@"0"]) {
        month = [month substringFromIndex:1];
    }
    
    NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
    
    if ([[self firstCharactorWithString:day] isEqualToString:@"0"]) {
        day = [day substringFromIndex:1];
    }
    
    return [NSString stringWithFormat:@"%@月%@日",month,day];
    
    
}

+ (NSString *)firstCharactorWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}
@end

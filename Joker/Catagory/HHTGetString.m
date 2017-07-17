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
@end

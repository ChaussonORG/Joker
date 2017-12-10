//
//  HHTGetString.h
//  Shipping
//
//  Created by 郭金涛 on 16/6/8.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHTGetString : NSObject
+ (NSString *)getStringFormStringWihtFormate:(NSString *)formate units:(NSString *)units value:(NSString *)value;


+ (NSDate *)changeTimewithTimestamp:(NSString *)timestamp;

+ (NSString *)timeStrwithTimestamp:(NSString *)timestamp;

+ (NSString *)timelineStrwithTimestamp:(NSString *)timestamp;//yyyy-MM-dd

+ (NSString *)passWeekdayWithDate:(NSString *)passDate;

+ (NSString *)featureWeekdayWithDate:(NSString *)featureDate;


+ (NSString *)assembleMonthDayStrWithDate:(NSString *)date;

+ (NSString * )floatTypeWithStr:(NSString *)str;

@end

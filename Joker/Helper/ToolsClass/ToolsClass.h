//
//  ToolsClass.h
//  joker
//
//  Created by 肖松 on 15-7-18.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeEnumClass.h"

@interface ToolsClass : NSObject
+ (NSString *)getDateYestday:(NSString *)date isTomorrow:(BOOL)isTomorrow; // 获取明天昨天时间
+ (NSString *)getNowDateWithType:(DateFormatType)type
                              andDate:(NSDate *)date;// 获取时间
@end

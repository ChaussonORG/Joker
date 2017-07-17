//
//  SDRequestBaseConfig.m
//  SDBaseRequestDemo
//
//  Created by Chausson on 16/10/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDRequestBaseConfig.h"
#import <CHNetworking/CHNetworking.h>

@implementation SDRequestBaseConfig
+ (void)load{
    [[CHNetworkConfig sharedInstance] addheaderFieldParameter:[self defultConfig]];
}
+ (NSDictionary *)defultConfig{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // 当前应用名称
    NSString *displayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if(!displayName){
        displayName = @"应用尚未设置名称";
    }
//    // 当前应用软件版本  比如：1.0.1
//    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    if(!appCurVersionNum){
        appCurVersionNum = @"0.0";
    }
 //   CFRelease((__bridge CFTypeRef)(infoDictionary));
    return @{@"DisplayName":displayName,
             @"TimeStamp":[self timeStamp],
             @"SystemVersion":appCurVersionNum,
             @"UserPhoneName":[self userPhoneName],
             @"DeviceName":[self deviceName],
             @"DeviceVersion":[self deviceVersion],
             @"UUID":[self uuid]};
}
+ (NSString *)uuid{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];;
}
+ (NSString *)userPhoneName{
    //手机别名： 用户定义的名称
    return [[UIDevice currentDevice] name];
}
+ (NSString *)deviceName{
    return [[UIDevice currentDevice] systemName];
}
+ (NSString *)phoneVersion{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)timeStamp{
    return [[NSDate date] description];
}

+ (NSString *)deviceVersion{

    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    return sysVersion;
}
@end

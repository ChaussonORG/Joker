//
//  SDRequestBaseConfig.h
//  SDBaseRequestDemo
//
//  Created by Chausson on 16/10/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
// 该类会自动注册基础信息到CHNetworking
@interface SDRequestBaseConfig : NSObject

+ (NSDictionary *)defultConfig;
//+ (BOOL)registerConfig; // 注册基础信息

@end

//
//  UDIDTools.h
//  PhotoBook
//
//  Created by artisan on 14-6-16.
//  Copyright (c) 2014年 Logictech . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UDIDTools : NSObject
/*
 * @brief obtain Unique Device Identity
 */
+ (NSString*)UDID;
+ (BOOL)hasUDIDInKeyChain;
+ (BOOL)removeUDIDFromKeyChain;
@end

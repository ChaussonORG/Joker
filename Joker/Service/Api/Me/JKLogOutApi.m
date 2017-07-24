//
//  JKLogOutApi.m
//  JKMan
//
//  Created by 郭金涛 on 16/9/5.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "JKLogOutApi.h"

@implementation JKLogOutApi

- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/auth/logout"];
}
@end

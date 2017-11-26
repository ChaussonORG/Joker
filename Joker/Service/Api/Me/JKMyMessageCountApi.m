//
//  JKMyMessageCountApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/26.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyMessageCountApi.h"

@implementation JKMyMessageCountApi
- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/myMessage/count"];
}

@end

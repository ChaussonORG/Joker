//
//  JKMychangePasswordApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKMychangePasswordApi : JKCommonApi

@property (nonatomic , strong) NSString *oldPassword;

@property (nonatomic , strong) NSString *password;
- (instancetype)initWithOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)password;
@end

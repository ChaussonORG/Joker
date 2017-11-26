//
//  JKForgetPasswordApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/26.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKForgetPasswordApi : JKCommonApi
@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *photo;

@property (nonatomic, strong) NSString *password;

- (instancetype)initWithPhone:(NSString *)photo;

@end

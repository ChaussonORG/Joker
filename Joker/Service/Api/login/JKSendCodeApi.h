//
//  JKSendCodeApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKSendCodeApi : JKCommonApi

@property (nonatomic, strong) NSString *photo;

- (instancetype)initWithPhone:(NSString *)photo;

@end

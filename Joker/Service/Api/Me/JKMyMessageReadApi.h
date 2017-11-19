//
//  JKMyMessageReadApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKMyMessageReadApi : JKCommonApi

@property (nonatomic ,assign) BOOL readStatus;

@property (nonatomic , strong) NSString *messageId;


- (instancetype)initWithMessageId:(NSString *)messageId;
@end

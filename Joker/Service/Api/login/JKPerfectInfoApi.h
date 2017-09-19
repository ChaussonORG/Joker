//
//  JKPerfectInfoApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKPerfectInfoApi : JKCommonApi
@property (nonatomic, strong) NSString *gender;

@property (nonatomic, strong) NSString *photo;

@property (nonatomic, strong) NSString *birthday;

@property (nonatomic, strong) NSString *nickName;

- (instancetype)initWithPhoto:(NSString *)photo;
@end

//
//  JKProfileApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/12/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKProfileApi : JKCommonApi

@property (nonatomic , strong) NSString *photo;

@property (nonatomic , strong) NSString *gender;

@property (nonatomic , strong) NSString *nickname;

@property (nonatomic , strong) NSString *birthday;

@end

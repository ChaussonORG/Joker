//
//  JKWorkCommentCreatApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKWorkCommentCreatApi : JKCommonApi

@property (nonatomic , strong ,readonly) NSString *extId;

@property (nonatomic , strong) NSString *commentType;

@property (nonatomic , strong ) NSString *score;

@property (nonatomic , strong) NSString *content;


- (instancetype)initWithWorkId:(NSString *)workId;


@end

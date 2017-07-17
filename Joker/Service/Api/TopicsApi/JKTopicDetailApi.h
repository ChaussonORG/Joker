//
//  JKTopicDetailApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKTopicDetailModel.h"
@interface JKTopicDetailApi : JKCommonApi

@property (nonatomic , strong ,readonly) JKTopicDetailModel *model;

@property (nonatomic , strong ,readonly) NSString *topicId;

- (instancetype)initWithTopicId:(NSString *)topicId;

@end

//
//  JKTopicCreateApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKTopicCreateApi : JKCommonApi

@property (nonatomic , strong) NSString *projectId;
@property (nonatomic , strong) NSString *projectType;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSMutableArray *topicContent;

@end

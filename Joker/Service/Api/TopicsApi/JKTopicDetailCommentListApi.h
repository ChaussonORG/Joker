//
//  JKTopicDetailCommentListApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKTopicDetailCommentListModel.h"
@interface JKTopicDetailCommentListApi : JKCommonApi

@property (nonatomic , strong ,readonly) JKTopicDetailCommentListModel *model;

@property (nonatomic , strong ,readonly) NSString *topicId;

@property (nonatomic , strong) NSString *commentType;

- (instancetype)initWithTopicId:(NSString *)topicId;


@end

//
//  JKCommentListApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/10.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKCommentListModel.h"
@interface JKCommentListApi : JKCommonApi


@property (nonatomic , strong ,readonly) JKCommentListModel *model;

@property (nonatomic , strong ,readonly) NSString *topicReplayId;

- (instancetype)initWithTopicReplayId:(NSString *)topicReplayId;


@end

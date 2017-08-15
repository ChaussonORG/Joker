//
//  JKCommentZanApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKCommentZanApi : JKCommonApi


@property (nonatomic , strong , readonly) NSString *topicReplayId;


- (instancetype)init __unavailable;

- (instancetype)initWithTopicReplayId:(NSString *)topicReplayId;


@end

//
//  JKCommentCaiApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommentCaiApi.h"

@implementation JKCommentCaiApi
- (instancetype)initWithTopicReplayId:(NSString *)topicReplayId
{
    self = [super init];
    if (self) {
        
        _topicReplayId = topicReplayId;
        
        
    }
    return self;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}
- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/topic/evaluation/cai/%@",self.topicReplayId]; ;
}

@end

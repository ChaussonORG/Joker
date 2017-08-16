//
//  JKCommetDeleteApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommetDeleteApi.h"

@implementation JKCommetDeleteApi

- (instancetype)initWithTopicReplayId:(NSString *)topicReplayId
{
    self = [super init];
    if (self) {
        
        _topicReplayId = topicReplayId;
        
        
    }
    return self;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodDelete;
}
- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/topic/evaluation/%@",self.topicReplayId]; ;
}

@end

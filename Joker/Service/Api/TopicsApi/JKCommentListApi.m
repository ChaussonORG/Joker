//
//  JKCommentListApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/10.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommentListApi.h"

@implementation JKCommentListApi
- (instancetype)initWithTopicReplayId:(NSString *)topicReplayId
{
    self = [super init];
    if (self) {
        _topicReplayId = topicReplayId;
        
    }
    return self;
}


- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/topic/replay/%@",self.topicReplayId] ;
}
- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[JKCommentListModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
    NSLog(@"err = %@", err);
}



@end

//
//  JKTopicDetailApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicDetailApi.h"

@implementation JKTopicDetailApi

- (instancetype)initWithTopicId:(NSString *)topicId
{
    self = [super init];
    if (self) {
        _topicId = topicId;
        
    }
    return self;
}


- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/topic/%@",self.topicId] ;
}
- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[JKTopicDetailModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
    NSLog(@"err = %@", err);
}
@end

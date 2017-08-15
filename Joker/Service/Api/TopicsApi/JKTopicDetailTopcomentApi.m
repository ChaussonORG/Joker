//
//  JKTopicDetailTopcomentApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicDetailTopcomentApi.h"

@implementation JKTopicDetailTopcomentApi



- (instancetype)initWithTopicId:(NSString *)topicId
{
    self = [super init];
    if (self) {
        _topicId = topicId;
        
    }
    return self;
}


- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/topic/%@/reply",self.topicId] ;
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.requestModel.limit) {
        [data setObject:@(self.requestModel.limit) forKey:@"limit"];
    }
    if (self.requestModel.offset) {
        [data setObject:@(self.requestModel.offset) forKey:@"offset"];
    }
    
    if (self.requestModel.page) {
        [data setObject:@(self.requestModel.page) forKey:@"page"];
    }
    
    
    if (self.commentType.length > 0) {
        
        [data setObject:self.commentType forKey:@"commentType"];
    }
    return data;
}

- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[JKTopicDetailTopcomentModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
    NSLog(@"err = %@", err);
}


@end

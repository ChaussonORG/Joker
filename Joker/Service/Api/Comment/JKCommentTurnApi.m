//
//  JKCommentTurnApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommentTurnApi.h"

@implementation JKCommentTurnApi

- (instancetype)initWithCommentTurnModel:(JKCommentTurnModel *)commentTurnModel
{
    self = [super init];
    if (self) {
        
        _commentTurnModel = commentTurnModel;
        
        
    }
    return self;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}
- (NSString *)requestPathUrl{
    return @"/app/topic/replay/edit"; ;
}

- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.commentTurnModel.topicReplayId) {
        [data setObject:self.commentTurnModel.topicReplayId forKey:@"topicReplayId"];
    }
    if (self.commentTurnModel.content) {
        [data setObject:self.commentTurnModel.content forKey:@"content"];
    }
     
    return data;
}
@end

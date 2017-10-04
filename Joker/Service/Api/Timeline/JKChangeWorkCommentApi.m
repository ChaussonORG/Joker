//
//  JKChangeWorkCommentApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/4.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKChangeWorkCommentApi.h"

@implementation JKChangeWorkCommentApi

- (instancetype)initWithWorkId:(NSString *)workId;
{
    self = [super init];
    if (self) {
        
        _extId = workId;
        
    }
    return self;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}

- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/comment/%@",self.extId];
}

- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    
    if (self.commentType) {
        [data setObject:self.commentType forKey:@"commentType"];
    }
     
    
    if (self.content) {
        
        [data setObject:self.content forKey:@"content"];
    }
    
    
    if (self.score) {
        
        [data setObject:self.score forKey:@"score"];
    }
    
    
    
    return data;
}
@end

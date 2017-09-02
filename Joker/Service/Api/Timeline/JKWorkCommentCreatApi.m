//
//  JKWorkCommentCreatApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkCommentCreatApi.h"

@implementation JKWorkCommentCreatApi
- (instancetype)initWithWorkId:(NSString *)workId;
{
    self = [super init];
    if (self) {
        
        _extId = workId;
        
    }
    return self;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}

- (NSString *)requestPathUrl{
    return @"/app/comment";
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    
    if (self.commentType) {
        [data setObject:self.commentType forKey:@"commentType"];
    }
    
    if (self.extId) {
        
        [data setObject:self.extId forKey:@"extId"];
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

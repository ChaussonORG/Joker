//
//  JKTopicCreateApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicCreateApi.h"

@implementation JKTopicCreateApi

- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}
- (NSString *)requestPathUrl{
    return @"/app/topic" ;
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.projectId) {
        [data setObject:self.projectId forKey:@"projectId"];
    }
    if (self.projectType) {
        [data setObject:self.projectType forKey:@"projectType"];
    }
    
    if (self.title) {
        
        [data setObject:self.title forKey:@"title"];
    }
    
    if (self.topicContent) {
        
        [data setObject:self.topicContent forKey:@"topicContent"];
    }
    return data;
}



@end

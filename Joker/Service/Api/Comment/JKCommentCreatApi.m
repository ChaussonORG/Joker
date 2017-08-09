//
//  JKCommentCreatApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommentCreatApi.h"

@implementation JKCommentCreatApi

- (instancetype)initWithCommentCreatModel:(JKCommentCreatModel *)model
{
    self = [super init];
    if (self) {
        
        _creatModel = model;
        
        
    }
    return self;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}
- (NSString *)requestPathUrl{
    return @"/app/topic/replay" ;
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.creatModel.topicId) {
        [data setObject:self.creatModel.topicId forKey:@"topicId"];
    }
    if (self.creatModel.parentId) {
        [data setObject:self.creatModel.parentId forKey:@"parentId"];
    }
    
    if (self.creatModel.content) {
        
        [data setObject:self.creatModel.content forKey:@"content"];
    }
    
  
    return data;
}

@end

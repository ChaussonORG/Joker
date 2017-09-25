//
//  JKUnfavoriteWorkApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKUnfavoriteWorkApi.h"

@implementation JKUnfavoriteWorkApi

- (instancetype)initWithWorkId:(NSString *)workId;
{
    self = [super init];
    if (self) {
        
        _targetId = workId;
        
    }
    return self;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}

- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/favorite/%@",self.targetId];
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    
    if (self.targetId) {
        [data setObject:self.targetId forKey:@"targetId"];
    }
    
    if (self.type) {
        
        [data setObject:self.type forKey:@"type"];
    }
    
    
    
    return data;
}


@end

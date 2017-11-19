//
//  JKMyLookPlayCommentedApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyLookPlayCommentedApi.h"

@implementation JKMyLookPlayCommentedApi
- (NSString *)requestPathUrl{
    return @"/app/comment/works";
}

- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.requestModel.limit) {
        [data setObject:@(self.requestModel.limit) forKey:@"limit"];
    }
    if (self.requestModel.offset) {
        [data setObject:@(self.requestModel.offset) forKey:@"offset"];
    }
    
    if (self.type) {
        
        [data setObject:self.type forKey:@"commentType"];
    }
    return data;
}

- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[JKMyLookPlayModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
    NSLog(@"err = %@", err);
}

@end

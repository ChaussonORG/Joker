//
//  JKWorkCommentApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkCommentApi.h"

@implementation JKWorkCommentApi

- (instancetype)initWithWorkId:(NSString *)workId;
{
    self = [super init];
    if (self) {
        
        _extId = workId;
        
    }
    return self;
}


- (NSString *)requestPathUrl{
    return @"/app/comment";
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.requestModel.limit) {
        [data setObject:@(self.requestModel.limit) forKey:@"limit"];
    }
    if (self.requestModel.offset) {
        [data setObject:@(self.requestModel.offset) forKey:@"offset"];
    }
    if (self.extId) {
        [data setObject:self.extId forKey:@"extId"];
    }
    
    if (self.commentType) {
        
        [data setObject:self.commentType forKey:@"commentType"];
    }
    
    
 
    return data;
}


- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[JKWorkCommentModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
    NSLog(@"err = %@", err);
}

@end

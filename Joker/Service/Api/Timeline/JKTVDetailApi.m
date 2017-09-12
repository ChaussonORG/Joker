//
//  JKTVDetailApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/10.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTVDetailApi.h"

@implementation JKTVDetailApi
- (instancetype)initWithWorkId:(NSString *)workId;
{
    self = [super init];
    if (self) {
        
        _workId = workId;
        
    }
    return self;
}
- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/tv/%@",self.workId];
}

- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[JKFilmDetailModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
    NSLog(@"err = %@", err);
}

@end

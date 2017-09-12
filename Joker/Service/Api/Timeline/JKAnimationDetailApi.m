//
//  JKAnimationDetailApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/12.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKAnimationDetailApi.h"

@implementation JKAnimationDetailApi
- (instancetype)initWithWorkId:(NSString *)workId;
{
    self = [super init];
    if (self) {
        
        _workId = workId;
        
    }
    return self;
}
- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/animation/%@",self.workId];
}

- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[JKFilmDetailModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
    NSLog(@"err = %@", err);
}

@end

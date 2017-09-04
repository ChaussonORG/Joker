//
//  JKWorkCommentZanApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkCommentZanApi.h"

@implementation JKWorkCommentZanApi

- (instancetype)initWithExtId:(NSString *)extId
{
    self = [super init];
    if (self) {
        
        _extId = extId;
        
        
    }
    return self;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}
- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/comment/cai/%@",self.extId]; ;
}
@end

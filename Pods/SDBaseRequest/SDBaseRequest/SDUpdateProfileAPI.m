//
//  SDUpdateProfileAPI.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDUpdateProfileAPI.h"
#import <CHNetworking/CHNetworking.h>
@implementation SDUpdateProfileAPI
- (instancetype)initWithProfile:(NSDictionary *)profile{
    self = [super init];
    if (self) {
        NSParameterAssert(profile);
        _profile = profile;
    }
    return self;
}
- (NSDictionary *)requestParameter{
    return _profile;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}
- (NSString *)requestPathUrl{
    return @"/app/profile";
}
- (NSString *)customUrl{
    return [NSString stringWithFormat:@"%@%@",[CHNetworkConfig sharedInstance].baseUrl,[self requestPathUrl]];
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
@end

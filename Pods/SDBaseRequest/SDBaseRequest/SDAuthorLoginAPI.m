//
//  SDAuthorLogin.m
//  SDBaseRequestDemo
//
//  Created by Chausson on 16/6/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDAuthorLoginAPI.h"
#import <CHNetworking/CHNetworking.h>
@implementation SDAuthorLoginAPI
- (instancetype)initWithOpenID:(NSString *)openid
                   accessToken:(NSString *)token
                          type:(SDAuthorType)type{
    self = [super init];
    if (self) {
        NSParameterAssert(openid);
        NSParameterAssert(token);
        _openid  = openid;
        _token = token;
        _type = type;
    }
    return self;
}
- (NSDictionary *)requestParameter{
    return @{@"openid":_openid,
             @"accessToken":_token};
}
- (NSString *)requestPathUrl{
    switch (self.type) {
        case SDAuthorQQ:
            return @"/app/auth/qq";
            break;
        case SDAuthorSina:
            return @"/app/auth/wb";
            break;
        case SDAuthorWeChat:
            return @"/app/auth/wx";
            break;
            
        default:
            return @"/app/auth/wb";
            break;
    }
    
}
- (NSString *)customUrl{
    return [NSString stringWithFormat:@"%@%@",[CHNetworkConfig sharedInstance].baseUrl,[self requestPathUrl]];
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
@end

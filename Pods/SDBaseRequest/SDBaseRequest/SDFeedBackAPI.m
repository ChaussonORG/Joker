//
//  SDFeedBackAPI.m
//  SDBaseRequestDemo
//
//  Created by Chausson on 16/5/31.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDFeedBackAPI.h"
#import <CHNetworking/CHNetworking.h>
@implementation SDFeedBackAPI
- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content{
    self = [super init];
    if (self) {
        NSParameterAssert(content);
        _title = title;
        _content = content;
    }
    return self;
}
- (NSDictionary *)requestParameter{
    return @{@"title":_title,
             @"body":_content};
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}
- (NSString *)requestPathUrl{
    return @"/app/feedback";
}
- (NSString *)customUrl{
    return [NSString stringWithFormat:@"%@%@",[CHNetworkConfig sharedInstance].baseUrl,[self requestPathUrl]];
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
@end

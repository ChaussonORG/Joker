//
//  SDAuthorLoginAPI.h
//  SDBaseRequestDemo
//
//  Created by Chausson on 16/6/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <CHNetworking/CHNetworking.h>
#import "SDBaseResponse.h"

typedef NS_OPTIONS(NSInteger ,SDAuthorType) {
    SDAuthorSina, // 新浪微博
    SDAuthorWeChat, // 微信
    SDAuthorQQ // QQ
};
@interface SDAuthorLoginAPI : CHNetRequest
+ (instancetype)new __unavailable;
- (instancetype)init  __unavailable;
- (instancetype)initWithOpenID:(NSString *)openid
                   accessToken:(NSString *)token
                          type:(SDAuthorType)type;

@property (nonatomic ,readonly ) SDBaseResponse *baseResponse;

@property (nonatomic ,readonly) NSString *openid;

@property (nonatomic ,readonly) NSString *token;

@property (nonatomic ,readonly) SDAuthorType type;
@end

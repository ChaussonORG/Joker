//
//  SDFeedBackAPI.h
//  SDBaseRequestDemo
//
//  Created by Chausson on 16/5/31.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <CHNetworking/CHNetworking.h>
#import "SDBaseResponse.h"

@interface SDFeedBackAPI : CHNetRequest
+ (instancetype)new __unavailable;
- (instancetype)init  __unavailable;
- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content;

@property (nonatomic ,readonly ) SDBaseResponse *baseResponse;

@property (nonatomic ,readonly) NSString *content;

@property (nonatomic ,readonly) NSString *title;

@end

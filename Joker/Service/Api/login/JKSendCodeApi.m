//
//  JKSendCodeApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKSendCodeApi.h"

@implementation JKSendCodeApi

- (instancetype)initWithPhone:(NSString *)photo
{
    self = [super init];
    if (self) {
        
        _photo = photo;
        
    }
    return self;
}
- (NSString *)requestPathUrl{
    return @"/sms";
}

- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}

- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    
    if (self.photo) {
        [data setObject:self.photo forKey:@"phoneNum"];
    }
    
    
    return data;
}

@end

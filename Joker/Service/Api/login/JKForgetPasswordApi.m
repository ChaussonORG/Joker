//
//  JKForgetPasswordApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/26.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKForgetPasswordApi.h"

@implementation JKForgetPasswordApi
- (instancetype)initWithPhone:(NSString *)photo
{
    self = [super init];
    if (self) {
        
        _photo = photo;
        
    }
    return self;
}
- (NSString *)requestPathUrl{
    return @"/app/password";
}

- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}

- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    
    if (self.photo) {
        [data setObject:self.photo forKey:@"cellphone"];
    }
    
    if (self.code) {
        [data setObject:self.code forKey:@"phoneCode"];
    }
    
    if (self.password) {
        [data setObject:self.password forKey:@"password"];
    }
    
    
    return data;
}

@end

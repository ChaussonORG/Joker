//
//  JKRegisterApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKRegisterApi.h"

@implementation JKRegisterApi
- (instancetype)initWithPhone:(NSString *)photo
{
    self = [super init];
    if (self) {
        
        _photo = photo;
        
    }
    return self;
}
- (NSString *)requestPathUrl{
    return @"/app/register";
}

- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
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

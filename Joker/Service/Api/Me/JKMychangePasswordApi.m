//
//  JKMychangePasswordApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMychangePasswordApi.h"

@implementation JKMychangePasswordApi
- (instancetype)initWithOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)password
{
    self = [super init];
    if (self) {
     
        self.oldPassword = oldPassword;
        
        self.password = password;
        
        
        
    }
    return self;
}
- (NSString *)requestPathUrl{
    return @"/app/password/editPassword";
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.oldPassword) {
        [data setObject:self.oldPassword forKey:@"oldPassword"];
    }
    if (self.password) {
        [data setObject:self.password forKey:@"password"];
    }
    
    return data;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}
@end

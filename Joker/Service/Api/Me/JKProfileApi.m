//
//  JKProfileApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKProfileApi.h"

@implementation JKProfileApi
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}
- (NSString *)requestPathUrl{
    return @"/app/profile";
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.photo) {
        [data setObject:self.photo forKey:@"photo"];
    }
    if (self.nickname) {
        [data setObject:self.nickname forKey:@"nickname"];
    }
    
    if (self.gender) {
        [data setObject:self.gender forKey:@"gender"];
    }
    
    if (self.birthday) {
        [data setObject:self.birthday forKey:@"birthday"];
    }
    return data;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}
@end

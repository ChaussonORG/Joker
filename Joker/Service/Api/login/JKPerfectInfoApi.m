//
//  JKPerfectInfoApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPerfectInfoApi.h"

@implementation JKPerfectInfoApi
- (instancetype)initWithPhoto:(NSString *)photo
{
    self = [super init];
    if (self) {
        
        _photo = photo;
        
    }
    return self;
}
- (NSString *)requestPathUrl{
    return @"/app/profile";
}

- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}

- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    
    if (self.photo) {
        [data setObject:self.photo forKey:@"photo"];
    }
    
    if (self.gender) {
        [data setObject:self.gender forKey:@"gender"];
    }
    
    if (self.birthday) {
        [data setObject:self.birthday forKey:@"birthday"];
    }
    
    
    if (self.nickName) {
        [data setObject:self.nickName forKey:@"nickname"];
    }
    
    return data;
}

@end

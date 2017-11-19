//
//  JKMyMessageReadApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyMessageReadApi.h"

@implementation JKMyMessageReadApi

- (instancetype)initWithMessageId:(NSString *)messageId
{
    self = [super init];
    if (self) {
    
        self.messageId = messageId;
        
        self.readStatus = YES;
    }
    return self;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
   
    if (self.readStatus) {
        [data setObject:@(self.readStatus) forKey:@"readStatus"];
    }
    
    
    return data;
}

- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/app/myMessage/%@",self.messageId];
}

@end

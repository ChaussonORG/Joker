//
//  JKTopicsListApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/21.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicsListApi.h"

@implementation JKTopicsListApi


- (instancetype)initTopicFilm
{
    self = [super init];
    if (self) {
        
        
        _projectType = @"MOVIE";
        
    }
    return self;
}

- (instancetype)initTopicTV
{
    self = [super init];
    if (self) {
        
        
        _projectType = @"TV";
        
    }
    return self;
}
- (instancetype)initTopicCartoon
{
    self = [super init];
    if (self) {
        
        
        _projectType = @"ANIMATION";
        
    }
    return self;
}

- (instancetype)initTopicGame
{
    self = [super init];
    if (self) {
        
        
        _projectType = @"GAME";
        
    }
    return self;
}
- (instancetype)initTopicVariety
{
    self = [super init];
    if (self) {
        
        
        _projectType = @"ALL";
        
    }
    return self;
}


- (NSString *)requestPathUrl{
    return @"/app/topic/query";
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.requestModel.limit) {
        [data setObject:@(self.requestModel.limit) forKey:@"limit"];
    }
    if (self.requestModel.offset) {
        [data setObject:@(self.requestModel.offset) forKey:@"offset"];
    }
    if (self.projectType) {
        [data setObject:self.projectType forKey:@"projectType"];
    }
    
    
    if (self.querySelf) {
        [data setObject:@(self.querySelf) forKey:@"querySelf"];
    }
    
    
    if (self.favorite) {
        [data setObject:@"true" forKey:@"favorite"];
    }
   
    
    return data;
}


- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[JKTopicListModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
    NSLog(@"err = %@", err);
}


@end

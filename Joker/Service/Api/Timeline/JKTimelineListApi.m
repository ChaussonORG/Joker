//
//  JKTimelineListApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTimelineListApi.h"

@implementation JKTimelineListApi
- (instancetype)initTimelineFilm
{
    self = [super init];
    if (self) {
        
        
        _axisType = @"MOVIE";
        
    }
    return self;
}

- (instancetype)initTimelineTV
{
    self = [super init];
    if (self) {
        
        
        _axisType = @"TV";
        
    }
    return self;
}
- (instancetype)initTimelineCartoon
{
    self = [super init];
    if (self) {
        
        
        _axisType = @"ANIMATION";
        
    }
    return self;
}

- (instancetype)initTimelineGame
{
    self = [super init];
    if (self) {
        
        
        _axisType = @"GAME";
        
    }
    return self;
}
- (instancetype)initTimelineVariety
{
    self = [super init];
    if (self) {
        
        
        _axisType = @"VARIETY";
        
    }
    return self;
}


- (NSString *)requestPathUrl{
    return @"/app/timeAxis";
}
- (NSDictionary *)requestParameter{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (self.requestModel.limit) {
        [data setObject:@(self.requestModel.limit) forKey:@"limit"];
    }
    if (self.requestModel.offset) {
        [data setObject:@(self.requestModel.offset) forKey:@"offset"];
    }
    if (self.axisType) {
        [data setObject:self.axisType forKey:@"axisType"];
    }
    
    if (self.queryType) {
        [data setObject:self.queryType forKey:@"queryType"];
    }
    
    
    if (self.queryPage) {
        [data setObject:@(self.queryPage) forKey:@"queryPage"];
    }
    
    
    
//    if (self.startDate) {
//
//        [data setObject:self.startDate forKey:@"startDate"];
//    }
//
//
//    if (self.endDate) {
//
//        [data setObject:self.endDate forKey:@"endDate"];
//    }
    
    if (self.sortOrder) {
        
        [data setObject:self.sortOrder forKey:@"sortOrder"];
    }
     
    return data;
}


- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[JKTimelineFilmModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
    NSLog(@"err = %@", err);
}


@end

//
//  JKTimelineListVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTimelineListVM.h"

@interface JKTimelineListVM()

@property (nonatomic , strong) NSArray *titleArrays;

@property (nonatomic , strong) NSMutableArray *controllerArrays;



@end
@implementation JKTimelineListVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.titleArrays = @[@"电 影",@"电 视",@"动 画",@"游 戏",@"综 艺"];
        
        self.controllerArrays = [NSMutableArray array];
        
        [self loadControllers];
        
    }
    return self;
}

- (void)loadControllers{
    
    JKFilmTimeLineController *filmVc = [[JKFilmTimeLineController alloc]init];
    [self.controllerArrays addObject:filmVc];
    
    JKTVTimeLineController *tvVC = [[JKTVTimeLineController alloc]init];
    [self.controllerArrays addObject:tvVC];
    
    JKAnimationTimeLineController *animationVC = [[JKAnimationTimeLineController alloc]init];
    [self.controllerArrays addObject:animationVC];
    
    JKGameTimeLineController *gameVC = [[JKGameTimeLineController alloc]init];
    [self.controllerArrays addObject:gameVC];
    
    JKVarietyTimeLineController *vatietyVC = [[JKVarietyTimeLineController alloc]init];
    [self.controllerArrays addObject:vatietyVC];
     
}

@end

//
//  JKAnimationTimelineCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/27.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKAnimationTimelineCellVM.h"

@implementation JKAnimationTimelineCellVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.recommendArr = [NSMutableArray array];
        
        self.cellViewModels = [NSMutableArray array];
        
    }
    return self;
}
@end

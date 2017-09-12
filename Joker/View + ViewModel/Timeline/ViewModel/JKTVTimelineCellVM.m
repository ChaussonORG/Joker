//
//  JKTVTimelineCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/27.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTVTimelineCellVM.h"
#import "JKTVDetailController.h"
@implementation JKTVTimelineCellVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.recommendArr = [NSMutableArray array];
        
        self.cellViewModels = [NSMutableArray array];
        
    }
    return self;
}

- (void)gotoDetailWithWorkId:(NSString *)workId{
 
         
    JKTVDetailController *vc = [[JKTVDetailController  alloc]initWithWorkId:workId];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
}
@end

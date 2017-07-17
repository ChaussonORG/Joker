//
//  JKTopicListCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicListCellVM.h"
#import "JKTopicDetailController.h"
#import "ASNavigator.h"
@implementation JKTopicListCellVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
        
    }
    return self;
}


- (void)openTopicDetail{
    
    JKTopicDetailController *vc = [[JKTopicDetailController alloc]initWithTopicId:self.topicId];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
    
}

- (void)openTopicComment{
    
    
    
}
@end

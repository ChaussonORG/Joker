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
#import "JKWorkDetailController.h"
#import "JKTVDetailController.h"
#import "JKAnimationDetailController.h"
#import "JKGameDetailController.h"
#import "JKVarietyDetailController.h"
@implementation JKTopicListCellVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
        
    }
    return self;
}


- (void)openTopicDetail{
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    JKTopicDetailController *vc = [[JKTopicDetailController alloc]initWithTopicId:self.topicId];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
    
}

- (void)openTopicComment{
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self.delegate commentTopicWithId:self.topicId title:self.content];
    
}


- (void)openWorkDetail{
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    if ([self.projectType isEqualToString: @"MOVIE"]) {
        JKWorkDetailController *vc = [[JKWorkDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    else if([self.projectType isEqualToString: @"TV"]) {
        JKTVDetailController *vc = [[JKTVDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    else if([self.projectType isEqualToString: @"ANIMATION"]) {
        JKAnimationDetailController *vc = [[JKAnimationDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    else if([self.projectType isEqualToString: @"GAME"]) {
        JKGameDetailController *vc = [[JKGameDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    else if([self.projectType isEqualToString: @"VARIETY"]) {
        JKVarietyDetailController *vc = [[JKVarietyDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    
    
    
    
}
@end

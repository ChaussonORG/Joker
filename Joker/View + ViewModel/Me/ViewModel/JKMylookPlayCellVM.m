//
//  JKMylookPlayCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMylookPlayCellVM.h"
#import "JKWorkDetailController.h"
#import "JKTVDetailController.h"
#import "JKAnimationDetailController.h"
#import "JKGameDetailController.h"
#import "JKVarietyDetailController.h"
@implementation JKMylookPlayCellVM


- (void)gotoDetail{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    if ([self.type isEqualToString: @"MOVIE"]) {
        JKWorkDetailController *vc = [[JKWorkDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    else if([self.type isEqualToString: @"TV"]) {
        JKTVDetailController *vc = [[JKTVDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    else if([self.type isEqualToString: @"ANIMATION"]) {
        JKAnimationDetailController *vc = [[JKAnimationDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    else if([self.type isEqualToString: @"GAME"]) {
        JKGameDetailController *vc = [[JKGameDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    else if([self.type isEqualToString: @"VARIETY"]) {
        JKVarietyDetailController *vc = [[JKVarietyDetailController alloc]initWithWorkId:self.projectId];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES ];
    }
    

    
    
    
}
@end

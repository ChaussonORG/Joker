//
//  JKMyMessageCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyMessageCellVM.h"
#import "JKWorkDetailController.h"
#import "JKTVDetailController.h"
#import "JKAnimationDetailController.h"
#import "JKGameDetailController.h"
#import "JKVarietyDetailController.h"
#import "JKTopicDetailController.h"
#import "JKMyMessageReadApi.h"
@implementation JKMyMessageCellVM


- (void)gotoDetail{
    
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    

    JKMyMessageReadApi *api = [[JKMyMessageReadApi alloc]initWithMessageId:self.id];
    [api startWithSuccessBlock:^(__kindof JKMyMessageReadApi *request) {
        
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
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
            else if([self.projectType isEqualToString: @"TOPIC"]) {
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                JKTopicDetailController *vc = [[JKTopicDetailController alloc]initWithTopicId:self.projectId];
                
                [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
            }
            
        }
        
        
    } failureBlock:^(__kindof JKMyMessageReadApi *request) {
        
        
    }];
   
    
  
}
@end

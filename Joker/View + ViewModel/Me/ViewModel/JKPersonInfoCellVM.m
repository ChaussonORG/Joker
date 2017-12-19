//
//  JKPersonInfoCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPersonInfoCellVM.h"

@implementation JKPersonInfoCellVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
        
    }
    return self;
}
- (void)gotoEditInfo{
    
    
    if ([self.mainTitle isEqualToString:@"头像"]) {
        JKMyLookPlayController *vc = [[JKMyLookPlayController alloc]init];
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    
    if ([self.title isEqualToString:@"我的话题"]) {
        JKMyTopicController *vc = [[JKMyTopicController alloc]init];
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    
    if ([self.title isEqualToString:@"我的消息"]) {
        JKMyMessageController *vc = [[JKMyMessageController alloc]init];
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    
    if ([self.title isEqualToString:@"修改密码"]) {
        JKChangePasswordController *vc = [[JKChangePasswordController alloc]init];
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    
    
    if ([self.title isEqualToString:@"账号管理"]) {
        JKPersonInfoController *vc = [[JKPersonInfoController alloc]init];
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    
    
    
}
@end

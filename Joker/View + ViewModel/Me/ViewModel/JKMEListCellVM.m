//
//  JKMEListCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMEListCellVM.h"
#import "JKLogOutApi.h"
#import "CHTabBarViewController.h"
#import "JKMyLookPlayController.h"
#import "JKMyTopicController.h"
#import "JKMyMessageController.h"
#import "JKChangePasswordController.h"
#import "JKPersonInfoController.h"
@implementation JKMEListCellVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isRed = NO ;
    }
    return self;
}


- (void)goNext{
    
    if ([self.title isEqualToString:@"退出登录"]) {
        
        UIAlertView *alerv=[[UIAlertView alloc]initWithTitle:@"你确定要退出吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        alerv.alertViewStyle=UIAlertViewStyleDefault;
        [alerv show];
    }
    
    
    if ([self.title isEqualToString:@"我的看玩"]) {
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        
        [self logout];
        
        
    }
    
}

- (void)logout{
    
    JKLogOutApi *api = [[JKLogOutApi alloc] init];
    [api startWithSuccessBlock:^(__kindof JKLogOutApi *request) {
        if ([[request.response.responseJSONObject objectForKey:@"code"] isEqualToString:@"200"]) {
            [[JKUserManager sharedData] disableCurrentUser];
//            [self.delegate refreshUI];
            [[CHNetworkConfig sharedInstance] clearHeaderFiled];
            
            [[ASNavigator shareModalCenter] popHomeViewControllerWithAnimation:YES completion:^{
                if ([[[ASNavigator shareModalCenter] fetchCurrentViewController] isKindOfClass:[CHTabBarViewController class]]) {
                    CHTabBarViewController *tab = (CHTabBarViewController *)[[ASNavigator shareModalCenter]fetchCurrentViewController];
                    [tab.customTabBar setSelectIndex:0];
                    
                }
            }];
        }
    } failureBlock:^(__kindof JKLogOutApi *request) {
        
    }];
    

}


@end

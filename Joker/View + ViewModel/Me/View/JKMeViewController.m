//
//  JKMeViewController.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMeViewController.h"
#import "JKLogOutApi.h"
#import "CHTabBarViewController.h"
#import "JKUserManager.h"
@interface JKMeViewController ()

@end

@implementation JKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)clickBtn{
    
    JKLogOutApi *api = [[JKLogOutApi alloc] init];
    [api startWithSuccessBlock:^(__kindof JKLogOutApi *request) {
        if ([[request.response.responseJSONObject objectForKey:@"code"] isEqualToString:@"200"]) {
            [[JKUserManager sharedData] disableCurrentUser];
            [[CHNetworkConfig sharedInstance] clearHeaderFiled];
            [[ASNavigator shareModalCenter] popHomeViewControllerWithAnimation:YES completion:^{
//                if ([[[ASNavigator shareModalCenter] fetchCurrentViewController] isKindOfClass:[CHTabBarViewController class]]) {
//                    CHTabBarViewController *tab = (CHTabBarViewController *)[[ASNavigator shareModalCenter]fetchCurrentViewController];
//                    [tab.customTabBar setSelectIndex:0];
//                }
            }];
        }
    } failureBlock:^(__kindof JKLogOutApi *request) {
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

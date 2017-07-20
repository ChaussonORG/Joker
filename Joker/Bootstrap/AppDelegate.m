//
//  AppDelegate.m
//  joker
//
//  Created by 肖松 on 15-6-10.
//  Copyright (c) 2015年 chausson. All rights reserved.
//
#import "AppDelegate.h"
#import "ASNavigator.h"
#import "ASNavigationController.h"
#import "CHTabBarViewController.h"
//#import "HHTUserManager.h"
#import "CHNetworkConfig.h"
#import "JKStyleConfiguration.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <JSONModel/JSONModel.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate()

@property (nonatomic , strong) NSString *updateUrl;

@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    NSString *url = @"joker.dtxzw.com/platform";
    [[CHNetworkConfig sharedInstance]   setBaseUrl:url];
    [[CHNetworkConfig sharedInstance]   setAllowPrintLog:YES];
    [JSONModel setGlobalKeyMapper: [[JSONKeyMapper alloc] initWithDictionary: @{ @"id": @"identifier" }]];
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
   
    CHTabBarViewController *chtabController = [[CHTabBarViewController alloc]init];
    
    ASNavigationController *navigatior = [[ASNavigator shareModalCenter]innerWithHome:chtabController];
    
    [self.window setRootViewController: navigatior];
    
    
    [self.window makeKeyAndVisible];
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *token = @"NZxf%2FJmowivSDA%2Bm709UwJp3h4c2l7LME62UWPrTnnN1Ba9ohAgn9JHvuYxPYqeCiGBJpLmKZ4h8fQ%2BPPTIDkVdz93C50hf%2B%2Fg3c6%2FiwtZCi%2FGiSFbzG4nrPNkSf6YcYW19jE2pnLLcJzV5xXKZnQA%3D%3D";
    [dic setObject:token forKey:@"token"];
    
    [[CHNetworkConfig sharedInstance] addheaderFieldParameter:dic];
    
    //     [[PLeakSniffer sharedInstance] installLeakSniffer];
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

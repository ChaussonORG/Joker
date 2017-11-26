//
//  JKMySettingController.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/23.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMySettingController.h"

@interface JKMySettingController ()

@end

@implementation JKMySettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.view.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    
    
    
    // Do any additional setup after loading the view.
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

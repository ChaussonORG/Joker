//
//  JKPersonInfoCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPersonInfoCellVM.h"
#import "JKPersonInfoHeaderController.h"
#import "JKPersonInfoNameController.h"
#import "JKPersonInfoGenderController.h"
#import "JKPersonInfoBirthdayController.h"
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
        JKPersonInfoHeaderController *vc = [[JKPersonInfoHeaderController alloc]init];
        vc.imageUrl = self.content;
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    
    if ([self.mainTitle isEqualToString:@"昵称"]) {
        JKPersonInfoNameController *vc = [[JKPersonInfoNameController alloc]init];
        
        vc.name = self.content;
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    
    if ([self.mainTitle isEqualToString:@"性别"]) {
//        JKPersonInfoGenderController *vc = [[JKPersonInfoGenderController alloc]init];
//        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
        
        [self.delegate changeGender];
    }
    
    
    if ([self.mainTitle isEqualToString:@"生日"]) {
//        JKPersonInfoBirthdayController *vc = [[JKPersonInfoBirthdayController alloc]init];
//        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
        
        [self.delegate changeBrithDay];
    }
    
    
}
@end

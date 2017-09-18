//
//  JKVarietyTimeLineCollectionViewCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/7.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKVarietyTimeLineCollectionViewCellVM.h"
#import "JKVarietyDetailController.h"
@implementation JKVarietyTimeLineCollectionViewCellVM

- (void)gotoDetail{
    
    
    JKVarietyDetailController *vc = [[JKVarietyDetailController  alloc]initWithWorkId:self.extId];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
}
@end

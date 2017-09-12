//
//  JKAnimationTimeLineCollectionViewCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/5.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKAnimationTimeLineCollectionViewCellVM.h"
#import "JKAnimationDetailController.h"
@implementation JKAnimationTimeLineCollectionViewCellVM

- (void)gotoDetail{
    
    
    JKAnimationDetailController *vc = [[JKAnimationDetailController  alloc]initWithWorkId:self.extId];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
}
@end

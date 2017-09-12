//
//  JKGameTimeLineCollectionViewCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/5.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKGameTimeLineCollectionViewCellVM.h"
#import "JKGameDetailController.h"
@implementation JKGameTimeLineCollectionViewCellVM

- (void)gotoDetail{
    
    
    JKGameDetailController *vc = [[JKGameDetailController  alloc]initWithWorkId:self.extId];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
}
@end

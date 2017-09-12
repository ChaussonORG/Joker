//
//  JKTVTimeLineCollectionViewCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/29.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTVTimeLineCollectionViewCellVM.h"
#import "JKTVDetailController.h"
@implementation JKTVTimeLineCollectionViewCellVM



- (void)gotoDetail{
    
    
    JKTVDetailController *vc = [[JKTVDetailController  alloc]initWithWorkId:self.extId];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
}
@end

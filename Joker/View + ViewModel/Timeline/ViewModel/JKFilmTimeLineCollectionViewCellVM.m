//
//  JKFilmTimeLineCollectionViewCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKFilmTimeLineCollectionViewCellVM.h"
#import "JKWorkDetailController.h"
@implementation JKFilmTimeLineCollectionViewCellVM


- (void)gotoDetail{
    
    
    JKWorkDetailController *vc = [[JKWorkDetailController alloc]initWithWorkId:self.extId];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
}

@end

//
//  JKFilmCollectionViewCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKFilmCollectionViewCellVM.h"

@implementation JKFilmCollectionViewCellVM


- (void)chosed{
    
    
    [self.delegate fetchFilmCollectionViewCellVM:self];
    
}

@end

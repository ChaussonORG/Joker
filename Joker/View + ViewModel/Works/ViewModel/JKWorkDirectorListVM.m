//
//  JKWorkDirectorListVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/8.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkDirectorListVM.h"

@interface JKWorkDirectorListVM()

@property (nonatomic , strong) NSMutableArray <JKWorkDirectorListCellVM *>*cellViewModels;

@end

@implementation JKWorkDirectorListVM
- (instancetype)initWithTitle:(NSString*)title data:(NSArray *)data
{
    self = [super init];
    if (self) {
        
        
        self.naviTitle = title;
        
        self.cellViewModels = [NSMutableArray array];
        
        for (JKWorkDirectorListCellVM *cellVM in data) {
            
            [self.cellViewModels addObject:cellVM];
            
        }
        
    }
    return self;
}

@end

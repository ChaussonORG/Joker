//
//  JKWorkDirectorListVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/8.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKWorkDirectorListCellVM.h"
@interface JKWorkDirectorListVM : NSObject

@property (nonatomic , strong) NSString *naviTitle;

@property (nonatomic , strong ,readonly) NSMutableArray <JKWorkDirectorListCellVM *>*cellViewModels;


- (instancetype)initWithTitle:(NSString*)title data:(NSArray *)data;

@end

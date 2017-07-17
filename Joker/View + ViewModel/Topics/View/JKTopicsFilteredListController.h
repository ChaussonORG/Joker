//
//  JKTopicsFilteredListController.h
//  Joker
//
//  Created by 朱彦君 on 2017/6/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKTopicsFilteredListVM.h"
@interface JKTopicsFilteredListController : UIViewController


@property (nonatomic , strong) JKTopicsFilteredListVM *viewModel;


- (instancetype)initWithTopicSort:(JKTopicSort)sort;

@end

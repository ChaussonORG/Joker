//
//  JKWorkDirectorListController.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/8.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKWorkDirectorListVM.h"
@interface JKWorkDirectorListController : UIViewController
@property (nonatomic  ,strong) JKWorkDirectorListVM *viewModel;

- (instancetype)initWithTitle:(NSString*)title data:(NSArray *)data;
@end

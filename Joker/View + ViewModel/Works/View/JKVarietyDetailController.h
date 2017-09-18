//
//  JKVarietyDetailController.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/10.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKVarietyDetailVM.h"


@interface JKVarietyDetailController : UIViewController

@property (nonatomic  ,strong) JKVarietyDetailVM *viewModel;



- (instancetype)init __unavailable;

- (instancetype)initWithWorkId:(NSString *)workId;


@end

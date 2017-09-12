//
//  JKAnimationDetailController.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/10.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAnimationDetailVM.h"


@interface JKAnimationDetailController : UIViewController

@property (nonatomic  ,strong) JKAnimationDetailVM *viewModel;



- (instancetype)init __unavailable;

- (instancetype)initWithWorkId:(NSString *)workId;


@end

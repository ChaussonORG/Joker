//
//  JKWorkDetailController.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/30.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKWorkDetailVM.h"
@interface JKWorkDetailController : UIViewController

@property (nonatomic  ,strong) JKWorkDetailVM *viewModel;



- (instancetype)init __unavailable;

- (instancetype)initWithWorkId:(NSString *)workId;
@end

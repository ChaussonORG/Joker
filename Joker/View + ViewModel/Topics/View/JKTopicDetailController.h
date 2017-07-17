//
//  JKTopicDetailController.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKTopicDetailVM.h"
@interface JKTopicDetailController : UIViewController

@property (nonatomic ,strong) JKTopicDetailVM *viewModel;

- (instancetype)initWithTopicId:(NSString *)topicId;

@end

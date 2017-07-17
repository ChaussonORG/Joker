//
//  JKTopicDetailBottomView.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKTopicDetailBottomVM.h"
@interface JKTopicDetailBottomView : UIView

@property (nonatomic , strong) UIButton *refreshBtn;

@property (nonatomic , strong) UIButton *lastBtn;

@property (nonatomic , strong) UILabel *offsetLabel;

@property (nonatomic , strong) UIButton *nextBtn;

@property (nonatomic , strong) UIButton *replyBtn;

@property (nonatomic , strong) JKTopicDetailBottomVM *viewModel;

- (void)loadDataWithVM:(JKTopicDetailBottomVM *)viewModel;

@end

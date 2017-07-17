//
//  JKTopicListCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKTopicListCellVM.h"
@interface JKTopicListCell : UITableViewCell

@property (nonatomic , strong) UIImageView *headerView;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , strong) UILabel *relatedLabel;

@property (nonatomic , strong) UILabel *contentLabel;

@property (nonatomic , strong) UIButton *commentCountBtn;


@property (nonatomic,strong) JKTopicListCellVM *viewModel;

- (void)loadDataWithVM:(JKTopicListCellVM *)viewModel;


@end

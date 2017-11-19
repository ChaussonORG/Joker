//
//  JKMyMessageCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKMyMessageCellVM.h"
@interface JKMyMessageCell : UITableViewCell

@property (nonatomic , strong) UILabel *redpot;

@property (nonatomic , strong) UILabel *mainTitleLabel;

@property (nonatomic , strong) UIImageView *iconView;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , strong) UIView *contentBgView;

@property (nonatomic , strong) UILabel *contentLabel;

@property (nonatomic,strong) JKMyMessageCellVM *viewModel;

- (void)loadDataWithVM:(JKMyMessageCellVM *)viewModel;
@end

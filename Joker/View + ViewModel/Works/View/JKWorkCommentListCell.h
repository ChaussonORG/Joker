//
//  JKWorkCommentListCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKWorkCommentListCellVM.h"
#import "CTOCommentStarView.h"
@interface JKWorkCommentListCell : UITableViewCell
@property (nonatomic , strong) UIImageView *headerView;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , strong) UILabel *relatedLabel;

@property (nonatomic , strong) UIView *quoteView;

@property (nonatomic , strong) UILabel *quoteFloorLabel;

@property (nonatomic , strong) UILabel *quoteAutorLabel;

@property (nonatomic , strong) UILabel *quoteSendLabel;

@property (nonatomic , strong) UILabel *quoteContentLabel;

@property (nonatomic , strong) UILabel *contentLabel;

@property (nonatomic , strong) CTOCommentStarView *starView;

@property (nonatomic , strong) UILabel *pointLabel;

@property (nonatomic,strong) JKWorkCommentListCellVM *viewModel;

- (void)loadDataWithVM:(JKWorkCommentListCellVM *)viewModel;
@end

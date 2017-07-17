//
//  JKCommentListCell.h
//  JKCommentTableView
//
//  Created by 朱彦君 on 2017/6/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCommentListCellVM.h"
@interface JKCommentListCell : UITableViewCell

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

@property (nonatomic , strong) UITableView *subTableView;


@property (nonatomic,strong) JKCommentListCellVM *viewModel;

- (void)loadDataWithVM:(JKCommentListCellVM *)viewModel;


@end

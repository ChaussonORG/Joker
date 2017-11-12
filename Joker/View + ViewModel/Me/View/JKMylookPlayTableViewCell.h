//
//  JKMylookPlayTableViewCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTOCommentStarView.h"
#import "JKMylookPlayCellVM.h"
@interface JKMylookPlayTableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView *iconView;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) CTOCommentStarView *starView;

@property (nonatomic , strong) UILabel *pointLabel;

@property (nonatomic , strong) UILabel *unpointLabel;

@property (nonatomic , strong) UILabel *directorLabel;

@property (nonatomic , strong) UILabel *actorLabel;

@property (nonatomic,strong) JKMylookPlayCellVM *viewModel;

- (void)loadDataWithVM:(JKMylookPlayCellVM *)viewModel;

@end

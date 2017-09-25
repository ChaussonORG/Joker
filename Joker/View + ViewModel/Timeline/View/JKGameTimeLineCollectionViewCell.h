//
//  JKGameTimeLineCollectionViewCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/29.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTOCommentStarView.h"
#import "JKGameTimeLineCollectionViewCellVM.h"
@interface JKGameTimeLineCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) UIImageView *GameImage;

@property (nonatomic , strong) UILabel *belongTypeLabel;

@property (nonatomic , strong) UILabel *GameName;

@property (nonatomic , strong) UILabel *versionLabel;

@property (nonatomic , strong) UILabel *laugageLabel;

@property (nonatomic , strong) CTOCommentStarView *starView;

@property (nonatomic , strong) UILabel *pointLabel;

@property (nonatomic , strong) UILabel *unpointLabel;

@property (nonatomic , strong) JKGameTimeLineCollectionViewCellVM *viewModel;


- (void)loadDataWithVM:(JKGameTimeLineCollectionViewCellVM *)viewModel;
@end

//
//  JKTVTimeLineCollectionViewCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/29.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTOCommentStarView.h"
#import "JKTVTimeLineCollectionViewCellVM.h"
@interface JKTVTimeLineCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) UIImageView *TVImage;

@property (nonatomic , strong) UILabel *belongTypeLabel;

@property (nonatomic , strong) UILabel *TVName;

@property (nonatomic , strong) CTOCommentStarView *starView;

@property (nonatomic , strong) UILabel *pointLabel;


@property (nonatomic , strong) UILabel *unpointLabel;
@property (nonatomic , strong) JKTVTimeLineCollectionViewCellVM *viewModel;


- (void)loadDataWithVM:(JKTVTimeLineCollectionViewCellVM *)viewModel;
@end

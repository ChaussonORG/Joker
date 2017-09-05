//
//  JKAnimationTimeLineCollectionViewCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/29.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTOCommentStarView.h"
#import "JKAnimationTimeLineCollectionViewCellVM.h"
@interface JKAnimationTimeLineCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) UIImageView *AnimationImage;

@property (nonatomic , strong) UILabel *belongTypeLabel;

@property (nonatomic , strong) UILabel *AnimationName;

@property (nonatomic , strong) CTOCommentStarView *starView;

@property (nonatomic , strong) UILabel *pointLabel;


@property (nonatomic , strong) JKAnimationTimeLineCollectionViewCellVM *viewModel;


- (void)loadDataWithVM:(JKAnimationTimeLineCollectionViewCellVM *)viewModel;
@end

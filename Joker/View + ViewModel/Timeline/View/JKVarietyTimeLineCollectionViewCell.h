//
//  JKVarietyTimeLineCollectionViewCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/29.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTOCommentStarView.h"
#import "JKVarietyTimeLineCollectionViewCellVM.h"
@interface JKVarietyTimeLineCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) UIImageView *VarietyImage;

@property (nonatomic , strong) UILabel *belongTypeLabel;

@property (nonatomic , strong) UILabel *VarietyName;

@property (nonatomic , strong) CTOCommentStarView *starView;

@property (nonatomic , strong) UILabel *pointLabel;

@property (nonatomic , strong) UILabel *unpointLabel;

@property (nonatomic , strong) JKVarietyTimeLineCollectionViewCellVM *viewModel;


- (void)loadDataWithVM:(JKVarietyTimeLineCollectionViewCellVM *)viewModel;
@end

//
//  JKFilmTimeLineCollectionViewCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTOCommentStarView.h"
#import "JKFilmTimeLineCollectionViewCellVM.h"
@interface JKFilmTimeLineCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) UIImageView *filmImage;

@property (nonatomic , strong) UILabel *filmName;

@property (nonatomic , strong) CTOCommentStarView *starView;

@property (nonatomic , strong) UILabel *pointLabel;


@property (nonatomic , strong) UILabel *unpointLabel;

@property (nonatomic , strong) JKFilmTimeLineCollectionViewCellVM *viewModel;


- (void)loadDataWithVM:(JKFilmTimeLineCollectionViewCellVM *)viewModel;
@end

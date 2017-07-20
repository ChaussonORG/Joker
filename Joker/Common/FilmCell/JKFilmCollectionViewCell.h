//
//  JKFilmCollectionViewCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKFilmCollectionViewCellVM.h"
#import "CTOCommentStarView.h"
@interface JKFilmCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *filmImage;

@property (nonatomic , strong) UILabel *filmName;

@property (nonatomic , strong) CTOCommentStarView *starView;

@property (nonatomic , strong) UILabel *pointLabel;


@property (nonatomic , strong) JKFilmCollectionViewCellVM *viewModel;


- (void)loadDataWithVM:(JKFilmCollectionViewCellVM *)viewModel;

@end

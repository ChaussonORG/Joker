//
//  JKAnimationTimelineCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/27.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAnimationTimelineCellVM.h"
#import "JKRemanndationView.h"

@interface JKAnimationTimelineCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UILabel *dateLabel;



@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic,strong) JKAnimationTimelineCellVM *viewModel;

- (void)loadDataWithVM:(JKAnimationTimelineCellVM *)viewModel;

@end

//
//  JKTVTimelineCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/27.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKTVTimelineCellVM.h"
#import "JKRemanndationView.h"

@interface JKTVTimelineCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ClickRemanndationViewDelegate>

@property (nonatomic , strong) UILabel *dateLabel;



@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic,strong) JKTVTimelineCellVM *viewModel;

- (void)loadDataWithVM:(JKTVTimelineCellVM *)viewModel;

@end

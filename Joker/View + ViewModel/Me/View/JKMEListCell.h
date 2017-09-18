//
//  JKMEListCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKMEListCellVM.h"
@interface JKMEListCell : UITableViewCell

@property (nonatomic , strong) UILabel *mainTitleLabel;

@property (nonatomic , strong) UIImageView *arrowView;

@property (nonatomic , strong) UILabel *redLabel;

@property (nonatomic,strong) JKMEListCellVM *viewModel;

- (void)loadDataWithVM:(JKMEListCellVM *)viewModel;

@end

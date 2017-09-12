//
//  JKWorkDirectorListCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/8.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKWorkDirectorListCellVM.h"
@interface JKWorkDirectorListCell : UITableViewCell

@property (nonatomic , strong) UIImageView *icon;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *actLabel;


@property (nonatomic,strong) JKWorkDirectorListCellVM *viewModel;

- (void)loadDataWithVM:(JKWorkDirectorListCellVM *)viewModel;

@end

//
//  JKPersonInfoCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/12/10.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPersonInfoCellVM.h"
@interface JKPersonInfoCell : UITableViewCell

@property (nonatomic , strong) UILabel *mainTitleLabel;

@property (nonatomic , strong) UILabel *contentStrLabel;

@property (nonatomic , strong) UIImageView *headerIcon;
 
@property (nonatomic , strong) UIImageView *arrowIcon;

@property (nonatomic,strong) JKPersonInfoCellVM *viewModel;

- (void)loadDataWithVM:(JKPersonInfoCellVM *)viewModel;

@end

//
//  JKSubcommentListCell.h
//  JKCommentTableView
//
//  Created by 朱彦君 on 2017/6/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKSubcommentListCellVM.h"
@interface JKSubcommentListCell : UITableViewCell


@property (nonatomic , strong) UILabel *contentLabel;

@property (nonatomic,strong) JKSubcommentListCellVM *viewModel;

- (void)loadDataWithVM:(JKSubcommentListCellVM *)viewModel;



@end

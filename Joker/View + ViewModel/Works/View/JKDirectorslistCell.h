//
//  JKDirectorslistCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKFilmStaffCellVM.h"
@interface JKDirectorslistCell : UITableViewCell

@property (nonatomic , strong) UILabel *mainTitleLabel;

@property (nonatomic , strong) NSString *title;

@property (nonatomic , strong) NSArray <JKFilmStaffCellVM*>*directors;

- (void)loadUIWithTitle:(NSString *)title directors:(NSArray <JKFilmStaffCellVM*>*)directors;
@end

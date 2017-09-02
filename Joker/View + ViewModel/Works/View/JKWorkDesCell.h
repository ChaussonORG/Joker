//
//  JKWorkDesCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKWorkDesCell : UITableViewCell

@property (nonatomic , strong) UILabel *mainTitleLabel;

@property (nonatomic , strong) UILabel *descLabel;



- (void)LoadUIWithTitle:(NSString *)title desc:(NSString *)desc descLabelHeight:(CGFloat)descLabelHeight;


@end

//
//  JKRemanndationView.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/26.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickRemanndationViewDelegate <NSObject>

- (void)clickHoleViewWithExtId:(NSString *)extId;

@end

@interface JKRemanndationView : UIView

@property (nonatomic , weak) id<ClickRemanndationViewDelegate>delegate;

@property (nonatomic , strong) UIImageView *iconView;

@property (nonatomic , strong) UILabel *belongTypeLabel;

@property (nonatomic , strong) UILabel *versionLabel;

@property (nonatomic , strong) UILabel *laugageLabel;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UIImageView *favoriteView;

@property (nonatomic , strong) UILabel *favoriteCountLabel;

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic ,strong) UILabel *contentLabelOne;

@property (nonatomic ,strong) UILabel *contentLabelTwo;

@property (nonatomic , strong) UIView *lookPlayView;

@property (nonatomic , strong) UILabel *lookPlayTitle;

@property (nonatomic , strong) UILabel *lookPlayScore;

@property (nonatomic , strong) UIButton *score1;

@property (nonatomic , strong) UIButton *score2;

@property (nonatomic , strong) UIButton *score3;

@property (nonatomic , strong) UIButton *score4;

@property (nonatomic , strong) UIView *grayView;

@property (nonatomic , strong) NSString *extId;
@end

//
//  JKRemanndationView.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/26.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKRemanndationView.h"

@implementation JKRemanndationView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickRemanndationView)];
        
        [self addGestureRecognizer:tap];
        
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    self.iconView = [[UIImageView alloc]init];
    self.iconView.frame = CGRectMake(15, 15, 100, 140);
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.iconView];
    
    
    
    self.belongTypeLabel = [[UILabel alloc]init];
    self.belongTypeLabel.font = [JKStyleConfiguration minContentFont];
    self.belongTypeLabel.textColor = [JKStyleConfiguration whiteColor];
    self.belongTypeLabel.backgroundColor = [JKStyleConfiguration blackColor];
    self.belongTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.belongTypeLabel.hidden = YES;
    [self.iconView addSubview:self.belongTypeLabel];
    self.belongTypeLabel.frame = CGRectMake(self.iconView.frame.size.width - 22, 0, 22, 15);
    
    self.versionLabel = [[UILabel alloc]init];
    self.versionLabel.font = [JKStyleConfiguration minContentFont];
    self.versionLabel.textColor = [JKStyleConfiguration whiteColor];
    self.versionLabel.backgroundColor = [JKStyleConfiguration blackColor];
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    self.versionLabel.hidden = YES;
    [self.iconView addSubview:self.versionLabel];
    self.versionLabel.frame = CGRectMake(self.iconView.frame.size.width - 22, 0, 22, 15);
    
    
    self.laugageLabel = [[UILabel alloc]init];
    self.laugageLabel.font = [JKStyleConfiguration minContentFont];
    self.laugageLabel.textColor = [JKStyleConfiguration whiteColor];
    self.laugageLabel.backgroundColor = [JKStyleConfiguration blackColor];
    self.laugageLabel.textAlignment = NSTextAlignmentCenter;
    self.laugageLabel.hidden = YES;
    [self.iconView addSubview:self.laugageLabel];
    self.laugageLabel.frame = CGRectMake(self.versionLabel.frame.origin.x - 22- 1, 0, 22, 15);
    
    self.favoriteView = [[UIImageView alloc]init];
    self.favoriteView.frame = CGRectMake(ScreenWidth - 30 -20, 18, 20, 15);
    self.favoriteView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.favoriteView];

    self.favoriteCountLabel = [[UILabel alloc]init];
    self.favoriteCountLabel.font = [JKStyleConfiguration minContentFont];
    self.favoriteCountLabel.textColor = [JKStyleConfiguration aaaaaaColor];
    self.favoriteCountLabel.frame = CGRectMake(ScreenWidth - 30 - 25, self.favoriteView.frame.origin.y + self.favoriteView.frame.size.height, 30, 15);
    self.favoriteCountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.favoriteCountLabel];
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [JKStyleConfiguration hugeFont];
    self.nameLabel.textColor = [JKStyleConfiguration blackColor];
    self.nameLabel.frame = CGRectMake(self.iconView.frame.origin.x + self.iconView.frame.size.width + 15, 15, self.favoriteCountLabel.frame.origin.x - (self.iconView.frame.origin.x + self.iconView.frame.size.width + 15) - 10, 25);
    [self addSubview:self.nameLabel];
    
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [JKStyleConfiguration lineColor];
    self.lineView.frame = CGRectMake(self.nameLabel.frame.origin.x, self.favoriteCountLabel.frame.origin.y + self.favoriteCountLabel.frame.size.height + 5, ScreenWidth - 15 - self.nameLabel.frame.origin.x, 1);
    [self addSubview:self.lineView];
    
    
    self.lookPlayView = [[UIView alloc]init];
    self.lookPlayView.frame = CGRectMake(ScreenWidth - 15 - 44, self.lineView.frame.origin.y + self.lineView.frame.size.height + 12, 44, 54);
    self.lookPlayView.layer.borderColor = [JKStyleConfiguration blackColor].CGColor;
    self.lookPlayView.layer.borderWidth = 1;
    self.lookPlayView.layer.masksToBounds = YES;
    self.lookPlayView.layer.cornerRadius = 2;
    [self addSubview:self.lookPlayView];
    
    
    self.lookPlayTitle = [[UILabel alloc]init];
    self.lookPlayTitle.font = [JKStyleConfiguration middlecontentFont];
    self.lookPlayTitle.textColor = [JKStyleConfiguration blackColor];
    self.lookPlayTitle.frame = CGRectMake(0, 10, self.lookPlayView.frame.size.width, 12);
    self.lookPlayTitle.textAlignment = NSTextAlignmentCenter;
    self.lookPlayTitle.text = @"看玩指数";
    [self.lookPlayView addSubview:self.lookPlayTitle];
    
    
    self.lookPlayScore = [[UILabel alloc]init];
    self.lookPlayScore.font = [JKStyleConfiguration titleFont];
    self.lookPlayScore.textColor = [JKStyleConfiguration blackColor];
    self.lookPlayScore.frame = CGRectMake(0,self.lookPlayTitle.frame.size.height + self.lookPlayTitle.frame.origin.y  , self.lookPlayView.frame.size.width, self.lookPlayView.frame.size.height - 25);
    self.lookPlayScore.textAlignment = NSTextAlignmentCenter;
    [self.lookPlayView addSubview:self.lookPlayScore];
    
    
    
    self.contentLabelOne = [[UILabel alloc]init];
    self.contentLabelOne.font = [JKStyleConfiguration contentFont];
    self.contentLabelOne.textColor = [JKStyleConfiguration blackColor];
    self.contentLabelOne.frame = CGRectMake(self.nameLabel.frame.origin.x, self.lineView.frame.origin.y + self.lineView.frame.size.height + 10,  self.lookPlayView.frame.origin.x - 10 - self.nameLabel.frame.origin.x , 20);
    [self addSubview:self.contentLabelOne];
    
    
    self.contentLabelTwo = [[UILabel alloc]init];
    self.contentLabelTwo.font = [JKStyleConfiguration contentFont];
    self.contentLabelTwo.textColor = [JKStyleConfiguration blackColor];
    self.contentLabelTwo.numberOfLines = 2;
    self.contentLabelTwo.frame = CGRectMake(self.contentLabelOne.frame.origin.x, self.contentLabelOne.frame.origin.y + self.contentLabelOne.frame.size.height , self.contentLabelOne.frame.size.width , 40);
    [self addSubview:self.contentLabelTwo];
    
    
    self.score1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.score1 setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.score1.frame = CGRectMake(self.contentLabelTwo.frame.origin.x-5, self.contentLabelTwo.frame.size.height + self.contentLabelTwo.frame.origin.y + 10 , 55, 20);
    [self addSubview:self.score1];
    self.score1.titleLabel.font = [JKStyleConfiguration contentFont];
    [self.score1 setTitleColor:[JKStyleConfiguration sixsixColor] forState:UIControlStateNormal];
    self.score1.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.score2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.score2 setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.score2.frame = CGRectMake(self.score1.frame.origin.x + self.score1.frame.size.width , self.contentLabelTwo.frame.size.height + self.contentLabelTwo.frame.origin.y+ 10 , 55, 20);
    [self addSubview:self.score2];
    self.score2.titleLabel.font = [JKStyleConfiguration contentFont];
    [self.score2 setTitleColor:[JKStyleConfiguration sixsixColor] forState:UIControlStateNormal];
    self.score2.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.score3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.score3 setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.score3.frame = CGRectMake(self.score2.frame.origin.x + self.score2.frame.size.width, self.contentLabelTwo.frame.size.height + self.contentLabelTwo.frame.origin.y + 10, 55, 20);
    [self addSubview:self.score3];
    self.score3.titleLabel.font = [JKStyleConfiguration contentFont];
    [self.score3 setTitleColor:[JKStyleConfiguration sixsixColor] forState:UIControlStateNormal];
    self.score3.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.score4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.score4 setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.score4.frame = CGRectMake(self.score3.frame.origin.x + self.score3.frame.size.width, self.contentLabelTwo.frame.size.height + self.contentLabelTwo.frame.origin.y + 10, 55, 20);
    [self addSubview:self.score4];
    self.score4.titleLabel.font = [JKStyleConfiguration contentFont];
    [self.score4 setTitleColor:[JKStyleConfiguration sixsixColor] forState:UIControlStateNormal];
    self.score4.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.grayView = [[UIView alloc]init];
    self.grayView.backgroundColor = [JKStyleConfiguration screenSpareColor];
    self.grayView.frame = CGRectMake(0, 170, ScreenWidth, 10);
    [self addSubview:self.grayView];
    
    
}


- (void)clickRemanndationView{
    
    [self.delegate clickHoleViewWithExtId:self.extId];
    
}
@end

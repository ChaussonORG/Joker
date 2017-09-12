//
//  JKTVTimeLineCollectionViewCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTVTimeLineCollectionViewCell.h"

@implementation JKTVTimeLineCollectionViewCell
- (instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self prepareForLayout];
        
        
        [self binding];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCell)];
        
        [self addGestureRecognizer:tap];
        
    }
    
    return self;
    
}

- (void)prepareForLayout{
    
    self.TVImage = [[UIImageView alloc]init];
    //    self.TVImage.layer.cornerRadius = 12;
    //    self.TVImage.layer.masksToBounds = YES;
    
    self.belongTypeLabel = [[UILabel alloc]init];
    self.belongTypeLabel.font = [JKStyleConfiguration minContentFont];
    self.belongTypeLabel.textColor = [JKStyleConfiguration whiteColor];
    self.belongTypeLabel.backgroundColor = [JKStyleConfiguration blackColor];
    self.belongTypeLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.TVName = [[UILabel alloc]init];
    self.TVName.font = [JKStyleConfiguration subcontentFont];
    self.TVName.textColor = [JKStyleConfiguration blackColor];
    
    
    self.starView = [[CTOCommentStarView alloc]init];
    
    
    self.pointLabel = [[UILabel alloc]init];
    self.pointLabel.font = [JKStyleConfiguration contentFont];
    self.pointLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    
    [self.contentView addSubview:self.TVImage];
    [self.TVImage addSubview:self.belongTypeLabel];
    [self.contentView addSubview:self.TVName];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.pointLabel];
    
    self.TVImage.frame = CGRectMake((self.frame.size.width - 100)/2, 0, 100, 140);
    
    self.belongTypeLabel.frame = CGRectMake(self.TVImage.frame.size.width - 22, 0, 22, 15);
    
    self.TVName.frame = CGRectMake(self.TVImage.frame.origin.x, self.TVImage.frame.origin.y + self.TVImage.frame.size.height + 5 , 100, 20);
    
    
    self.starView.frame = CGRectMake(self.TVImage.frame.origin.x, self.TVName.frame.origin.y + self.TVName.frame.size.height,65, 20);
    
    
    self.pointLabel.frame = CGRectMake(self.starView.frame.origin.x + self.starView.frame.size.width , self.starView.frame.origin.y, 25, 20);
}


- (void)loadDataWithVM:(JKTVTimeLineCollectionViewCellVM *)viewModel{
    [self setViewModel:viewModel];
    
    
}
- (void)setViewModel:(JKTVTimeLineCollectionViewCellVM *)viewModel{
    _viewModel = viewModel;
}

- (void)binding{
    
    @weakify(self)
    [RACObserve(self, viewModel.imageUrl) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        NSURL * imageURL = [NSURL URLWithString:x];
        [self.TVImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"Launch"]];
        
    }];
    
    RAC(self,TVName.text) = RACObserve(self, viewModel.name);
    
    RAC(self,belongTypeLabel.text) = RACObserve(self, viewModel.belongType);
    
    [RACObserve(self, viewModel.jokerScore) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        self.pointLabel.text = x;
        
        CGFloat selectedCount = [self fetchSelectedCountWithScore:[x floatValue]];
        
        [self.starView refreshFrame:CGRectMake(self.TVImage.frame.origin.x, self.TVName.frame.origin.y + self.TVName.frame.size.height,60, 20) SelectedCount:selectedCount commentable:NO starMargin:1 starWidth:10];
        
        self.pointLabel.frame = CGRectMake(self.starView.frame.origin.x + self.starView.frame.size.width , self.starView.frame.origin.y, 25, 20);
    }];
    
    
    
}

- (CGFloat)fetchSelectedCountWithScore:(CGFloat)score{
    
    CGFloat selectedCount = 0.0;
    
    if (score < 1) {
        
        selectedCount = 0;
    }
    else if (score >= 1 && score < 2) {
        
        selectedCount = 0.5;
    }
    else if (score >= 2 && score < 3) {
        
        selectedCount = 1;
    }
    else if (score >= 3 && score < 4) {
        
        selectedCount = 1.5;
    }
    else if (score >= 4 && score < 5) {
        
        selectedCount = 2;
    }
    else if (score >= 5 && score < 6) {
        
        selectedCount = 2.5;
    }
    else if (score >= 6 && score < 7) {
        
        selectedCount = 3;
    }
    else if (score >= 7 && score < 8) {
        
        selectedCount = 3.5;
    }
    else if (score >= 8 && score < 9) {
        
        selectedCount = 4;
    }
    else if (score >= 9 && score < 10) {
        
        selectedCount = 4.5;
    }
    else if (score == 10.0) {
        
        selectedCount = 5;
    }
    
    
    return selectedCount;
    
    
}

- (void)clickCell{
    
    [self.viewModel gotoDetail];
    
    
    
}
@end

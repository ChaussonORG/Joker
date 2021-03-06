//
//  JKAnimationTimeLineCollectionViewCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKAnimationTimeLineCollectionViewCell.h"

@implementation JKAnimationTimeLineCollectionViewCell
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
    
    self.AnimationImage = [[UIImageView alloc]init];
    self.AnimationImage.contentMode = UIViewContentModeScaleAspectFill;
    //    self.AnimationImage.layer.cornerRadius = 12;
    //    self.AnimationImage.layer.masksToBounds = YES;
    self.AnimationImage.clipsToBounds = YES;
    
    self.belongTypeLabel = [[UILabel alloc]init];
    self.belongTypeLabel.font = [JKStyleConfiguration minContentFont];
    self.belongTypeLabel.textColor = [JKStyleConfiguration whiteColor];
    self.belongTypeLabel.backgroundColor = [JKStyleConfiguration blackColor];
    self.belongTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.belongTypeLabel.hidden = YES;
    
    self.AnimationName = [[UILabel alloc]init];
    self.AnimationName.font = [JKStyleConfiguration subcontentFont];
    self.AnimationName.textColor = [JKStyleConfiguration blackColor];
    
    
    self.starView = [[CTOCommentStarView alloc]init];
    
    
    self.pointLabel = [[UILabel alloc]init];
    self.pointLabel.font = [JKStyleConfiguration contentFont];
    self.pointLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    self.unpointLabel = [[UILabel alloc]init];
    self.unpointLabel.font = [JKStyleConfiguration contentFont];
    self.unpointLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    self.unpointLabel.text = @"暂无评分";
    
    self.favoriteCountLabel = [[UILabel alloc]init];
    self.favoriteCountLabel.font = [JKStyleConfiguration contentFont];
    self.favoriteCountLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    self.favoriteCountLabel.text = @"XXX人关注";
    [self.contentView addSubview:self.favoriteCountLabel];
    
    
    [self.contentView addSubview:self.unpointLabel];
    [self.contentView addSubview:self.AnimationImage];
    [self.AnimationImage addSubview:self.belongTypeLabel];
    [self.contentView addSubview:self.AnimationName];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.pointLabel];
    
    self.AnimationImage.frame = CGRectMake((self.frame.size.width - 100)/2, 0, 100, 140);
    
    self.belongTypeLabel.frame = CGRectMake(self.AnimationImage.frame.size.width - 22, 0, 22, 15);
    
    self.AnimationName.frame = CGRectMake(self.AnimationImage.frame.origin.x, self.AnimationImage.frame.origin.y + self.AnimationImage.frame.size.height + 5 , 100, 20);
    
    
    self.starView.frame = CGRectMake(self.AnimationImage.frame.origin.x, self.AnimationName.frame.origin.y + self.AnimationName.frame.size.height,65, 20);
    
    self.unpointLabel.frame = CGRectMake(self.AnimationName.frame.origin.x, self.AnimationName.frame.origin.y + self.AnimationName.frame.size.height,65, 20);
    self.unpointLabel.hidden = YES;
    
    self.favoriteCountLabel.frame = CGRectMake(self.AnimationImage.frame.origin.x, self.AnimationName.frame.origin.y + self.AnimationName.frame.size.height,65, 20);
    self.favoriteCountLabel.hidden = YES;
    self.pointLabel.frame = CGRectMake(self.starView.frame.origin.x + self.starView.frame.size.width , self.starView.frame.origin.y, 25, 20);
}


- (void)loadDataWithVM:(JKAnimationTimeLineCollectionViewCellVM *)viewModel{
    [self setViewModel:viewModel];
    
    
}
- (void)setViewModel:(JKAnimationTimeLineCollectionViewCellVM *)viewModel{
    _viewModel = viewModel;
}

- (void)binding{
    
    @weakify(self)
    [RACObserve(self, viewModel.imageUrl) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        NSString *image = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_mfit,h_200,w_280",x];
        NSURL * imageURL = [NSURL URLWithString:image];
        [self.AnimationImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"Launch"]];
        
    }];
    
    RAC(self,AnimationName.text) = RACObserve(self, viewModel.name);
    
    RAC(self,belongTypeLabel.text) = RACObserve(self, viewModel.belongType);
    
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.jokerScore),
                                RACObserve(self, viewModel.isON)]] subscribeNext:^(id x) {
        @strongify(self);
        
        if (self.viewModel.isON) {
            self.pointLabel.text = self.viewModel.jokerScore;
            
            CGFloat selectedCount = [self fetchSelectedCountWithScore:[self.viewModel.jokerScore floatValue]];
            
            [self.starView refreshFrame:CGRectMake(self.AnimationImage.frame.origin.x, self.AnimationName.frame.origin.y + self.AnimationName.frame.size.height,60, 20) SelectedCount:selectedCount commentable:NO starMargin:1 starWidth:10];
            
            self.pointLabel.frame = CGRectMake(self.starView.frame.origin.x + self.starView.frame.size.width , self.starView.frame.origin.y, 25, 20);
            
            if (selectedCount == 0) {
                self.unpointLabel.hidden = NO;
                
                self.pointLabel.hidden = YES;
                self.starView.hidden = YES;
                
                
                self.favoriteCountLabel.hidden = YES ;
            }
            else{
                
                self.unpointLabel.hidden = YES;
                self.pointLabel.hidden = NO;
                self.starView.hidden = NO;
                
                self.favoriteCountLabel.hidden = YES ;
            }
        }
        else{
            
            self.unpointLabel.hidden = YES;
            self.pointLabel.hidden = YES;
            self.starView.hidden = YES;
            
            self.favoriteCountLabel.hidden = NO ;
            
        }
        
    }];
    
    [RACObserve(self, viewModel.favoriteCount) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        NSString *str = [NSString stringWithFormat:@"%@人关注",x];
        NSMutableAttributedString *Astr1 = [[NSMutableAttributedString alloc]initWithString:str];
        
        [Astr1 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration aaaaaaColor] range:NSMakeRange(0, str.length)];
        [Astr1 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration redColor] range:NSMakeRange(0, x.length)];
        self.favoriteCountLabel.attributedText = Astr1;
        
        
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

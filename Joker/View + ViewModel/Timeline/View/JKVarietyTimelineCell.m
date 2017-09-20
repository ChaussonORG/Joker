//
//  JKVarietyTimelineCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/27.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKVarietyTimelineCell.h"
#import "JKVarietyTimeLineCollectionViewCell.h"
@implementation JKVarietyTimelineCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
        [self setUpSubViews];
        
        [self prepareForLayout];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self binding];
    }
    
    
    
    return self ;
}

- (void)setUpSubViews{
    
    UIView *dateView = [[UIView alloc]init];
    dateView.frame = CGRectMake(0, 0, ScreenWidth, 36);
    [self.contentView addSubview:dateView];
    dateView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    
    
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.textColor = [JKStyleConfiguration drakGrayTextColor];
    self.dateLabel.font = [JKStyleConfiguration subcontentFont];
    [dateView addSubview:self.dateLabel];
    self.dateLabel.frame = CGRectMake(20, 0, ScreenWidth, 36);
    
    
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0) collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.backgroundColor = [JKStyleConfiguration whiteColor];
    [_collectionView registerClass:[JKVarietyTimeLineCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.collectionView.scrollEnabled = NO;
    [self.contentView addSubview:self.collectionView];
    
}


- (void)prepareForLayout{
    
    
    
    
    
}

- (void)binding{
    
    @weakify(self)
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.isRecommend),
                                RACObserve(self, viewModel.cellViewModels),
                                RACObserve(self, viewModel.recommendViewHeight),
                                RACObserve(self, viewModel.collectionViewHeight)]] subscribeNext:^(id x) {
        @strongify(self);
        if (self.viewModel.isRecommend) {
            for (UIView *view in self.contentView.subviews) {
                
                if ([view isKindOfClass:[JKRemanndationView class]]) {
                    
                    [view removeFromSuperview];
                }
                
            }
            for (int i = 0 ; i < self.viewModel.recommendArr.count; i ++) {
                
                JKRemanndationView *remanndationView = [[JKRemanndationView alloc]init];
                
                remanndationView.delegate = self;
                remanndationView.frame = CGRectMake(0, self.dateLabel.frame.origin.y + self.dateLabel.frame.size.height + i * 180, ScreenWidth, 180);
                
                JKVarietyTimeLineCollectionViewCellVM *cellVM = self.viewModel.recommendArr[i];
                remanndationView.extId = cellVM.extId;
                NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_mfit,h_200,w_280",cellVM.imageUrl]];
                
                [remanndationView.iconView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"Launch"]];
                
                remanndationView.nameLabel.text = cellVM.name;
                
                remanndationView.favoriteCountLabel.text = cellVM.favoriteCount;
                
                //                remanndationView.contentLabelOne.text = cellVM.directors;
                NSMutableAttributedString *Astr1 = [[NSMutableAttributedString alloc]initWithString:cellVM.directors];
                
                [Astr1 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration aaaaaaColor] range:NSMakeRange(0, cellVM.directors.length)];
                [Astr1 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration blackColor] range:NSMakeRange(0, 3)];
                remanndationView.contentLabelOne.attributedText = Astr1;
                
                NSMutableAttributedString *Astr2 = [[NSMutableAttributedString alloc]initWithString:cellVM.mainActors];
                [Astr2 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration aaaaaaColor] range:NSMakeRange(0, cellVM.mainActors.length)];
                [Astr2 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration blackColor] range:NSMakeRange(0, 3)];
                remanndationView.contentLabelTwo.attributedText = Astr2;
                
                
                //                remanndationView.contentLabelTwo.text = cellVM.mainActors;
                remanndationView.score1.hidden = YES ;
                remanndationView.score2.hidden = YES ;
                remanndationView.score3.hidden = YES ;
                remanndationView.score4.hidden = YES ;
                [remanndationView.score1 setTitle:cellVM.score1 forState:UIControlStateNormal];
                [remanndationView.score1 setImage:[UIImage imageNamed:@"douban"] forState:UIControlStateNormal];
                [remanndationView.score1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
                
                [remanndationView.score2 setTitle:cellVM.score2 forState:UIControlStateNormal];
                [remanndationView.score2 setImage:[UIImage imageNamed:@"imdb"] forState:UIControlStateNormal];
                [remanndationView.score2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
                
                
                [remanndationView.score3 setTitle:[NSString stringWithFormat:@"%ld%%",[cellVM.score3 integerValue]*10] forState:UIControlStateNormal];
                [remanndationView.score3 setImage:[UIImage imageNamed:@"fanqie"] forState:UIControlStateNormal];
                [remanndationView.score3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
                
                [remanndationView.score4 setTitle:cellVM.score4 forState:UIControlStateNormal];
                [remanndationView.score4 setImage:[UIImage imageNamed:@"m"] forState:UIControlStateNormal];
                [remanndationView.score4 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
                
                if ([cellVM.jokerScore integerValue] > 0) {
                    remanndationView.lookPlayScore.text = cellVM.jokerScore;
                    remanndationView.lookPlayScore.font = [JKStyleConfiguration veryHugeFont];
                }
                else{
                    
                    remanndationView.lookPlayScore.text = @"暂无";
                    remanndationView.lookPlayScore.font = [JKStyleConfiguration subcontentFont];
                }
                
                //                if (cellVM.belongType.length > 0) {
                //
                //                    remanndationView.belongTypeLabel.hidden = NO;
                //                    remanndationView.belongTypeLabel.text = cellVM.belongType;
                //                }
                //                else{
                //
                //                    remanndationView.belongTypeLabel.hidden = NO;
                //
                //                }
                
                if (cellVM.isfavorite) {
                    
                    remanndationView.favoriteView.image = [UIImage imageNamed:@"guanzhu"];
                }
                else{
                    
                    remanndationView.favoriteView.image = [UIImage imageNamed:@"guanzhuan"];
                }
                
                
                [self.contentView addSubview:remanndationView];
                
            }
            self.collectionView.frame = CGRectMake(0, self.viewModel.recommendViewHeight + 36, ScreenWidth, self.viewModel.collectionViewHeight);
            
        }
        else{
            
            [self.contentView bringSubviewToFront:self.collectionView];
            for (UIView *view in self.contentView.subviews) {
                
                if ([view isKindOfClass:[JKRemanndationView class]]) {
                    
                    [view removeFromSuperview];
                }
                
            }
            self.collectionView.frame = CGRectMake(0, self.viewModel.recommendViewHeight + self.dateLabel.frame.origin.y + self.dateLabel.frame.size.height, ScreenWidth, self.viewModel.collectionViewHeight);
        }
        
        [self.collectionView reloadData];
    }];
    
    
    RAC(self,dateLabel.text) = RACObserve(self, viewModel.date);
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.viewModel.cellViewModels.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"UICollectionViewCell";
    JKVarietyTimeLineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 80)/3, 185);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

- (void)loadDataWithVM:(JKVarietyTimelineCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKVarietyTimelineCellVM *)viewModel{
    _viewModel = viewModel;
    
}
- (void)clickHoleViewWithExtId:(NSString *)extId{
    
    
    [self.viewModel gotoDetailWithWorkId:extId];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

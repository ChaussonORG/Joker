//
//  JKGameTimelineCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/27.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKGameTimelineCell.h"
#import "JKGameTimeLineCollectionViewCell.h"
@implementation JKGameTimelineCell
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
    self.dateLabel.frame = CGRectMake(20, 0, ScreenWidth - 40, 36);
    
    
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0) collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.backgroundColor = [JKStyleConfiguration whiteColor];
    [_collectionView registerClass:[JKGameTimeLineCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
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
                                RACObserve(self, viewModel.recommendArr),
                                RACObserve(self, viewModel.collectionViewHeight)]] subscribeNext:^(id x) {
        @strongify(self);
        if (self.viewModel.isRecommend) {
            for (int i = 0 ; i < self.viewModel.recommendArr.count; i ++) {
                
                JKRemanndationView *remanndationView = [[JKRemanndationView alloc]init];
                
                
                remanndationView.frame = CGRectMake(0, self.dateLabel.frame.origin.y + self.dateLabel.frame.size.height + i * 180, ScreenWidth, 180);
                
                JKGameTimeLineCollectionViewCellVM *cellVM = self.viewModel.recommendArr[i];
                
                NSURL * imageURL = [NSURL URLWithString:cellVM.imageUrl];
                
                [remanndationView.iconView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"Launch"]];
                
                remanndationView.nameLabel.text = cellVM.name;
                
                remanndationView.favoriteCountLabel.text = cellVM.favoriteCount;
                
                remanndationView.contentLabelOne.text = cellVM.platform;
                
                remanndationView.contentLabelTwo.text = [NSString stringWithFormat:@"%@ %@",cellVM.version,cellVM.language];
                
                [remanndationView.score1 setTitle:cellVM.score1 forState:UIControlStateNormal];
                
                [remanndationView.score2 setTitle:cellVM.score2 forState:UIControlStateNormal];
                
                [remanndationView.score3 setTitle:cellVM.score3 forState:UIControlStateNormal];
                
                [remanndationView.score4 setTitle:cellVM.score4 forState:UIControlStateNormal];
                
                remanndationView.lookPlayScore.text = cellVM.jokerScore;
                
                if (cellVM.belongType.length > 0) {
                    
                    remanndationView.belongTypeLabel.hidden = NO;
                    remanndationView.belongTypeLabel.text = cellVM.belongType;
                }
                else{
                    
                    remanndationView.belongTypeLabel.hidden = NO;
                    
                }
                
                [self.contentView addSubview:remanndationView];
                
            }
            self.collectionView.frame = CGRectMake(0, self.viewModel.recommendViewHeight + 36, ScreenWidth, self.viewModel.collectionViewHeight);
            
        }
        else{
            
            [self.contentView
             bringSubviewToFront:self.collectionView];
            
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
    JKGameTimeLineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
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

- (void)loadDataWithVM:(JKGameTimelineCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKGameTimelineCellVM *)viewModel{
    _viewModel = viewModel;
    
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

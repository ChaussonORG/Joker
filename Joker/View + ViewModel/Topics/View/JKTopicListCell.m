//
//  JKTopicListCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicListCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface JKTopicListCell ()

@property (nonatomic , strong) UIView *grayView;

@property (nonatomic , strong) UIView *topLineView;

@property (nonatomic , strong) UIView *lineView;

@end


@implementation JKTopicListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
        [self setUpSubViews];
        
        [self prepareForLayout];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTopicListCell)];
        
        [self addGestureRecognizer:tap];
        
        
        [self binding];
    }
    
    
    
    return self ;
}

- (void)setUpSubViews{
    
    self.grayView = [[UIView alloc]init];
    self.grayView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    
//    self.topLineView = [[UIView alloc]init];
    //    self.topLineView.backgroundColor = [HHTStyleConfiguration lineColor];
    
    
    
    self.headerView = [[UIImageView alloc]init];
    self.headerView.layer.cornerRadius = 35/2;
    self.headerView.layer.masksToBounds = YES;
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [JKStyleConfiguration subcontentFont];
    self.nameLabel.textColor = [JKStyleConfiguration blackColor];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [JKStyleConfiguration contentFont];
    self.timeLabel.textColor = [JKStyleConfiguration aaaaaaColor];
    
    
    self.relatedLabel = [[UILabel alloc]init];
    self.relatedLabel.font = [JKStyleConfiguration subcontentFont];
    self.relatedLabel.textColor = [JKStyleConfiguration sixsixColor];
    self.relatedLabel.textAlignment =NSTextAlignmentRight;
    self.relatedLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickRelatedLabel)];
    [self.relatedLabel addGestureRecognizer:tap];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [JKStyleConfiguration titleFont];
    self.contentLabel.textColor = [JKStyleConfiguration blackColor];
    self.contentLabel.numberOfLines = 0;
    
    
    self.commentCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentCountBtn setTitleColor:[JKStyleConfiguration aaaaaaColor] forState:UIControlStateNormal];
    self.commentCountBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.commentCountBtn addTarget:self action:@selector(clickCommentCountBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.commentCountBtn setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
     [self.commentCountBtn setTitleEdgeInsets:UIEdgeInsetsMake(- 2, 10, 0, 0)];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [JKStyleConfiguration lineColor];
    
    
    [self.contentView addSubview:self.grayView];
    [self.contentView addSubview:self.headerView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.relatedLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.commentCountBtn];
    [self.contentView addSubview:self.lineView];
    
    
}


- (void)prepareForLayout{
    
    self.grayView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 6);
    
    self.headerView.frame = CGRectMake(25, self.grayView.frame.origin.y + self.grayView.frame.size.height + 15, 35, 35);
    
 
    
}

- (void)binding{
    
    RAC(self, nameLabel.text) = RACObserve(self, viewModel.name);
    
    RAC(self, timeLabel.text) = RACObserve(self, viewModel.time);
    
    RAC(self, relatedLabel.text) = RACObserve(self, viewModel.related);
    
    RAC(self, contentLabel.text) = RACObserve(self, viewModel.content);
    
    
    
    @weakify(self);
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.nameLabelWeight),
                                RACObserve(self, viewModel.contentLabelHeight),
                                RACObserve(self, viewModel.cellHeight)]] subscribeNext:^(id x) {
        @strongify(self);
    
        CGFloat nameLabelWeight = [x[0] floatValue] + 1;
        CGFloat contentLabelHeight = [x[1] floatValue] + 1;
        CGFloat cellHeight = [x[2] floatValue];
        
        if (nameLabelWeight > [UIScreen mainScreen].bounds.size.width/3*2) {
            
            nameLabelWeight = [UIScreen mainScreen].bounds.size.width/3*2;
        }
        
        self.nameLabel.frame = CGRectMake(self.headerView.frame.origin.x + self.headerView.frame.size.width + 10, self.headerView.frame.origin.y , nameLabelWeight, 18);
        
        self.timeLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height, 120, 17);
        
        self.relatedLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 20 - ([UIScreen mainScreen].bounds.size.width - (self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + 50) - 25)*3/4, self.nameLabel.frame.origin.y, ([UIScreen mainScreen].bounds.size.width - (self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + 50) - 25)*3/4 , 35);
        
        
        
        self.contentLabel.frame = CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y + self.headerView.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 50 , contentLabelHeight);
        
        self.commentCountBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50 - 15, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 5, 50, 30);
        
    }];
    
    
    [RACObserve(self, viewModel.commentCount) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        [self.commentCountBtn setTitle:x forState:UIControlStateNormal];
    }];
    
    
    [RACObserve(self, viewModel.headerUrl) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        
    }];
}

- (void)loadDataWithVM:(JKTopicListCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKTopicListCellVM *)viewModel{
    _viewModel = viewModel;
    
}


- (void)clickTopicListCell{
    
    
    [self.viewModel openTopicDetail];
    
    
}

- (void)clickCommentCountBtn{
    
    
    [self.viewModel openTopicComment];
    
}

- (void)clickRelatedLabel{
    
    
    [self.viewModel openWorkDetail];
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

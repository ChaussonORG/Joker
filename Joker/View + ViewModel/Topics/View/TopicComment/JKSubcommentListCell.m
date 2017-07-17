//
//  JKSubcommentListCell.m
//  JKCommentTableView
//
//  Created by 朱彦君 on 2017/6/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKSubcommentListCell.h"
#import "JKStyleConfiguration.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface JKSubcommentListCell() 
@property (nonatomic , strong) UIView *lineView;

@end
@implementation JKSubcommentListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration grayBackgroundColor];
        
        [self setUpSubViews];
        
        [self prepareForLayout];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTopicListCell)];
        //
        //        [self addGestureRecognizer:tap];
        
        
        [self binding];
    }
    
    
    
    return self ;
}

- (void)setUpSubViews{
    
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [JKStyleConfiguration titleFont];
    self.contentLabel.textColor = [JKStyleConfiguration blackColor];
    self.contentLabel.numberOfLines = 0;
    
    
    self.lineView = [[UILabel alloc]init];
    self.lineView.backgroundColor = [JKStyleConfiguration lineColor];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.lineView];
    
    
}


- (void)prepareForLayout{
    
    
    
}

- (void)binding{
    
 
    RAC(self, contentLabel.text) = RACObserve(self, viewModel.content);
    
    
    
    @weakify(self);
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.contentLabelHeight),
                                RACObserve(self, viewModel.cellHeight)]] subscribeNext:^(id x) {
        @strongify(self);
        
        
        CGFloat contentLabelHeight = [x[0] floatValue] + 1;
        CGFloat cellHeight = [x[1] floatValue];
        
        self.contentLabel.frame = CGRectMake(12,  10, [UIScreen mainScreen].bounds.size.width - 40 - 12 - 15 , contentLabelHeight);
        
        self.lineView.frame = CGRectMake(12, cellHeight - 1, [UIScreen mainScreen].bounds.size.width - 40 - 12 - 15, 1);
    
    }];
}


- (void)loadDataWithVM:(JKSubcommentListCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKSubcommentListCellVM *)viewModel{
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

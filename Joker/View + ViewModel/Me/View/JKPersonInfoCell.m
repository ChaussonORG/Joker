//
//  JKPersonInfoCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/10.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPersonInfoCell.h"

@implementation JKPersonInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        [self setupSubviews];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCell)];
        
        [self addGestureRecognizer:tap];
        
        [self binding];
        
    }
    return self;
}
- (void)setupSubviews{
    
    self.mainTitleLabel = [[UILabel alloc]init];
    self.mainTitleLabel.frame = CGRectMake(25, 15, 80, 20);
    self.mainTitleLabel.font = [JKStyleConfiguration overstrikingFont];
    self.mainTitleLabel.textColor = [JKStyleConfiguration twotwoColor];
    [self.contentView addSubview:self.mainTitleLabel];
    
    self.contentStrLabel = [[UILabel alloc]init];
    self.contentStrLabel.frame = CGRectMake(ScreenWidth - 120 - 35, 15, 120, 20);
    self.contentStrLabel.font = [JKStyleConfiguration titleFont];
    self.contentStrLabel.textColor = [JKStyleConfiguration twotwoColor];
    self.contentStrLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.contentStrLabel];
    
    
    self.headerIcon = [[UIImageView alloc]init];
    self.headerIcon.frame = CGRectMake(ScreenWidth - 35 - 35, 10, 35, 35);
    self.headerIcon.layer.masksToBounds = YES;
    self.headerIcon.layer.cornerRadius = 35/2;
    [self.contentView addSubview:self.headerIcon];
    
    
    self.arrowIcon = [[UIImageView alloc]init];
    self.arrowIcon.frame = CGRectMake(ScreenWidth - 7 - 20, 20, 7, 13);
    self.arrowIcon.image = [UIImage imageNamed:@"youjiantou"];
    [self.contentView addSubview:self.arrowIcon];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [JKStyleConfiguration lineColor];
    lineView.frame = CGRectMake(25, 49, ScreenWidth - 50, 1);
    [self.contentView addSubview:lineView];
}

- (void)binding{
    @weakify(self)
    [RACObserve(self, viewModel.type) subscribeNext:^(id x) {
        @strongify(self)
        
        if (self.viewModel.type == JKPersonInfoWord) {
    
            self.contentStrLabel.text = self.viewModel.content;
        
            self.contentStrLabel.hidden = NO;
            
            self.headerIcon.hidden = YES;
        }
        else{
            
            [self.headerIcon sd_setImageWithURL:[NSURL URLWithString:self.viewModel.content] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            
            self.contentStrLabel.hidden = YES;
            
            self.headerIcon.hidden = NO;
            
        }
        
    }];
    
    RAC(self,mainTitleLabel.text) = RACObserve(self, viewModel.mainTitle);
    
  
    
}
- (void)loadDataWithVM:(JKPersonInfoCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKPersonInfoCellVM *)viewModel{
    _viewModel = viewModel;
    
}

- (void)clickCell{
    
    [self.viewModel  gotoEditInfo];
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

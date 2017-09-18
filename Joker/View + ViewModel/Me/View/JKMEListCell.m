//
//  JKMEListCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMEListCell.h"

@implementation JKMEListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
        [self setUpSubViews];
        
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCell)];
        
        [self addGestureRecognizer:tap];
    
        
        [self binding];
        
    }
    
    
    
    return self ;
}

- (void)setUpSubViews{
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [JKStyleConfiguration lineColor];
    [self.contentView addSubview:line];
    line.frame = CGRectMake(0, 0, ScreenWidth, 1);
    
    self.mainTitleLabel = [[UILabel alloc]init];
    self.mainTitleLabel.frame = CGRectMake(30, 20,70, 20);
    self.mainTitleLabel.font = [JKStyleConfiguration hugeFont];
    self.mainTitleLabel.textColor = [JKStyleConfiguration twotwoColor];
    [self.contentView addSubview:self.mainTitleLabel];
    
    
    
    self.redLabel = [[UILabel alloc]init];
    self.redLabel.frame = CGRectMake(self.mainTitleLabel.frame.origin.x + self.mainTitleLabel.frame.size.width, self.mainTitleLabel.frame.origin.y  ,5, 5);
    self.redLabel.layer.cornerRadius = 2.5;
    self.redLabel.layer.masksToBounds = YES;
    self.redLabel.backgroundColor = [JKStyleConfiguration redColor];
    
    [self.contentView addSubview:self.redLabel];

    
    
    self.arrowView = [[UIImageView alloc]init];
    self.arrowView.image = [UIImage imageNamed:@"jiantouyou"];
    self.arrowView.frame = CGRectMake(ScreenWidth - 20 - 6, 24, 6, 12);
    [self.contentView addSubview:self.arrowView];
    
}


- (void)binding{
    
    RAC(self, mainTitleLabel.text) = RACObserve(self, viewModel.title);
    
    @weakify(self);
    [RACObserve(self, viewModel.isRed) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        
        if ([x boolValue]) {
            
            self.redLabel.hidden = NO;
        }
        else{
            
            self.redLabel.hidden = YES;
        }
        
    }];
    
}

- (void)loadDataWithVM:(JKMEListCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKMEListCellVM *)viewModel{
    _viewModel = viewModel;
    
}

- (void)clickCell{
    
    [self.viewModel goNext];
    
    
    
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

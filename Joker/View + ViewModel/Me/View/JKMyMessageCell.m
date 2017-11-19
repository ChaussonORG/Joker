//
//  JKMyMessageCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyMessageCell.h"


@interface  JKMyMessageCell()
@property (nonatomic , strong) UIView *lineView;
@end
@implementation JKMyMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
        [self setUpSubViews];
        
        [self prepareForLayout];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCell)];
        
        [self addGestureRecognizer:tap];
        
        
        [self binding];
    }
    
    
    
    return self ;
}

- (void)setUpSubViews{
    
    self.redpot = [[UILabel alloc]init];
    self.redpot.backgroundColor = [JKStyleConfiguration redColor];
    self.redpot.layer.cornerRadius = 2.5;
    self.redpot.layer.masksToBounds = YES;
    
    self.iconView = [[UIImageView alloc]init];
    self.iconView.layer.cornerRadius = 35/2;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    self.contentBgView = [[UIView alloc]init];
    self.contentBgView.backgroundColor = [JKStyleConfiguration grayBackgroundColor];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [JKStyleConfiguration subcontentFont];
    self.contentLabel.textColor = [JKStyleConfiguration blackColor];
    self.contentLabel.numberOfLines = 0;
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [JKStyleConfiguration subcontentFont];
    self.timeLabel.textColor = [JKStyleConfiguration blackColor];
    
    self.mainTitleLabel = [[UILabel alloc]init];
    self.mainTitleLabel.font = [JKStyleConfiguration contentFont];
    self.mainTitleLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    self.mainTitleLabel.numberOfLines = 0;
    
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [JKStyleConfiguration lineColor];
    
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.redpot];
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView addSubview:self.contentLabel];
    [self.contentView addSubview:self.mainTitleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];
    
    
}


- (void)prepareForLayout{
    
    
    self.redpot.frame = CGRectMake(8, 40, 5, 5);
    
    self.iconView.frame = CGRectMake(20, 25, 35, 35);
    
}

- (void)binding{
     @weakify(self);
    [RACObserve(self, viewModel.isRead) subscribeNext:^(id x) {
         @strongify(self);
        
        if (self.viewModel.isRead) {
            self.redpot.hidden = YES;
        }
        else{
            
            self.redpot.hidden = NO;
        }
    }];
    
    
    [RACObserve(self, viewModel.icon) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        NSURL * imageURL = [NSURL URLWithString:x];
        [self.iconView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"touxiang"]];
        
    }];
    
    
    RAC(self,timeLabel.text)  = RACObserve(self, viewModel.time);
   
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.titleHeight),
                                RACObserve(self, viewModel.contentHeight),RACObserve(self, viewModel.cellHeight)]] subscribeNext:^(id x) {
        @strongify(self);
        
        self.mainTitleLabel.frame = CGRectMake(self.iconView.frame.origin.x + self.iconView.frame.size.width + 8, 32, ScreenWidth - 20 - (self.iconView.frame.origin.x + self.iconView.frame.size.width + 8), self.viewModel.titleHeight + 1);
        
        self.timeLabel.text = self.viewModel.time;
        self.timeLabel.frame = CGRectMake(self.mainTitleLabel.frame.origin.x, self.mainTitleLabel.frame.origin.y + self.mainTitleLabel.frame.size.height + 10, 150, 20);
        
        self.contentBgView.frame = CGRectMake(self.iconView.frame.origin.x, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height + 15, ScreenWidth - 40, self.viewModel.contentHeight + 25);
        
        self.contentLabel.frame = CGRectMake(10, 10, self.contentBgView.frame.size.width - 20, self.viewModel.contentHeight);
        
        self.contentLabel.text = self.viewModel.content;
        
        self.lineView.frame = CGRectMake(0, 0, ScreenWidth, 10);
        
        if (self.viewModel.title) {
            NSMutableAttributedString *Astr1 = [[NSMutableAttributedString alloc]initWithString:self.viewModel.title];
            [Astr1 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration aaaaaaColor] range:NSMakeRange(0, self.viewModel.title.length)];
            [Astr1 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration blackColor] range:NSMakeRange(0, self.viewModel.name.length)];
            [Astr1 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration blackColor] range:NSMakeRange(self.viewModel.name.length + self.viewModel.titleStr2Count, self.viewModel.projectName.length)];
            self.mainTitleLabel.attributedText = Astr1;
        }
        
        if (self.viewModel.content.length == 0) {
            
            self.contentBgView.hidden = YES;
        }
        else{
            self.contentBgView.hidden = NO;
        }
    }];
    
  
    
    
    
}
- (void)loadDataWithVM:(JKMyMessageCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKMyMessageCellVM *)viewModel{
    _viewModel = viewModel;
    
}
- (void)clickCell{
    
    
    [self.viewModel gotoDetail];
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

//
//  JKMylookPlayTableViewCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMylookPlayTableViewCell.h"

@interface  JKMylookPlayTableViewCell()

@property (nonatomic , strong) UIView *lineView;
@end

@implementation JKMylookPlayTableViewCell
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
    
    self.iconView = [[UIImageView alloc]init]; 
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [JKStyleConfiguration subcontentFont];
    self.nameLabel.textColor = [JKStyleConfiguration blackColor];
    
    self.starView = [[CTOCommentStarView alloc]init];
    
    
    self.pointLabel = [[UILabel alloc]init];
    self.pointLabel.font = [JKStyleConfiguration contentFont];
    self.pointLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    
    
    self.unpointLabel = [[UILabel alloc]init];
    self.unpointLabel.font = [JKStyleConfiguration contentFont];
    self.unpointLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    self.unpointLabel.text = @"暂无评分";
    [self.contentView addSubview:self.unpointLabel];
    
    
    
    self.directorLabel = [[UILabel alloc]init];
    self.directorLabel.font = [JKStyleConfiguration contentFont];
    
    
    
    self.actorLabel = [[UILabel alloc]init];
    self.actorLabel.font = [JKStyleConfiguration contentFont];
    
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [JKStyleConfiguration lineColor];
    
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.pointLabel];
    [self.contentView addSubview:self.unpointLabel];
    [self.contentView addSubview:self.directorLabel];
    [self.contentView addSubview:self.actorLabel];
    [self.contentView addSubview:self.lineView];
    
    
}


- (void)prepareForLayout{
    
    self.iconView.frame = CGRectMake(15, 15, 70, 100);
    
    self.nameLabel.frame = CGRectMake(self.iconView.frame.origin.x + self.iconView.frame.size.width + 15, 20, ScreenWidth - 115 , 25);
    
    self.starView.frame = CGRectMake(self.iconView.frame.origin.x + self.iconView.frame.size.width+ 15, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5 , 65, 20);
    self.unpointLabel.frame = CGRectMake(self.iconView.frame.origin.x + self.iconView.frame.size.width+ 15, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5,65, 20);
    self.unpointLabel.hidden = YES;
    
    self.pointLabel.frame = CGRectMake(self.starView.frame.origin.x + self.starView.frame.size.width , self.starView.frame.origin.y, 25, 20);
    
    self.directorLabel.frame = CGRectMake(self.iconView.frame.origin.x + self.iconView.frame.size.width + 15, self.starView.frame.origin.y + self.starView.frame.size.height, ScreenWidth - 115 , 20);
    
    self.actorLabel.frame = CGRectMake(self.directorLabel.frame.origin.x, self.directorLabel.frame.origin.y + self.directorLabel.frame.size.height, ScreenWidth - 115 , 20);
    
}

- (void)binding{
    
    RAC(self, nameLabel.text) = RACObserve(self, viewModel.name);
     
    
    @weakify(self);
    [RACObserve(self, viewModel.score) subscribeNext:^(id x) {
        @strongify(self);
        
        self.pointLabel.text = self.viewModel.score;
        
        CGFloat selectedCount = [self fetchSelectedCountWithScore:[self.viewModel.score floatValue]];
        
        [self.starView refreshFrame:CGRectMake(self.iconView.frame.origin.x + self.iconView.frame.size.width, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5 , 65, 20) SelectedCount:selectedCount commentable:NO starMargin:1 starWidth:10];
        
        self.pointLabel.frame = CGRectMake(self.starView.frame.origin.x + self.starView.frame.size.width , self.starView.frame.origin.y, 25, 20);
        
        if (selectedCount == 0) {
            self.unpointLabel.hidden = NO;
            
            self.pointLabel.hidden = YES;
            self.starView.hidden = YES;
            
        }
        else{
            
            self.unpointLabel.hidden = YES;
            self.pointLabel.hidden = NO;
            self.starView.hidden = NO;
            
        }
        
    }];
    
    
    [RACObserve(self, viewModel.directors) subscribeNext:^(NSString *x) {
        @strongify(self);
        if (x.length > 0) {
            
            if (![self.viewModel.type isEqualToString:@"GAME"]) {
                
                NSMutableAttributedString *Astr1 = [[NSMutableAttributedString alloc]initWithString:x];
                
                [Astr1 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration aaaaaaColor] range:NSMakeRange(0, x.length)];
                [Astr1 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration blackColor] range:NSMakeRange(0, 3)];
                self.directorLabel.attributedText = Astr1;
            }
            else{
                
                self.directorLabel.text = x;
            }
            
        }
       
    }];
    
    
    [RACObserve(self, viewModel.actors) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        if (x.length > 0) {
            if (![self.viewModel.type isEqualToString:@"GAME"]) {
                NSMutableAttributedString *Astr2 = [[NSMutableAttributedString alloc]initWithString:x];
                [Astr2 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration aaaaaaColor] range:NSMakeRange(0, x.length)];
                [Astr2 addAttribute:NSForegroundColorAttributeName value:[JKStyleConfiguration blackColor] range:NSMakeRange(0, 3)];
                self.actorLabel.attributedText = Astr2;
            }
            else{
                
                self.actorLabel.text = x;
            }
        }
        
    }];
    
    
    [RACObserve(self, viewModel.img) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:[UIImage imageNamed:@""]];
        
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

- (void)loadDataWithVM:(JKMylookPlayCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKMylookPlayCellVM *)viewModel{
    _viewModel = viewModel;
    
}

- (void)clickCell{
    
    
    
    
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

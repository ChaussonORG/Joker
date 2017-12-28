//
//  JKWorkDirectorListCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/8.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkDirectorListCell.h"

@implementation JKWorkDirectorListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
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
    
    
    self.icon = [[UIImageView alloc]init];
    self.icon.layer.cornerRadius = 60/2;
    self.icon.layer.masksToBounds = YES;
    self.icon.contentMode =  UIViewContentModeScaleAspectFill;
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [JKStyleConfiguration overstrikingFont];
    self.nameLabel.textColor = [JKStyleConfiguration sixsixColor];
    
    self.actLabel = [[UILabel alloc]init];
    self.actLabel.font = [JKStyleConfiguration titleFont];
    self.actLabel.textColor = [JKStyleConfiguration bbbbbbColor];
    
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.actLabel];
    [self.contentView addSubview:self.icon];
    
}


- (void)prepareForLayout{
    
    self.icon.frame = CGRectMake(15, 20, 60, 60);
    
    self.nameLabel.frame = CGRectMake(self.icon.frame.origin.x + self.icon.frame.size.width + 15, 25, 200, 25);
    
    self.actLabel.frame = CGRectMake(self.icon.frame.origin.x + self.icon.frame.size.width + 15, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5, 200, 20);
    
    
}

- (void)binding{
    
    RAC(self, nameLabel.text) = RACObserve(self, viewModel.name);
    
    @weakify(self);
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.actName),
                                RACObserve(self, viewModel.degree)]] subscribeNext:^(id x) {
        @strongify(self);
        
        if (self.viewModel.actName.length > 0) {
            
            
            self.actLabel.text = [NSString stringWithFormat:@" %@",self.viewModel.actName];
        }
        else{
            
            
            self.actLabel.text =  self.viewModel.degree;
        }
        
        
        
    }];

    
    [RACObserve(self, viewModel.img) subscribeNext:^(NSString *x) {
       @strongify(self);
        
        [self.icon sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        
    }];
   
}

- (void)loadDataWithVM:(JKWorkDirectorListCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKWorkDirectorListCellVM *)viewModel{
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

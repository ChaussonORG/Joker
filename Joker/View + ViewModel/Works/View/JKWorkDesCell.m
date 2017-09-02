//
//  JKWorkDesCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkDesCell.h"

@implementation JKWorkDesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
        [self setUpSubViews];
        
      
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
       
    }
    
    
    
    return self ;
}

- (void)setUpSubViews{
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    [self.contentView addSubview:titleView];
    titleView.frame = CGRectMake(0, 0, ScreenWidth, 36);
    
    
    self.mainTitleLabel = [[UILabel alloc]init];
    self.mainTitleLabel.frame = CGRectMake(20, 0, ScreenWidth - 40, 36);
    self.mainTitleLabel.font = [JKStyleConfiguration subcontentFont];
    self.mainTitleLabel.textColor = [JKStyleConfiguration drakGrayTextColor];
    [titleView addSubview:self.mainTitleLabel];
    
    
    self.descLabel = [[UILabel alloc]init];
    self.descLabel.font = [JKStyleConfiguration titleFont];
    self.descLabel.textColor = [JKStyleConfiguration blackColor];
    self.descLabel.numberOfLines = 0;
    [self.contentView addSubview:self.descLabel];

    
}


- (void)LoadUIWithTitle:(NSString *)title desc:(NSString *)desc descLabelHeight:(CGFloat)descLabelHeight{
    
    self.mainTitleLabel.text = title;
    
    self.descLabel.text = desc;
    
    self.descLabel.frame = CGRectMake(20, 36+20, ScreenWidth - 40, descLabelHeight + 1);
    
    
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

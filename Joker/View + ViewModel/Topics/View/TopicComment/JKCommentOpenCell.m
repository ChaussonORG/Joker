
//
//  JKCommentOpenCell.m
//  JKCommentTableView
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommentOpenCell.h"
#import "JKStyleConfiguration.h"
@implementation JKCommentOpenCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration grayBackgroundColor];
        
        [self setUpSubViews];
    
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCommentOpenCell)];
        
        [self addGestureRecognizer:tap];
        
        
        
    }
    
    
    
    return self ;
}

- (void)setUpSubViews{
    
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [JKStyleConfiguration titleFont];
    self.contentLabel.textColor = [JKStyleConfiguration blueKeywordColor];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = @"展开隐藏评论";
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, 40);
    [self.contentView addSubview:self.contentLabel];
    
    
}

- (void)clickCommentOpenCell{
    
    [self.delegate openCommentList];
    
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

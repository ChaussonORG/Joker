//
//  JKTopicSpareCommentCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicSpareCommentCell.h"

@implementation JKTopicSpareCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
        [self setUpSubViews];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpSubViews{
    
    
//    UIView *lineView 
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.text = @"暂无回复";
    self.contentLabel.textColor = [JKStyleConfiguration ccccccColor];
    self.contentLabel.font = [JKStyleConfiguration titleFont];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.frame = CGRectMake(0, 30, ScreenWidth, 20);
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    
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

//
//  JKWorkImageListCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkImageListCell.h"

@implementation JKWorkImageListCell
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
    
    
 
    self.contentImageView = [[PhotoCotentView alloc]init];
    [self.contentView addSubview:self.contentImageView];
    
    
}


- (void)LoadUIWithTitle:(NSString *)title images:(NSArray *)images descLabelHeight:(CGFloat)imagesCollectionViewHeight{
    
    self.mainTitleLabel.text = title;
    
    self.contentImageView.frame = CGRectMake(0, 36, ScreenWidth, imagesCollectionViewHeight);
    
    self.contentImageView.images = images;
    
    
    @weakify(self)
    _contentImageView.ClickImageBlock = ^(NSUInteger index){
        @strongify(self)
    
        //展示网络图片
        [self.delegate networkImageShow:index];
    };
    
    
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

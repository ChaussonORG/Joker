//
//  JKDirectorslistCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKDirectorslistCell.h"

@implementation JKDirectorslistCell
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

}


- (void)loadUIWithTitle:(NSString *)title directors:(NSArray <JKFilmStaffCellVM*>*)directors{
    
    self.mainTitleLabel.text = title;
    
    
    
    CGFloat cellW = 70;
    CGFloat cellH = 100;
    
    //    间隙
    CGFloat margin =(ScreenWidth - 4 * cellW) / (4 + 1);
    
 
    for (int index = 0; index < directors.count; index ++) {
        
        JKFilmStaffCellVM *cellVM = directors[index];
        
        if (directors.count > 8) {
            
            if (index < 7) {
                UIView *cellView = [[UIView alloc ]init ];
                // 计算行号  和   列号
                int row = index / 4;
                int col = index % 4;
                //根据行号和列号来确定 子控件的坐标
                CGFloat cellX = margin + col * (cellW + margin);
                CGFloat cellY = row * (cellH + 10);
                cellView.frame = CGRectMake(cellX, 46 +cellY, cellW, cellH);
                
                UIImageView *iconView = [[UIImageView alloc]init];
                [iconView sd_setImageWithURL:[NSURL URLWithString:cellVM.img] placeholderImage:[UIImage imageNamed:@"touxiang"]];
                iconView.frame = CGRectMake(5, 0, 60, 60);
                iconView.layer.masksToBounds = YES;
                iconView.layer.cornerRadius = 30;
                iconView.contentMode =  UIViewContentModeScaleAspectFill;
                [cellView addSubview:iconView];
                
                UILabel *nameLabel = [[UILabel alloc]init];
                nameLabel.font = [JKStyleConfiguration contentFont];
                nameLabel.textColor = [JKStyleConfiguration aaaaaaColor];
                nameLabel.text = cellVM.name;
                nameLabel.textAlignment = NSTextAlignmentCenter;
                nameLabel.frame = CGRectMake(0, iconView.frame.size.height + iconView.frame.origin.y + 5, cellW, 15);
                [cellView addSubview:nameLabel];
                
                UILabel *actLabel = [[UILabel alloc]init];
                actLabel.font = [JKStyleConfiguration minContentFont];
                actLabel.textColor = [JKStyleConfiguration aaaaaaColor];
                
                if (cellVM.actName.length > 0) {
                    actLabel.text = [NSString stringWithFormat:@"饰 %@",cellVM.actName];
                }
                else{
                    actLabel.text = cellVM.degree;
                }
                
                actLabel.frame = CGRectMake(0, nameLabel.frame.size.height + nameLabel.frame.origin.y, cellW, 10);
                actLabel.textAlignment = NSTextAlignmentCenter;
                [cellView addSubview:actLabel];
                
                
                // 添加到view 中
                [self.contentView addSubview:cellView];

            }
            else if(index == 7){
                UIView *cellView = [[UIView alloc ]init ];
                // 计算行号  和   列号
                int row = index / 4;
                int col = index % 4;
                //根据行号和列号来确定 子控件的坐标
                CGFloat cellX = margin + col * (cellW + margin);
                CGFloat cellY = row * (cellH + 10);
                cellView.frame = CGRectMake(cellX, 46 +cellY, cellW, cellH);
                
                UIImageView *iconView = [[UIImageView alloc]init];
                iconView.frame = CGRectMake(5, 0, 60, 60);
                iconView.layer.masksToBounds = YES;
                iconView.layer.cornerRadius = 30;
                iconView.layer.borderColor = [JKStyleConfiguration aaaaaaColor].CGColor;
                iconView.layer.borderWidth = 1;
                [cellView addSubview:iconView];
                iconView.contentMode =  UIViewContentModeScaleAspectFill;
                
                UILabel *countLabel = [[UILabel alloc]init];
                countLabel.font = [JKStyleConfiguration titleFont];
                countLabel.textColor = [JKStyleConfiguration aaaaaaColor];
                countLabel.text = [NSString stringWithFormat:@"%ld",directors.count];
                countLabel.textAlignment = NSTextAlignmentCenter;
                countLabel.frame = CGRectMake(0, 5, 60, 25);
                [iconView addSubview:countLabel];
                
                UIView *lineView= [[UIView alloc]init];
                lineView.backgroundColor = [JKStyleConfiguration aaaaaaColor];
                lineView.frame = CGRectMake(20, 30, 20, 1);
                [iconView addSubview:lineView];
                
                UILabel *allLabel = [[UILabel alloc]init];
                allLabel.font = [JKStyleConfiguration minContentFont];
                allLabel.textColor = [JKStyleConfiguration aaaaaaColor];
                allLabel.text = @"全部";
                allLabel.frame = CGRectMake(0, lineView.frame.size.height + lineView.frame.origin.y, 60, 25);
                allLabel.textAlignment = NSTextAlignmentCenter;
                [iconView addSubview:allLabel];
                
                iconView.userInteractionEnabled = YES;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAllBtn)];
                [iconView addGestureRecognizer:tap];
                
                
                // 添加到view 中
                [self.contentView addSubview:cellView];

            }
            
            
        }
        else if (directors.count == 8) {
            UIView *cellView = [[UIView alloc ]init ];
            // 计算行号  和   列号
            int row = index / 4;
            int col = index % 4;
            //根据行号和列号来确定 子控件的坐标
            CGFloat cellX = margin + col * (cellW + margin);
            CGFloat cellY = row * (cellH + 10);
            cellView.frame = CGRectMake(cellX, 46 +cellY, cellW, cellH);
            
            UIImageView *iconView = [[UIImageView alloc]init];
            [iconView sd_setImageWithURL:[NSURL URLWithString:cellVM.img] placeholderImage:[UIImage imageNamed:@""]];
            iconView.frame = CGRectMake(5, 0, 60, 60);
            iconView.layer.masksToBounds = YES;
            iconView.layer.cornerRadius = 30;
            [cellView addSubview:iconView];
            iconView.contentMode =  UIViewContentModeScaleAspectFill;
            
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.font = [JKStyleConfiguration contentFont];
            nameLabel.textColor = [JKStyleConfiguration aaaaaaColor];
            nameLabel.text = cellVM.name;
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.frame = CGRectMake(0, iconView.frame.size.height + iconView.frame.origin.y + 5, cellW, 15);
            [cellView addSubview:nameLabel];
            
            UILabel *actLabel = [[UILabel alloc]init];
            actLabel.font = [JKStyleConfiguration minContentFont];
            actLabel.textColor = [JKStyleConfiguration aaaaaaColor];
            if (cellVM.actName.length > 0) {
                actLabel.text = [NSString stringWithFormat:@"饰 %@",cellVM.actName];
            }
            else{
                actLabel.text = cellVM.degree;
            }
            actLabel.frame = CGRectMake(0, nameLabel.frame.size.height + nameLabel.frame.origin.y, cellW, 10);
            actLabel.textAlignment = NSTextAlignmentCenter;
            [cellView addSubview:actLabel];
            
            
            // 添加到view 中
            [self.contentView addSubview:cellView];
        }
        else{
            
            UIView *cellView = [[UIView alloc ]init ];
            // 计算行号  和   列号
            int row = index / 4;
            int col = index % 4;
            //根据行号和列号来确定 子控件的坐标
            CGFloat cellX = margin + col * (cellW + margin);
            CGFloat cellY = row * (cellH + 10);
            cellView.frame = CGRectMake(cellX, 46 +cellY, cellW, cellH);
            
            UIImageView *iconView = [[UIImageView alloc]init];
            [iconView sd_setImageWithURL:[NSURL URLWithString:cellVM.img] placeholderImage:[UIImage imageNamed:@""]];
            iconView.frame = CGRectMake(5, 0, 60, 60);
            iconView.layer.masksToBounds = YES;
            iconView.layer.cornerRadius = 30;
            [cellView addSubview:iconView];
            iconView.contentMode =  UIViewContentModeScaleAspectFill;
            
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.font = [JKStyleConfiguration contentFont];
            nameLabel.textColor = [JKStyleConfiguration aaaaaaColor];
            nameLabel.text = cellVM.name;
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.frame = CGRectMake(0, iconView.frame.size.height + iconView.frame.origin.y + 5, cellW, 15);
            [cellView addSubview:nameLabel];
            
            UILabel *actLabel = [[UILabel alloc]init];
            actLabel.font = [JKStyleConfiguration minContentFont];
            actLabel.textColor = [JKStyleConfiguration aaaaaaColor];
            if (cellVM.actName.length > 0) {
                actLabel.text = [NSString stringWithFormat:@"饰 %@",cellVM.actName];
            }
            else{
                actLabel.text = cellVM.degree;
            }
            actLabel.frame = CGRectMake(0, nameLabel.frame.size.height + nameLabel.frame.origin.y, cellW, 10);
            actLabel.textAlignment = NSTextAlignmentCenter;
            [cellView addSubview:actLabel];
            
            
            // 添加到view 中
            [self.contentView addSubview:cellView];
        }
        
    }
    
    
}

- (void)clickAllBtn{
    
    
    
    
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

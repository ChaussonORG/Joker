//
//  JKTopicFilterView.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicFilterView.h"

@implementation JKTopicFilterView


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
        [self setupSubviews];
        

        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
         

    }
    
    
    
    return self ;
}

- (void)setupSubviews{
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [JKStyleConfiguration lineColor];
    line.frame = CGRectMake(0, 0, ScreenWidth, 1);
    [self.contentView addSubview:line];
    
    
    self.mainTitleLabel = [[UILabel alloc]init];
    self.mainTitleLabel.frame = CGRectMake(0, 0, ScreenWidth, 40);
    self.mainTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.mainTitleLabel.font = [JKStyleConfiguration contentFont];
    self.mainTitleLabel.textColor = [JKStyleConfiguration bbbbbbColor];
    [self addSubview:self.mainTitleLabel];
    
    
    CGFloat viewWidth = ScreenWidth/_dataSource.count;
    
    for (int i = 0;  i <_dataSource.count ;i ++) {
        
        UIView * btn = [[UIView alloc]init];
        btn.tag = [[NSString stringWithFormat:@"%d%d",JKFilterSerialNum,i] integerValue];
        btn.userInteractionEnabled = YES;
        btn.frame = CGRectMake(i*viewWidth, self.mainTitleLabel.frame.origin.y + self.mainTitleLabel.frame.size.height, viewWidth,  120 - (self.mainTitleLabel.frame.origin.y + self.mainTitleLabel.frame.size.height) - 10);
        [self addSubview:btn];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        
        imageView.frame = CGRectMake((viewWidth - JKFilterImageWidth)/2, 0, JKFilterImageWidth, JKFilterImageWidth);
        if (_imageSource) {
            imageView.image = [UIImage imageNamed:_imageSource[i]];
        }
        else{
            
            imageView.backgroundColor = [JKStyleConfiguration grayBackgroundColor];
        }
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.layer.cornerRadius = JKFilterImageWidth/2;
        imageView.layer.masksToBounds = YES;
        [btn addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [JKStyleConfiguration subcontentFont];
        label.textColor = [JKStyleConfiguration blackColor];
        label.text = _dataSource[i];
        label.frame = CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height + 5, viewWidth, 20);
        [btn addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBtn:)];
        [btn addGestureRecognizer:tap];
        
        
        
    }
  
}

- (void)clickBtn:(UITapGestureRecognizer *)tap{
    
    NSString *tag = [NSString stringWithFormat:@"%ld",(long)tap.view.tag];
    
    NSString *serialNum = [NSString stringWithFormat:@"%d",JKFilterSerialNum];
    
    NSInteger index = [[tag substringFromIndex:serialNum.length] integerValue];
    
    [self.delegate filterTopicWithIndex:index];
    
}


- (void)fetchData:(NSArray *)dataSource{
    
    _dataSource = dataSource;
    
    [self setupSubviews];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

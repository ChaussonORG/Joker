//
//  JKTopicListHeaderView.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/4.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicListHeaderView.h"


@interface JKTopicListHeaderView()

 
@property (nonatomic , strong) UIColor *selectedColor;

@property (nonatomic , strong) UIView *speratorBottomLine;
@end
@implementation JKTopicListHeaderView
- (instancetype)initWithFilterTitles:(NSArray *)filterTitleArr selectedColor:(UIColor *)color isLine:(BOOL)isLine
{
    if (self = [super init]) {
    
        self.selectedIndex = 0;
        
        _filterTilteArr = filterTitleArr;
        _selectedColor = color;
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
        self.isSeperator = isLine;
        
        [self  setupUI];
        [self binding];
        
    }
    return self;
    
}



- (void)setupUI{
     
    self.bottomLine = [[UIView alloc]init];
    self.bottomLine.backgroundColor = [JKStyleConfiguration blackColor];
    [self addSubview:self.bottomLine];
    CGFloat viewWidth = ScreenWidth/_filterTilteArr.count;
    for (int i = 0; i <_filterTilteArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_filterTilteArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [JKStyleConfiguration subcontentFont];
        [btn setTitleColor:[JKStyleConfiguration bbbbbbColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:_selectedColor forState:UIControlStateSelected];
        btn.tag = [[NSString stringWithFormat:@"%d%d",JKFilterTitleNum,i] integerValue];
        btn.frame = CGRectMake(i*viewWidth, 0, viewWidth,  40);
        
        [btn addTarget:self action:@selector(clickFilterBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if (self.isSeperator) {
            if (i != _filterTilteArr.count - 1) {
                
                UIView *line = [[UIView alloc]init];
                line.backgroundColor = [JKStyleConfiguration lineColor];
                line.frame = CGRectMake(btn.frame.origin.x + btn.frame.size.width, btn.frame.origin.y + 10, 1, 20);
                [self addSubview:line];
                
            }
            

        }
        if (i == self.selectedIndex) {
            
            btn.selected = YES;
            
            self.bottomLine.frame = CGRectMake((btn.frame.size.width - 20)/2, btn.frame.size.height + btn.frame.origin.y, 20, 2);
            
        }
    }
    
    
    self.speratorBottomLine = [[UIView alloc]init];
    self.speratorBottomLine.backgroundColor = [JKStyleConfiguration ddddddColor];
    self.speratorBottomLine.frame = CGRectMake(0, 40, ScreenWidth, 0.5);
    [self addSubview:self.speratorBottomLine];
}


- (void)clickFilterBtn:(UIButton *)sender{
    
    
    NSString *tag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    NSString *filterTitleNum = [NSString stringWithFormat:@"%d",JKFilterTitleNum];
    
    NSInteger index = [[tag substringFromIndex:filterTitleNum.length] integerValue];
    
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
           UIButton * btn = (UIButton *)view;
            if (btn.tag == sender.tag) {
                btn.selected = YES;
                
                CGRect lineRect = _bottomLine.frame;
                lineRect.origin.x = btn.frame.origin.x + (btn.frame.size.width- 20)/2;
                [UIView animateWithDuration:0.15f animations:^{
                    _bottomLine.frame = lineRect;
                }];
            }
            else{
                
                btn.selected = NO;
            }

        }

        
        
    }
    
    
    [self.delegate chooseTopicWithIndex:index];
    
    
}

- (void)changeSelectedUIWithIndex:(NSInteger)index{
    
    NSInteger tag =  10 * JKFilterTitleNum+ index;
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton * btn = (UIButton *)view;
            if (btn.tag == tag) {
                btn.selected = YES;
                
                CGRect lineRect = _bottomLine.frame;
                lineRect.origin.x = btn.frame.origin.x + (btn.frame.size.width- 20)/2;
                [UIView animateWithDuration:0.15f animations:^{
                    _bottomLine.frame = lineRect;
                }];
            }
            else{
                
                btn.selected = NO;
            }
            
        }
        
        
        
    }
    
    
    
    
}
- (void)binding{
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

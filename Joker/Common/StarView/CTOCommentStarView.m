//
//  TOYCommentStarView.m
//  ToyMan
//
//  Created by 朱彦君 on 16/8/15.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CTOCommentStarView.h"

@interface CTOCommentStarView ()

@property (nonatomic , assign) CGFloat selectedCounts;

@property (nonatomic , assign) BOOL isCommentable;

@property (nonatomic , assign) float starWidth;

@property (nonatomic , assign) float starMargin;
@end


@implementation CTOCommentStarView

- (instancetype)initWithFrame:(CGRect)frame SelectedCount:(CGFloat)selectedCount commentable:(BOOL)isCommentable starMargin:(CGFloat)starMargin starWidth:(CGFloat)starWidth;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _selectedCounts = selectedCount;
        
        self.starWidth = starWidth;
        
        self.starMargin = starMargin;
        
        if (isCommentable) {
            self.userInteractionEnabled = YES;
        }
        else{
            self.userInteractionEnabled = NO;
        }
    
        [self setUpStar];
    }
    return self;
}

- (void)refreshFrame:(CGRect)frame SelectedCount:(CGFloat)selectedCount commentable:(BOOL)isCommentable starMargin:(CGFloat)starMargin starWidth:(CGFloat)starWidth{
    
    
    _selectedCounts = selectedCount;
    
    self.starWidth = starWidth;
    
    self.starMargin = starMargin;
    
    if (isCommentable) {
        self.userInteractionEnabled = YES;
    }
    else{
        self.userInteractionEnabled = NO;
    }
    
    [self setUpStar];
    
    
}

- (void)setUpStar{
    
    int selectedHoleStar = (int)_selectedCounts;
    
    BOOL isShowHalfStar;
    if (_selectedCounts - selectedHoleStar > 0) {
        
        isShowHalfStar = YES;
    }
    else{
        
        isShowHalfStar = NO;
        
    }
    
    
    for (int i = 1; i < 6; i ++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(self.starMargin * i + self.starWidth * (i - 1), (self.frame.size.height - self.starWidth)/2, self.starWidth, self.starWidth);
        [button setImage:[UIImage imageNamed:@"redStar"] forState:(UIControlStateNormal)];
        button.tag = i;
        button.showsTouchWhenHighlighted = NO;
        [button setImage:[UIImage imageNamed:@"redStar"] forState:(UIControlStateSelected)];
        [button setImage:[UIImage imageNamed:@"grayStar"] forState:(UIControlStateNormal)];
        if (i <= _selectedCounts) {
            
            button.selected = YES;
            
        }
    
        
        if (i - _selectedCounts == 0.5) {
            if (isShowHalfStar) {
                
                [button setImage:[UIImage imageNamed:@"ic_star_half"] forState:UIControlStateNormal];
                
            }
        }
        
        
        
        button.userInteractionEnabled = NO;
        [self addSubview:button];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    for (UIButton *button in self.subviews) {
        
        if (CGRectContainsPoint(button.frame, point)) {
            NSInteger i = button.tag;
            
            for (UIButton *button in self.subviews ) {
                if (button.tag < i || button.tag == i) {
                    button.selected = YES;
                }
                else{
                    button.selected = NO;
                }
            }
            
        }
    }
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    for (UIButton *button in self.subviews) {
        
        if (CGRectContainsPoint(button.frame, point)) {
            NSInteger i = button.tag;
            
            for (UIButton *button in self.subviews ) {
                if (button.tag < i || button.tag == i) {
                    button.selected = YES;
                }
                else{
                    button.selected = NO;
                }
            }
            
        }
    }
}



- (NSInteger)selectedCount{
    
    
    NSInteger redStar = 0;
    
    for (UIButton *button in self.subviews) {
        
        if (button.selected) {
            redStar ++;
        }
    }
    
    return redStar;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

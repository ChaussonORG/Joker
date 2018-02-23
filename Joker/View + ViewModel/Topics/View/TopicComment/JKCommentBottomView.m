//
//  JKCommentBottomView.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/7.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommentBottomView.h"

@implementation JKCommentBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    self.favourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.favourBtn setImage:[UIImage imageNamed:@"keguan"] forState:UIControlStateNormal]; 
    [self addSubview:self.favourBtn];
    self.favourBtn.frame = CGRectMake(20, 10, 60, 20);
    [self.favourBtn addTarget:self action:@selector(clickFavourBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.favourBtn setTitleColor:[JKStyleConfiguration grayTextColor] forState:UIControlStateNormal];
     [self.favourBtn setTitleEdgeInsets:UIEdgeInsetsMake(- 2, 10, 0, 0)];
    self.favourBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    
    
    self.criticismBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.criticismBtn setImage:[UIImage imageNamed:@"bukeguan"] forState:UIControlStateNormal];
    [self addSubview:self.criticismBtn];
    self.criticismBtn.frame = CGRectMake(self.favourBtn.frame.size.width + self.favourBtn.frame.origin.x + 25, 10, 60, 20);
    [self.criticismBtn addTarget:self action:@selector(clickCriticismBtn) forControlEvents:UIControlEventTouchUpInside];
     [self.criticismBtn setTitleColor:[JKStyleConfiguration grayTextColor] forState:UIControlStateNormal];
    [self.criticismBtn setTitleEdgeInsets:UIEdgeInsetsMake(- 2, 10, 0, 0)];
    self.criticismBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    
    
    self.turnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.turnBtn setImage:[UIImage imageNamed:@"bianjix"] forState:UIControlStateNormal];
    [self addSubview:self.turnBtn];
    self.turnBtn.frame = CGRectMake(ScreenWidth - 20 - 20 - 30 - 20 - 30 - 20, 10, 20, 20);
    [self.turnBtn addTarget:self action:@selector(clickTurnBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setImage:[UIImage imageNamed:@"shanchux"] forState:UIControlStateNormal];
    [self addSubview:self.deleteBtn];
    self.deleteBtn.frame = CGRectMake(ScreenWidth - 20 - 20 - 30 - 20, 10, 20, 20);
    [self.deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    [self addSubview:self.commentBtn];
    self.commentBtn.frame = CGRectMake(ScreenWidth - 20 - 20, 10, 20, 20);
    [self.commentBtn addTarget:self action:@selector(clickCommentBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.jubaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.jubaoBtn setTitle:@"举报" forState:UIControlStateNormal];
    [self.jubaoBtn setTitleColor:[JKStyleConfiguration lightGrayTextColor] forState:UIControlStateNormal];
    self.jubaoBtn.titleLabel.font = [JKStyleConfiguration contentFont];
    [self addSubview:self.jubaoBtn];
    self.jubaoBtn.frame = CGRectMake(ScreenWidth - 20 - 20 - 5 - 40, 8, 40, 20);
    [self.jubaoBtn addTarget:self action:@selector(clickJubaoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)clickJubaoBtn{
    
    [CHProgressHUD showPlainText:@"收到您的反馈，我们尽快处理"];
}
- (void)clickFavourBtn{
    
    
    [self.delegate favourComment];
    
}

- (void)clickCriticismBtn{
    
    
    [self.delegate criticismComment];
}

- (void)clickTurnBtn{
    
    [self.delegate turnComment];
    
    
}

- (void)clickDeleteBtn{
    
    [self.delegate deleteComment];
    
}

- (void)clickCommentBtn{
    
    [self.delegate replyComment];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

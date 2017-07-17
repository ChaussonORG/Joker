//
//  JKTopicDetailBottomView.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicDetailBottomView.h"

@implementation JKTopicDetailBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupSubviews];
        
        [self binding];
        
    }
    return self;
}

- (void)loadDataWithVM:(JKTopicDetailBottomVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKTopicDetailBottomVM *)viewModel{
    _viewModel = viewModel;
    
}


- (void)setupSubviews{
    
    self.refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.refreshBtn.frame = CGRectMake(10, 10, 30, 25);
    [self.refreshBtn addTarget:self action:@selector(clickRefreshBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [self.refreshBtn setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.refreshBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self addSubview:self.refreshBtn];
    
    
    self.lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastBtn.frame = CGRectMake(self.refreshBtn.frame.origin.x + self.refreshBtn.frame.size.width + 20, 10, 30, 25);
    [self.lastBtn addTarget:self action:@selector(clickLastBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.lastBtn setTitle:@"上页" forState:UIControlStateNormal];
    [self.lastBtn setTitleColor:[JKStyleConfiguration blueBorderColor] forState:UIControlStateNormal];
    self.lastBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self addSubview:self.lastBtn];
    
    self.replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.replyBtn.frame = CGRectMake(ScreenWidth - 30 - 10, 10, 30, 25);
    [self.replyBtn addTarget:self action:@selector(clickReplyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.replyBtn setTitle:@"回复" forState:UIControlStateNormal];
    [self.replyBtn setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.replyBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self addSubview:self.replyBtn];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(ScreenWidth - 30 - 10 - 20 - 30, 10, 30, 25);
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn setTitle:@"下页" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[JKStyleConfiguration blueKeywordColor] forState:UIControlStateNormal];
    self.nextBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self addSubview:self.nextBtn];
    
    self.offsetLabel = [[UILabel alloc]init];
    self.offsetLabel.frame = CGRectMake((ScreenWidth - 100)/2, 10, 100, 25);
    self.offsetLabel.font = [JKStyleConfiguration subcontentFont];
    self.offsetLabel.textAlignment = NSTextAlignmentCenter;
    self.offsetLabel.textColor = [JKStyleConfiguration blueKeywordColor];
    [self addSubview:self.offsetLabel];
}

- (void)clickRefreshBtn{
    
    
    [self.viewModel refresh];
    
    
}

- (void)clickLastBtn{
    
    
    [self.viewModel up];
    
}

- (void)clickReplyBtn{
    
    
    [self.viewModel reply];
}

- (void)clickNextBtn{
    
    
    [self.viewModel down];
    
}

- (void)binding{
    
    @weakify(self);
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.pageCount),
                                RACObserve(self, viewModel.currentPage)]] subscribeNext:^(id x) {
        @strongify(self);
    
        NSInteger pageCount = [x[0] integerValue];
        NSInteger currentPage = [x[1] integerValue];
        self.offsetLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)currentPage,(long)pageCount];
        
        
        if (currentPage < pageCount) {
            [self.nextBtn setTitleColor:[JKStyleConfiguration blueKeywordColor] forState:UIControlStateNormal];
        }
        
    }];
    
    [RACObserve(self, viewModel.isDownable) subscribeNext:^(id x) {
        @strongify(self);
        
        BOOL isDownable = [x boolValue];
        
        if (isDownable) {
            
            [self.nextBtn setTitleColor:[JKStyleConfiguration blueKeywordColor] forState:UIControlStateNormal];
        }
        else{
            
            
            [self.nextBtn setTitleColor:[JKStyleConfiguration grayTextColor] forState:UIControlStateNormal];
        }
        
    }];
    
    
    [RACObserve(self, viewModel.isUpable) subscribeNext:^(id x) {
        @strongify(self);
        
        BOOL isUpable = [x boolValue];
        
        if (isUpable) {
            
            
            [self.lastBtn setTitleColor:[JKStyleConfiguration blueKeywordColor] forState:UIControlStateNormal];
        }
        else{
            
            
            [self.lastBtn setTitleColor:[JKStyleConfiguration grayTextColor] forState:UIControlStateNormal];
        }
        
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

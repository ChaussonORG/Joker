//
//  JKWorkCommentListCell.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkCommentListCell.h"
#import "JKStyleConfiguration.h"
#import "JKCommentOpenCell.h"
#import "JKSubcommentListCell.h"
#import "JKCommentBottomView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface JKWorkCommentListCell()<CommentListOpenDelegate,CommentStatusDelegate>

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) JKCommentBottomView *bottomView;

@end

@implementation JKWorkCommentListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [JKStyleConfiguration whiteColor];
        
        [self setUpSubViews];
        
        [self prepareForLayout];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTopicListCell)];
        //
        //        [self addGestureRecognizer:tap];
        
        
        [self binding];
    }
    
    
    
    return self ;
}

- (void)setUpSubViews{
    
    
    self.headerView = [[UIImageView alloc]init];
    self.headerView.layer.cornerRadius = 35/2;
    self.headerView.layer.masksToBounds = YES;
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [JKStyleConfiguration subcontentFont];
    self.nameLabel.textColor = [JKStyleConfiguration blackColor];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [JKStyleConfiguration contentFont];
    self.timeLabel.textColor = [JKStyleConfiguration grayTextColor];
    
    
    self.relatedLabel = [[UILabel alloc]init];
    self.relatedLabel.font = [JKStyleConfiguration subcontentFont];
    self.relatedLabel.textColor = [JKStyleConfiguration blackColor];
    self.relatedLabel.textAlignment =NSTextAlignmentRight;
    
    
    self.quoteView = [[UIView alloc]init];
    self.quoteView.backgroundColor = [JKStyleConfiguration grayBackgroundColor];
    
    self.quoteFloorLabel = [[UILabel alloc]init];
    self.quoteFloorLabel.font = [JKStyleConfiguration subcontentFont];
    self.quoteFloorLabel.textColor = [JKStyleConfiguration blackColor];
    
    self.quoteAutorLabel = [[UILabel alloc]init];
    self.quoteAutorLabel.font = [JKStyleConfiguration contentFont];
    self.quoteAutorLabel.textColor = [JKStyleConfiguration blackColor];
    
    self.quoteSendLabel = [[UILabel alloc]init];
    self.quoteSendLabel.font = [JKStyleConfiguration contentFont];
    self.quoteSendLabel.textColor = [JKStyleConfiguration blackColor];
    self.quoteSendLabel.text = @"发表的";
    
    self.quoteContentLabel = [[UILabel alloc]init];
    self.quoteContentLabel.font = [JKStyleConfiguration titleFont];
    self.quoteContentLabel.textColor = [JKStyleConfiguration blackColor];
    self.quoteContentLabel.numberOfLines = 0;
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [JKStyleConfiguration titleFont];
    self.contentLabel.textColor = [JKStyleConfiguration blackColor];
    self.contentLabel.numberOfLines = 0;
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [JKStyleConfiguration lineColor];
    
    self.starView = [[CTOCommentStarView alloc]init];
     
    self.pointLabel = [[UILabel alloc]init];
    self.pointLabel.font = [JKStyleConfiguration contentFont];
    self.pointLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    self.pointLabel.textAlignment = NSTextAlignmentCenter;
    
    self.bottomView = [[JKCommentBottomView alloc]init];
    self.bottomView.delegate = self;
    
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.pointLabel];
    [self.contentView addSubview:self.headerView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.relatedLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.bottomView];
    [self.contentView addSubview:self.quoteView];
    [self.quoteView addSubview:self.quoteFloorLabel];
    [self.quoteView addSubview:self.quoteAutorLabel];
    [self.quoteView addSubview:self.quoteSendLabel];
    [self.quoteView addSubview:self.quoteContentLabel];
    
    
}


- (void)prepareForLayout{
    
    self.headerView.frame = CGRectMake(25, 15, 35, 35);
    
    
}

- (void)binding{
    
    RAC(self, nameLabel.text) = RACObserve(self, viewModel.name);
    
    RAC(self, timeLabel.text) = RACObserve(self, viewModel.time);
    
    @weakify(self);
    [RACObserve(self, viewModel.floorCount) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        if ([x integerValue] > 0) {
            self.relatedLabel.text = [NSString stringWithFormat:@"%@楼",x];
        }
        
    }];
    
    RAC(self, contentLabel.text) = RACObserve(self, viewModel.content);
    
    RAC(self, quoteFloorLabel.text) = RACObserve(self, viewModel.quoteFloor);
    
    [RACObserve(self, viewModel.quoteAutor) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        if (x.length > 0) {
            self.quoteAutorLabel.text = x;
            
            self.quoteContentLabel.hidden = NO;
            self.quoteSendLabel.hidden = NO;
            self.quoteAutorLabel.hidden = NO;
            self.quoteFloorLabel.hidden = NO;
            self.quoteView.hidden = NO;
        }
        else{
            self.quoteContentLabel.hidden = YES;
            self.quoteSendLabel.hidden = YES;
            self.quoteAutorLabel.hidden = YES;
            self.quoteFloorLabel.hidden = YES;
            self.quoteView.hidden = YES;
        }
        
    }];
    
    [RACObserve(self, viewModel.commentStatus) subscribeNext:^(id x) {
        @strongify(self);
        
        if (self.viewModel.commentStatus == JKWorkCommentCai) {
            
            [self.bottomView.favourBtn setImage:[UIImage imageNamed:@"keguan"] forState:UIControlStateNormal];
            [self.bottomView.criticismBtn setImage:[UIImage imageNamed:@"cai"] forState:UIControlStateNormal];
        }
        else if (self.viewModel.commentStatus == JKWorkCommentZan) {
            
            [self.bottomView.favourBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
            [self.bottomView.criticismBtn setImage:[UIImage imageNamed:@"bukeguan"] forState:UIControlStateNormal];
        }
        else{
            
            [self.bottomView.favourBtn setImage:[UIImage imageNamed:@"keguan"] forState:UIControlStateNormal];
            [self.bottomView.criticismBtn setImage:[UIImage imageNamed:@"bukeguan"] forState:UIControlStateNormal];
        }
        
    }];
    
    RAC(self, quoteContentLabel.text) = RACObserve(self, viewModel.quoteContent);
    
    [RACObserve(self, viewModel.isMyComment) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        BOOL isMycomment = [x boolValue];
        
        if (isMycomment) {
            self.bottomView.turnBtn.hidden = NO;
            self.bottomView.deleteBtn.hidden = NO;
            
        }
        else{
            
            self.bottomView.turnBtn.hidden = YES;
            self.bottomView.deleteBtn.hidden = YES;
        }
        
    }];
    
    //
    //    [RACObserve(self, viewModel.commentStatus) subscribeNext:^(NSNumber *x) {
    //         @strongify(self);
    //
    //        if (self.viewModel.commentStatus == JKCommentZan) {
    //
    //
    //        }
    //        else if (self.viewModel.commentStatus == JKCommentCai) {
    //
    //
    //        }
    //        else{
    //
    //
    //        }
    //
    //    }];
    //
    
    [RACObserve(self, viewModel.score) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        self.pointLabel.text = x;
        
        CGFloat selectedCount = [self fetchSelectedCountWithScore:[x floatValue]];
        
        self.pointLabel.frame = CGRectMake(ScreenWidth - 20 - 30 , self.nameLabel.frame.origin.y, 30, 20);
        
        [self.starView refreshFrame: CGRectMake(self.pointLabel.frame.origin.x - 60, self.nameLabel.frame.origin.y, 60 , 20) SelectedCount:selectedCount commentable:NO starMargin:1 starWidth:10];
    }];
    
    
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.nameLabelWeight),
                                RACObserve(self, viewModel.contentLabelHeight),
                                RACObserve(self, viewModel.quoteFloorLabelWidth)
                                ,
                                RACObserve(self, viewModel.quoteAutorLabelWidth)
                                ,
                                RACObserve(self, viewModel.quoteContentLabelHeight),
                                RACObserve(self, viewModel.quoteViewHeight),
                                RACObserve(self, viewModel.cellHeight)]] subscribeNext:^(id x) {
        @strongify(self);
        
        CGFloat nameLabelWeight = [x[0] floatValue] + 1;
        CGFloat contentLabelHeight = [x[1] floatValue] + 1;
        CGFloat quoteFloorLabelWidth = [x[2] floatValue] + 1;
        CGFloat quoteAutorLabelWidth = [x[3] floatValue] + 1;
        CGFloat quoteContentLabelHeight = [x[4] floatValue] + 1;
        CGFloat quoteViewHeight = [x[5] floatValue] + 1;
        CGFloat cellHeight = [x[7] floatValue];
        
        if (nameLabelWeight > [UIScreen mainScreen].bounds.size.width/3*2) {
            
            nameLabelWeight = [UIScreen mainScreen].bounds.size.width/3*2;
        }
        
        self.nameLabel.frame = CGRectMake(self.headerView.frame.origin.x + self.headerView.frame.size.width + 10, self.headerView.frame.origin.y , nameLabelWeight, 18);
        
        self.timeLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height, 120, 17);
        
//        self.relatedLabel.frame = CGRectMake(self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + 10, self.nameLabel.frame.origin.y, [UIScreen mainScreen].bounds.size.width - (self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + 10) - 25 , 35);
        self.pointLabel.frame = CGRectMake(ScreenWidth - 20 - 30 , self.nameLabel.frame.origin.y, 30, 20);
        
        
        self.starView.frame = CGRectMake(self.pointLabel.frame.origin.x - 60, self.nameLabel.frame.origin.y, 60 , 20);
        
        
        
        self.quoteView.frame = CGRectMake(20, self.headerView.frame.origin.y + self.headerView.frame.size.height + 10, ScreenWidth - 40, quoteViewHeight);
        
        self.quoteFloorLabel.frame = CGRectMake(15, 10, quoteFloorLabelWidth, 20);
        
        self.quoteAutorLabel.frame = CGRectMake(self.quoteFloorLabel.frame.origin.x + self.quoteFloorLabel.frame.size.width, self.quoteFloorLabel.frame.origin.y, quoteAutorLabelWidth, 20);
        
        self.quoteSendLabel.frame = CGRectMake(self.quoteAutorLabel.frame.origin.x + self.quoteAutorLabel.frame.size.width , self.quoteAutorLabel.frame.origin.y, 40, 20);
        
        self.quoteContentLabel.frame = CGRectMake(15, self.quoteFloorLabel.frame.origin.y + self.quoteFloorLabel.frame.size.height, ScreenWidth - 30, quoteContentLabelHeight);
        
        self.contentLabel.frame = CGRectMake(self.quoteView.frame.origin.x, self.quoteView.frame.origin.y + self.quoteView.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 40 , contentLabelHeight);
        
        
        //        self.subTableView.frame = CGRectMake(20, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 40, tempSubTableViewHeight);
        
        self.bottomView.frame = CGRectMake(0, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 10 , ScreenWidth, 45);
        
        self.lineView.frame = CGRectMake(0, cellHeight - 1, ScreenWidth, 1);
        
    }];
    
    
    
    [RACObserve(self, viewModel.headerUrl) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:[UIImage imageNamed:@""]];
        
    }];
    
    
    
    [RACObserve(self, viewModel.disgustCount) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        [self.bottomView.criticismBtn setTitle:x forState:UIControlStateNormal];
        
    }];
    
    [RACObserve(self, viewModel.likeCount) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        [self.bottomView.favourBtn setTitle:x forState:UIControlStateNormal];
        
    }];
}

- (void)loadDataWithVM:(JKWorkCommentListCellVM *)viewModel{
    
    [self setViewModel:viewModel];
    
}
- (void)setViewModel:(JKWorkCommentListCellVM *)viewModel{
    _viewModel = viewModel;
    
}

 - (void)favourComment{
    
    if (self.viewModel.commentStatus == JKWorkCommentCai) {
        
        [self.viewModel criticismAfterZan];
    }
    else{
        [self.viewModel  favouriteComment];
        
    }
    
}

- (void)criticismComment{
    
    if (self.viewModel.commentStatus == JKWorkCommentZan) {
        
        [self.viewModel  favouriteAfterCai];
        
    }
    else{
        
        [self.viewModel criticismComment];
    }
    
}

- (void)turnComment{
    
    [self.viewModel turnComment];
}

- (void)deleteComment{
    
    [self.viewModel deleteComment];
    
}

- (void)replyComment{
    
    [self.viewModel replyComment];
}

- (CGFloat)fetchSelectedCountWithScore:(CGFloat)score{
    
    CGFloat selectedCount = 0.0;
    
    if (score < 1) {
        
        selectedCount = 0;
    }
    else if (score >= 1 && score < 2) {
        
        selectedCount = 0.5;
    }
    else if (score >= 2 && score < 3) {
        
        selectedCount = 1;
    }
    else if (score >= 3 && score < 4) {
        
        selectedCount = 1.5;
    }
    else if (score >= 4 && score < 5) {
        
        selectedCount = 2;
    }
    else if (score >= 5 && score < 6) {
        
        selectedCount = 2.5;
    }
    else if (score >= 6 && score < 7) {
        
        selectedCount = 3;
    }
    else if (score >= 7 && score < 8) {
        
        selectedCount = 3.5;
    }
    else if (score >= 8 && score < 9) {
        
        selectedCount = 4;
    }
    else if (score >= 9 && score < 10) {
        
        selectedCount = 4.5;
    }
    else if (score == 10.0) {
        
        selectedCount = 5;
    }
    
    
    return selectedCount;
    
    
}


@end

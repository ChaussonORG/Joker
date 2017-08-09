//
//  JKTopicDetailVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicDetailVM.h"
#import "CHCommonMacro.h"
#import "JKTopicDetailApi.h"
#import "HHTGetString.h"
#import "JKTopicDetailCommentListApi.h"
#import "JKTopicDetailTopcomentApi.h"
#import "JKUserManager.h"
#import "CHLoginModalController.h"
#import "CHNetworkConfig.h"
#import "JKCommentCreatController.h"
@interface JKTopicDetailVM()<TopicDetailBottomDelegate,CHLoginModalControllerDelegate>

@property (nonatomic , assign) NSInteger offset;

@property (nonatomic , strong) NSString *detailHtmlStr;

@property (nonatomic , strong) NSString *title;

@end

@implementation JKTopicDetailVM
- (instancetype)initWithTopicId:(NSString *)topicId
{
    self = [super init];
    if (self) {
        
        _topicId = topicId;
        
        self.bottomVM = [[JKTopicDetailBottomVM alloc]init];
        
        self.bottomVM.delegate = self;
        
        self.cellVMs = [NSMutableArray array];
        
        self.topCellVMs = [NSMutableArray array];
        
        self.bottemCellVMs = [NSMutableArray array];
        
        self.offset = 0;
        
        
        
    }
    return self;
}


- (void)requestData{
    
    
    JKTopicDetailApi *api = [[JKTopicDetailApi alloc]initWithTopicId:self.topicId];
    
    [api startWithSuccessBlock:^(__kindof JKTopicDetailApi *request) {
        
        self.bottomVM.pageCount = ceil([request.model.data.commentCount doubleValue]/PAGELIMIT) == 0?1: ceil([request.model.data.commentCount doubleValue]/PAGELIMIT) ;
        self.detailHtmlStr = request.model.data.url;
        
        self.title = request.model.data.title;

        
    } failureBlock:^(__kindof JKTopicDetailApi *request) {
        
        
        
    }];
    
    
    [self requestComment];
   
}

- (void)requestComment{
    
    JKTopicDetailTopcomentApi *topApi = [[JKTopicDetailTopcomentApi alloc]initWithTopicId:self.topicId];
    topApi.commentType = @"true";
    
    topApi.requestModel.limit = PAGELIMIT;
    
    topApi.requestModel.offset = 0;
    
    [topApi startWithSuccessBlock:^(__kindof JKTopicDetailTopcomentApi *request) {
    
        NSMutableArray <JKCommentListCellVM *>*topCellViewModels = [NSMutableArray array];
    
        for (JKTopicDetailCommentListModelTopicReplayPojoList *list in request.model.data) {
            
            [topCellViewModels addObject:[self assembleViewModelWithList:list withIndex:0]];
            
        }
        self.topCellVMs = [topCellViewModels copy];
        
        
    } failureBlock:^(__kindof JKTopicDetailTopcomentApi *request) {
        
        
        
    }];
    
    
    JKTopicDetailTopcomentApi *bottomApi = [[JKTopicDetailTopcomentApi alloc]initWithTopicId:self.topicId];
    
    bottomApi.commentType = @"flase";
    
    bottomApi.requestModel.limit = PAGELIMIT;
    
    bottomApi.requestModel.offset = 0;
    
    [bottomApi startWithSuccessBlock:^(__kindof JKTopicDetailTopcomentApi *request) {
     
        NSMutableArray <JKCommentListCellVM *>*bottomCellViewModels = [NSMutableArray array];
        for (JKTopicDetailCommentListModelTopicReplayPojoList *list in request.model.data) {
            
            [bottomCellViewModels addObject:[self assembleViewModelWithList:list withIndex:0]];
            
        }
        self.bottemCellVMs = [bottomCellViewModels copy];
        
    } failureBlock:^(__kindof JKTopicDetailTopcomentApi *request) {
        
        
        
    }];
    
    JKTopicDetailCommentListApi *api = [[JKTopicDetailCommentListApi alloc]initWithTopicId:self.topicId];
    
    api.requestModel.limit = PAGELIMIT;
    
    api.requestModel.offset = self.offset;
    
    [api startWithSuccessBlock:^(__kindof JKTopicDetailCommentListApi *request) {
        NSMutableArray <JKCommentListCellVM *>*cellViewModels = [NSMutableArray array];
        
        NSMutableArray <JKCommentListCellVM *>*topCellViewModels = [NSMutableArray array];
        
        NSMutableArray <JKCommentListCellVM *>*bottomCellViewModels = [NSMutableArray array];
        
        
        for (int i = 0 ; i < request.model.items.count ; i ++) {
            
            JKTopicDetailCommentListModelTopicReplayPojoList *list  = request.model.items[i];
            
            [cellViewModels addObject:[self assembleViewModelWithList:list withIndex:request.model.items.count - i]];
        }
    
        self.cellVMs = [cellViewModels copy];
        
        
    } failureBlock:^(__kindof JKTopicDetailCommentListApi *request) {
        
        
        
    }];
    
}

- (JKCommentListCellVM *)assembleViewModelWithList:(JKTopicDetailCommentListModelTopicReplayPojoList                                                               *)list withIndex:(NSInteger)index{
    
    JKCommentListCellVM *cellVM = [[JKCommentListCellVM alloc]init];
    
    cellVM.name = list.author.nickname;
    
    cellVM.headerUrl = list.author.icon;
    
    cellVM.likeCount = list.likeCount;
    
    cellVM.disgustCount = list.disgustCount;
    
    CGSize nameLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.name, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.nameLabelWeight = nameLabelSize.width;
    
    cellVM.time =  [HHTGetString timeStrwithTimestamp:list.createTime];
      
//    cellVM.quoteFloor = [NSString stringWithFormat:@"引用%@楼 @",list.replyInfo.replyCommentFloor];
    
    
    cellVM.quoteAutor = list.replyInfo.author.nickname;
    
    CGSize quoteAutorLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.quoteAutor, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.quoteAutorLabelWidth = quoteAutorLabelSize.width;
    
    cellVM.quoteContent = list.replyInfo.content;
    
    CGSize quoteContentLabelSize = CH_TRANSFORM_TEXTSIZE(cellVM.quoteContent, [JKStyleConfiguration titleFont], CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, MAXFLOAT));
    
    cellVM.quoteContentLabelHeight = quoteContentLabelSize.height;
    
    if (cellVM.quoteContent) {
        cellVM.quoteViewHeight = cellVM.quoteContentLabelHeight + 40 + 10;
        
        cellVM.quoteFloor = @"引用@";
        
        CGSize quoteFloorLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.quoteFloor, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
        
        cellVM.quoteFloorLabelWidth = quoteFloorLabelSize.width;
    }
    else{
        
        cellVM.quoteViewHeight = cellVM.quoteContentLabelHeight;
    }
    
    
    if (index == 0) {
        
        
        
    }else{
        
        cellVM.floorCount = [NSString stringWithFormat:@"%ld层",index];
    }
    
    cellVM.content = list.content;
    
    CGSize size = CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT));
    
    cellVM.contentLabelHeight = size.height;
    
    cellVM.cellHeight = 75 + cellVM.contentLabelHeight + cellVM.quoteViewHeight + 45;
    
    return cellVM;
  
    
}

- (void)refresh{
    
    self.offset = 0;
    
    [self requestData];
    
    [self.delegate scrollsToTop];
}

- (void)upWithOffset:(NSInteger)offset{
    
    self.offset = offset;
    
}

- (void)downWithOffset:(NSInteger)offset{
    
    self.offset = offset;
    
}

- (void)reply{
    
    
    if ([[JKUserManager sharedData] isUserEffective]) {
        
        JKCommentCreatController *vc = [[JKCommentCreatController alloc]init];
        vc.viewModel.titleStr = [NSString stringWithFormat:@"回复：%@",self.title];
        vc.viewModel.topicId = self.topicId;
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    else{
        
        [self login];
    }
    
}

- (void)login
{
    CHLoginModalController *vc = [[CHLoginModalController alloc] init];
    vc.delegate = self;
    [[ASNavigator shareModalCenter].fetchCurrentViewController presentViewController:vc animated:YES completion:nil];
}
- (void)ch_willCompletionWithSuccess:(NSDictionary *)info
{
    [[JKUserManager sharedData] saveUserWithInfo:info];
    
    
}



@end

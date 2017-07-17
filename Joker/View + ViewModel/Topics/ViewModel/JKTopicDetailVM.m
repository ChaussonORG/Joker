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

@interface JKTopicDetailVM()<TopicDetailBottomDelegate>

@property (nonatomic , assign) NSInteger offset;

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
        
        self.bottomVM.pageCount = ceil([request.model.data.commentCount doubleValue]/PAGELIMIT)  ;
        
    } failureBlock:^(__kindof JKTopicDetailApi *request) {
        
        
        
    }];
    
    
    [self requestComment];
   
}

- (void)requestComment{
    
    JKTopicDetailCommentListApi *api = [[JKTopicDetailCommentListApi alloc]initWithTopicId:self.topicId];
    
    api.requestModel.limit = PAGELIMIT;
    
    api.requestModel.offset = self.offset;
    
    [api startWithSuccessBlock:^(__kindof JKTopicDetailCommentListApi *request) {
        NSMutableArray <JKCommentListCellVM *>*cellViewModels = [NSMutableArray array];
        
        NSMutableArray <JKCommentListCellVM *>*topCellViewModels = [NSMutableArray array];
        
        NSMutableArray <JKCommentListCellVM *>*bottomCellViewModels = [NSMutableArray array];
        for (JKTopicDetailCommentListModelTopicReplayPojoList *list in request.model.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithList:list]];
            
        }
        self.cellVMs = [cellViewModels copy];
        
        
    } failureBlock:^(__kindof JKTopicDetailCommentListApi *request) {
        
        
        
    }];
    
}

- (JKCommentListCellVM *)assembleViewModelWithList:(JKTopicDetailCommentListModelTopicReplayPojoList                                                               *)list{
    
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
    
    
//    cellVM.floorCount = [NSString stringWithFormat:@"%d层",list.commentFloor];
    
    cellVM.content = list.content;
    
    CGSize size = CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT));
    
    cellVM.contentLabelHeight = size.height;
    
    cellVM.cellHeight = 75 + cellVM.contentLabelHeight + cellVM.quoteViewHeight + 45;
    
    return cellVM;
  
    
}

- (void)refresh{
    
    self.offset = 0;
    
    [self requestData];
}

- (void)upWithOffset:(NSInteger)offset{
    
    self.offset = offset;
    
}

- (void)downWithOffset:(NSInteger)offset{
    
    self.offset = offset;
    
}

- (void)reply{
    
    
    
    
}




@end

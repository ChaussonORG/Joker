 //
//  JKMyTopicVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyTopicVM.h"
#import "JKMyTopicMineApi.h"
#import "CHCommonMacro.h"
#import "HHTGetString.h"
#import "JKMyTopicReplyedApi.h"
@interface JKMyTopicVM()

@property (nonatomic , strong) NSMutableArray <JKTopicListCellVM *>*cellViewModels;
 
@property (nonatomic , assign) BOOL isFinishRequestMoreData;
@end
@implementation JKMyTopicVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.titlesArray = @[@"我发起的",@"我评论的",@"草稿箱"];
        
        self.cellViewModels = [NSMutableArray array];
        
        self.type = JKMyTopicCreated;
        
        
    }
    return self;
}


- (void)requestData{
    
    
    if (self.type == JKMyTopicCreated) {
        JKMyTopicMineApi *api = [[JKMyTopicMineApi alloc]init];
        
        [api startWithSuccessBlock:^(__kindof JKMyTopicMineApi *request) {
            NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray array];
            for (JKMyTopicModelItems *items in request.model.data.items) {
                
                [cellViewModel addObject:[self assembleviewModelWithItem:items]];
                 
            }
            
            if (cellViewModel.count < RequestLimit) {
                self.isFinishRequestMoreData = YES;
            }
            
            self.cellViewModels = [cellViewModel copy];
            
        } failureBlock:^(__kindof JKMyTopicMineApi *request) {
            
            
            
        }];
        
    }
    else if (self.type == JKMyTopicCommented) {
    
        JKMyTopicReplyedApi *api = [[JKMyTopicReplyedApi alloc]init];
        
        [api startWithSuccessBlock:^(__kindof JKMyTopicReplyedApi *request) {
            NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray array];
            for (JKMyTopicModelItems *items in request.model.data.items) {
                
                [cellViewModel addObject:[self assembleviewModelWithItem:items]];
                
            }
            
            if (cellViewModel.count < RequestLimit) {
                self.isFinishRequestMoreData = YES;
            }
            
            self.cellViewModels = [cellViewModel copy];
            
        } failureBlock:^(__kindof JKMyTopicReplyedApi *request) {
            
            
            
        }];
        
    }
    else if (self.type == JKMyTopicdraft) {
        
        
        
    }
    
    
}

- (void)requestMoreData{
    
    if (self.type == JKMyTopicCreated) {
        self.isFinishRequestMoreData  = NO;
        
        JKMyTopicMineApi *api = [[JKMyTopicMineApi alloc]init];
        
        api.requestModel.offset = self.cellViewModels.count;
        
        api.requestModel.limit = RequestLimit;
        
        [api startWithSuccessBlock:^(__kindof JKMyTopicMineApi *request) {
            
            NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray arrayWithArray:self.cellViewModels];
            for (JKMyTopicModelItems *items in request.model.data.items) {
                
                [cellViewModel addObject:[self assembleviewModelWithItem:items]];
                
                
            }
            
            if (cellViewModel.count == self.cellViewModels.count) {
                self.isFinishRequestMoreData = YES;
            }
            self.cellViewModels = [cellViewModel copy];
            
        } failureBlock:^(__kindof JKMyTopicMineApi *request) {
            
        }];
        
    }
    else if (self.type == JKMyTopicCommented) {
        
        
        
    }
    else if (self.type == JKMyTopicdraft) {
        
        
        
    }
    
    
    
}

- (JKTopicListCellVM *)assembleviewModelWithItem:(JKMyTopicModelItems *)items{
    
    JKTopicListCellVM *cellVM = [[JKTopicListCellVM alloc]init];
    
    cellVM.headerUrl = items.userInfo.img;
    
    cellVM.name = items.userInfo.nickname;
    
    cellVM.time = [HHTGetString timeStrwithTimestamp:items.createTime];
    
    cellVM.related = items.projectName;
    
    cellVM.commentCount = items.commentNum;
    
    cellVM.topicId = items.id;
    
    cellVM.projectType = items.projectType;
    
    cellVM.projectId = items.projectId;
    
    //    JKTopicListModelTopicContentBeans *bean = items.topicContentBeans[0];
    
    //    cellVM.content = bean.content;
    
    cellVM.content = items.content;
    
    CGSize nameLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.name, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.nameLabelWeight = nameLabelSize.width;
    
    CGSize contentLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake(ScreenWidth - 50, MAXFLOAT));
    
    cellVM.contentLabelHeight = contentLabelSize.height;
    
    
    cellVM.cellHeight = 110 + cellVM.contentLabelHeight;
    
    return cellVM;
    
}

@end

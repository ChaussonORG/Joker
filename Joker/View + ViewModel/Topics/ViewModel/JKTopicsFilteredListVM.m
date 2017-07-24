//
//  JKTopicsFilteredListVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicsFilteredListVM.h"
#import "JKTopicsListApi.h"
#import "HHTGetString.h"
#import "CHCommonMacro.h"
@interface JKTopicsFilteredListVM()

@property (nonatomic , strong) NSMutableArray <JKTopicListCellVM *>*cellViewModels;


@property (nonatomic , assign) BOOL isFinishRequestMoreData;

@end

@implementation JKTopicsFilteredListVM

- (instancetype)initWithTopicSort:(JKTopicSort)sort
{
    self = [super init];
    if (self) {
        
        _sort = sort;
        
        self.cellViewModels = [NSMutableArray array];
        
        
    }
    return self;
}

- (void)requestData{
    
    JKTopicsListApi *api;
    if (_sort == JKTopicFilm) {
        
        api = [[JKTopicsListApi alloc]initTopicFilm];
 
    }
    else if (_sort == JKTopicTV) {
        
        
        api = [[JKTopicsListApi alloc]initTopicTV];
    }
    else if (_sort == JKTopicCartoon) {
        
        api = [[JKTopicsListApi alloc]initTopicCartoon];
        
    }
    else if (_sort == JKTopicGame) {
        
        api = [[JKTopicsListApi alloc]initTopicGame];
        
    }
    else if (_sort == JKTopicVariety) {
        
        
        api = [[JKTopicsListApi alloc]initTopicVariety];
    }
    api.favorite = YES;
    
    [api startWithSuccessBlock:^(__kindof JKTopicsListApi *request) {
        
        NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray array];
        for (JKTopicListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleviewModelWithItem:items]];
            
            
        }
        
        if (cellViewModel.count < RequestLimit) {
            self.isFinishRequestMoreData = YES;
        }
               
        self.cellViewModels = [cellViewModel copy];
        
    } failureBlock:^(__kindof JKTopicsListApi *request) {
        
        
        
    }];
    
}

- (void)requestMoreData{
    

    JKTopicsListApi *api;
    if (_sort == JKTopicFilm) {
        
        api = [[JKTopicsListApi alloc]initTopicFilm];
        
    }
    else if (_sort == JKTopicTV) {
        
        
        api = [[JKTopicsListApi alloc]initTopicTV];
    }
    else if (_sort == JKTopicCartoon) {
        
        api = [[JKTopicsListApi alloc]initTopicCartoon];
        
    }
    else if (_sort == JKTopicGame) {
        
        api = [[JKTopicsListApi alloc]initTopicGame];
        
    }
    else if (_sort == JKTopicVariety) {
        
        
        api = [[JKTopicsListApi alloc]initTopicVariety];
    }
    api.favorite = YES;
    
    api.requestModel.limit = RequestLimit;
    
    api.requestModel.offset = self.cellViewModels.count;
    
    [api startWithSuccessBlock:^(__kindof JKTopicsListApi *request) {
        
        NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray arrayWithArray:self.cellViewModels];
        for (JKTopicListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleviewModelWithItem:items]];
            
            
        }
        if (cellViewModel.count == self.cellViewModels.count) {
            self.isFinishRequestMoreData = YES;
        }
        self.cellViewModels = [cellViewModel copy];
        
    } failureBlock:^(__kindof JKTopicsListApi *request) {
        
        
        
    }];
    
    
}
- (JKTopicListCellVM *)assembleviewModelWithItem:(JKTopicListModelItems *)items{
    
    JKTopicListCellVM *cellVM = [[JKTopicListCellVM alloc]init];
    
    cellVM.headerUrl = items.icon;
    
    cellVM.name = items.nickname;
    
    cellVM.time = [HHTGetString timeStrwithTimestamp:items.createTime];
    
    cellVM.related = items.projectName;
    
    cellVM.commentCount = items.topicReplayCount;
    
    cellVM.topicId = items.topicId;
    
    cellVM.projectId = items.projectId;
    
    JKTopicListModelTopicContentBeans *bean = items.topicContentBeans[0];
    
    cellVM.content = items.title;
    
    
    CGSize nameLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.name, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.nameLabelWeight = nameLabelSize.width;
    
    CGSize contentLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake(ScreenWidth - 50, MAXFLOAT));
    
    cellVM.contentLabelHeight = contentLabelSize.height;
    
    
    cellVM.cellHeight = 110 + cellVM.contentLabelHeight;
    
    return cellVM;
    
}

@end

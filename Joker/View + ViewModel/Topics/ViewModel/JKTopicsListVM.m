//
//  JKTopicsListVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicsListVM.h"
#import "JKTopicsFilteredListController.h"
#import "JKTopicsListApi.h"
#import "HHTGetString.h"
#import "CHCommonMacro.h"
#import "JKTopicCreateController.h"
#import "JKUserManager.h"
#import "JKBannerApi.h"
@interface JKTopicsListVM()

@property (nonatomic , strong) NSArray *attentFilterTitles;

@property (nonatomic , strong) NSMutableArray *imageArr;

@property (nonatomic , strong) NSArray *imageSelectedArr;

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , strong) NSMutableArray <JKTopicListCellVM *>*cellViewModels;

@property (nonatomic , strong) NSMutableArray <JKTopicListCellVM *>*attendCellViewModels;

@property (nonatomic , assign) BOOL isLogined;

@property (nonatomic , assign) float headerViewHeight;

@property (nonatomic , strong) NSArray *attentFilterImages;

@property (nonatomic , assign) BOOL isFinishRequestMoreData;

@end

@implementation JKTopicsListVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageArr = [NSMutableArray array];
        
        [self.imageArr addObject: @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880401999&di=ba4990f6e6d89d66dcea9832ea01c217&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F78%2Fd%2F250.jpg"];
        
        self.titlesArray = @[@"最 新",@"关 注"];
        
        self.attentFilterTitles = @[@"电影",@"电视",@"动画",@"游戏",@"综艺"];
        
        self.attentFilterImages = @[@"Film",@"TV",@"Animation",@"Game",@"Variety"];
        
        self.cellViewModels = [NSMutableArray array];
        
        self.attendCellViewModels = [NSMutableArray array];
        
       
        [self checkLogin];
        
    }
    return self;
}


- (void)checkLogin{
    
    if ([[JKUserManager sharedData] isUserEffective]) {
        self.isLogined = YES;
    }
    else{
        self.isLogined = NO;
    }
    
}

 
- (void)requestData{
    
    JKBannerApi *api = [[JKBannerApi alloc]init];
    [api startWithSuccessBlock:^(__kindof JKBannerApi *request) {
        NSArray *arr = request.response.responseJSONObject[@"data"];
        NSMutableArray *mutableArr = [NSMutableArray array];
        [mutableArr addObject:arr[1]];
        [mutableArr addObject:arr[3]];
        
        self.imageArr = [mutableArr copy];
        
    } failureBlock:^(__kindof JKBannerApi *request) {
        
        
    }];
    
    if (!self.isLogined) {
        
        self.topicFilterType = JKTopicLast;
        
        [self requestTopicLastList];
        
    }
    else{
        
        
        if (self.topicFilterType == JKTopicLast) {
            
            [self requestTopicLastList];
            
            [self requestTopicAttendList];
        }
        else{
            
            [self requestTopicAttendList];
        }
        
    }
 
    
}

- (void)requestMoreData{
    
    
    
    
    if (!self.isLogined) {
        
        self.topicFilterType = JKTopicLast;
        
        [self requestMoreTopicLastList];
        
    }
    else{
        
        
        if (self.topicFilterType == JKTopicLast) {
            
            [self requestMoreTopicLastList];
            
            [self requestMoreTopicAttendList];
        }
        else{
            
            [self requestMoreTopicAttendList];
        }
        
    }
}

- (void)requestTopicLastList{
    
    self.isFinishRequestMoreData  = NO;
    JKTopicsListApi *api = [[JKTopicsListApi alloc]init];
    
    api.favorite = NO;
 
    api.requestModel.limit = RequestLimit;
    
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
- (void)requestMoreTopicLastList{
    
    JKTopicsListApi *api = [[JKTopicsListApi alloc]init];
    
    api.favorite = NO;
    
    api.requestModel.offset = self.cellViewModels.count;
    
    api.requestModel.limit = RequestLimit;
    
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
- (void)requestTopicAttendList{
    
    JKTopicsListApi *api = [[JKTopicsListApi alloc]init];
    
    api.favorite = YES;
    
    api.requestModel.limit = RequestLimit;
  
    [api startWithSuccessBlock:^(__kindof JKTopicsListApi *request) {
        
        NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray array];
        for (JKTopicListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleviewModelWithItem:items]];
            
            
        }
        
        if (cellViewModel.count < RequestLimit) {
            self.isFinishRequestMoreData = YES;
        }

        self.attendCellViewModels = [cellViewModel copy];
        
    } failureBlock:^(__kindof JKTopicsListApi *request) {
        
    }];
    
}

- (void)requestMoreTopicAttendList{
    self.isFinishRequestMoreData  = NO;
    
    JKTopicsListApi *api = [[JKTopicsListApi alloc]init];
    
    api.favorite = YES;
    
    api.requestModel.offset = self.attendCellViewModels.count;
    
    api.requestModel.limit = RequestLimit;
    
    [api startWithSuccessBlock:^(__kindof JKTopicsListApi *request) {
        
        NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray arrayWithArray:self.attendCellViewModels];
        for (JKTopicListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleviewModelWithItem:items]];
            
            
        }
        
        if (cellViewModel.count == self.attendCellViewModels.count) {
            self.isFinishRequestMoreData = YES;
        }
        self.attendCellViewModels = [cellViewModel copy];
        
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
    
    cellVM.projectType = items.projectType;
    
    cellVM.projectId = items.projectId;
    
    JKTopicListModelTopicContentBeans *bean = items.topicContentBeans[0];
    
//    cellVM.content = bean.content;
    
    cellVM.content = items.title;
    
    CGSize nameLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.name, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.nameLabelWeight = nameLabelSize.width;
    
    CGSize contentLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake(ScreenWidth - 50, MAXFLOAT));
  
    cellVM.contentLabelHeight = contentLabelSize.height;
    
    
    cellVM.cellHeight = 110 + cellVM.contentLabelHeight;
    
    return cellVM;
    
}

- (void)gotoTopicfilteredListWithIndex:(NSInteger)index{
    
    JKTopicSort sort = index;
    
    JKTopicsFilteredListController *vc = [[JKTopicsFilteredListController alloc]initWithTopicSort:sort];
    
    vc.title = [NSString stringWithFormat:@"%@话题",self.attentFilterTitles[index]];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
}

- (void)changeTypeWithIndex:(NSInteger)index{
    
    if (index == 0) {
        
        self.topicFilterType = JKTopicLast;
    }
    else{
        
        self.topicFilterType = JKTopicAttend;
    }
    
    
    [self requestData];
    
}


- (void)createTopic{
    
    if (self.isLogined) {
        
        JKTopicCreateController *vc = [[JKTopicCreateController alloc]init];
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
  
    
}
@end

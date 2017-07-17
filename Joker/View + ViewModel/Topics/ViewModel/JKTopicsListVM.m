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
@interface JKTopicsListVM()

@property (nonatomic , strong) NSArray *attentFilterTitles;

@property (nonatomic , strong) NSArray *imageArr;

@property (nonatomic , strong) NSArray *imageSelectedArr;

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , strong) NSMutableArray <JKTopicListCellVM *>*cellViewModels;

@property (nonatomic , strong) NSMutableArray <JKTopicListCellVM *>*attendCellViewModels;

@property (nonatomic , assign) BOOL isLogined;

@property (nonatomic , assign) float headerViewHeight;

@property (nonatomic , strong) NSArray *attentFilterImages;

@end

@implementation JKTopicsListVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.imageArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880401999&di=ba4990f6e6d89d66dcea9832ea01c217&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F78%2Fd%2F250.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880450952&di=e0386e70958b230adec0a063a871bb0d&imgtype=0&src=http%3A%2F%2Fwww.qihualu.net.cn%2FVimages%2Fbd1938384.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880489400&di=1805f04fa8b90a7145bee610af129fa1&imgtype=0&src=http%3A%2F%2Fwww.bz55.com%2Fuploads%2Fallimg%2F100722%2F0933553a9-2.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880548256&di=66722048d74180758bff742f9855caf4&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2015%2F162%2F48%2F9TZ0JJK73519.jpg"];
        
        self.titlesArray = @[@"最 新",@"关 注"];
        
        self.attentFilterTitles = @[@"电影",@"电视",@"动画",@"游戏",@"综艺"];
        
        self.attentFilterImages = @[@"Film",@"TV",@"Animation",@"Game",@"Variety"];
        
        self.cellViewModels = [NSMutableArray array];
        
        self.attendCellViewModels = [NSMutableArray array];
        
        self.isLogined =  YES;
     
        
    }
    return self;
}

 
- (void)requestData{
    
    
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


- (void)requestTopicLastList{
    
    JKTopicsListApi *api = [[JKTopicsListApi alloc]init];
    
    api.favorite = NO;
 
    [api startWithSuccessBlock:^(__kindof JKTopicsListApi *request) {
        
        NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray array];
        for (JKTopicListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleviewModelWithItem:items]];
            
            
        }
        self.cellViewModels = [cellViewModel copy];
        
    } failureBlock:^(__kindof JKTopicsListApi *request) {
        
    }];
    
}

- (void)requestTopicAttendList{
    
    JKTopicsListApi *api = [[JKTopicsListApi alloc]init];
    
    api.favorite = YES;
  
    [api startWithSuccessBlock:^(__kindof JKTopicsListApi *request) {
        
        NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray array];
        for (JKTopicListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleviewModelWithItem:items]];
            
            
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
    
    cellVM.projectId = items.projectId;
    
    JKTopicListModelTopicContentBeans *bean = items.topicContentBeans[0];
    
    cellVM.content = bean.content;
    
    
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
    
    
    JKTopicCreateController *vc = [[JKTopicCreateController alloc]init];
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
    
}
@end

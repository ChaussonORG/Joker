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
#import "JKUserManager.h"
@interface JKMyTopicVM()

@property (nonatomic , strong) NSMutableArray <JKTopicListCellVM *>*cellViewModels;

@property (nonatomic , strong) NSMutableArray <JKTopicListCellVM *>*draftCellViewModels;

@property (nonatomic , assign) NSInteger index;
 
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
        
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path1 = [pathArray objectAtIndex:0];
        NSString *myPath = [path1 stringByAppendingPathComponent:@"topicDraft.plist"];
        
        NSMutableDictionary *data2 = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
        
        
        self.draftCellViewModels = [NSMutableArray array];
        self.index = 1;
        [self assembleviewModelWithData:data2];
        
        
        self.cellViewModels = [self.draftCellViewModels copy];
        
    }
    
    
}

- (void)assembleviewModelWithData:(NSDictionary *)data{
    
    if ([data objectForKey:[NSString stringWithFormat:@"%ld",self.index]]) {
        
        NSDictionary *dic = [data objectForKey:[NSString stringWithFormat:@"%ld",self.index]];
        
         JKTopicListCellVM *cellVM = [[JKTopicListCellVM alloc]init];
        
        cellVM.style = TopicCommentDraft;
        
        cellVM.headerUrl = [JKUserManager sharedData].currentUser.photo;
        
        cellVM.name =  [JKUserManager sharedData].currentUser.nickname;
        
//        cellVM.time = [HHTGetString timeStrwithTimestamp:items.createTime];
        
        cellVM.related = [dic objectForKey:@"relateWorkName"];
        
//        cellVM.topicId = [dic objectForKey:@"projectId"];
        
        cellVM.projectType = [dic objectForKey:@"projectType"];
        
        cellVM.projectId = [dic objectForKey:@"projectId"];
         
        cellVM.draftNum = [NSString stringWithFormat:@"%ld",self.index];
        //    JKTopicListModelTopicContentBeans *bean = items.topicContentBeans[0];
        
        //    cellVM.content = bean.content;
        
        cellVM.content = [dic objectForKey:@"title"];
        
        cellVM.topicContent = [dic objectForKey:@"content"];
        
        CGSize nameLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.name, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
        
        cellVM.nameLabelWeight = nameLabelSize.width;
        
        CGSize contentLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake(ScreenWidth - 50, MAXFLOAT));
        
        cellVM.contentLabelHeight = contentLabelSize.height;
        
        
        cellVM.cellHeight = 110 + cellVM.contentLabelHeight;
        [self.draftCellViewModels addObject:cellVM];
        
        self.index ++ ;
        
        [self assembleviewModelWithData:data];
        
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

//
//  JKWorkDetailVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/30.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkDetailVM.h"
#import "JKFilmDetailApi.h"
#import "JKTopicsListApi.h"
#import "CHCommonMacro.h"
#import "HHTGetString.h"
#import "JKUserManager.h"
@interface JKWorkDetailVM()

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , assign) BOOL isLogined;

@end
@implementation JKWorkDetailVM

- (instancetype)initWithWorkId:(NSString *)workId
{
    self = [super init];
    if (self) {
        
        _workId = workId;
        
        
        self.directorsArr = [NSMutableArray array];
        
        self.titlesArray = @[@"信 息",@"评 论",@"话 题"];
       
        self.filterType = JKFilmDataInfo;
        
        self.topicCellVMs = [NSMutableArray array];
        
        self.topCellVMs = [NSMutableArray array];
        
        self.bottemCellVMs = [NSMutableArray array];
        
        self.commentCellVMs = [NSMutableArray array];
    }
    return self;
}
- (void)requestData{
    
    JKFilmDetailApi *api = [[JKFilmDetailApi alloc]initWithWorkId:self.workId];
    
    [api startWithSuccessBlock:^(__kindof JKFilmDetailApi *request) {
        
        
        self.workImage = request.model.data.coverImage;
        
       self.workBgImage = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fixed,h_300,w_500",self.workImage];
        
        self.name = request.model.data.name;
        
        for (NSString *str1 in request.model.data.types) {
            
            if (self.strOne.length > 0) {
                 self.strOne = [NSString stringWithFormat:@"%@ %@",self.strOne,str1];
            }
            else{
                self.strOne = str1;
                
            }
           
        }
        
        for (int i = 0 ; i <request.model.data.areas.count; i ++) {
            
            NSString *str2 = request.model.data.areas[i];
            
            if (i < 2) {
                if (self.strTwo.length > 0) {
                    self.strTwo = [NSString stringWithFormat:@"%@ %@",self.strTwo,str2];
                }
                else{
                    self.strTwo = str2;
                    
                }

            }
            else{
                self.strTwo = [NSString stringWithFormat:@"%@...",self.strTwo];
                
            }
            
            
        }
        self.strTwo = [NSString stringWithFormat:@"%@/%@",self.strTwo,request.model.data.duration];
        
        
        self.strThree = [NSString stringWithFormat:@"%@上映",request.model.data.releaseDate];
        
        
        self.score1 = request.model.data.doubanScore;
        
        self.score2 = request.model.data.imdbScore;
        
        self.score3 = request.model.data.tomatoeScore;
        
        self.score4 = request.model.data.mcScore;
        
        self.jokerScore = request.model.data.jokerScore;
        
        self.imageArrs = request.model.data.coverImageList;
        
        self.desc = request.model.data.desc;
        
        
        for (JKFilmDetailModelStaff *staff in request.model.data.staff) {
            
            [self.directorsArr addObject:[self assembleViewModelWithStaff:staff]];
        }
        
        if (self.directorsArr.count%4 == 0) {
            self.directorsCellHeight =(self.directorsArr.count/4 )*110 +36;
        }
        else{
            
            if (self.directorsArr.count > 8) {
                 self.directorsCellHeight =2*110 + 36;
            }
            else{
                 self.directorsCellHeight =(self.directorsArr.count/4 + 1)*110 + 36;
                
            }
           
        }
        
        CGSize descLabelSize =  CH_TRANSFORM_TEXTSIZE(self.desc, [JKStyleConfiguration titleFont], CGSizeMake(ScreenWidth - 40, MAXFLOAT));
        
        self.descCellHeight = descLabelSize.height + 36 + 40;

        if (self.imageArrs.count%4 == 0) {
            self.imagesCellHeight =(self.imageArrs.count/4 )*((ScreenWidth - 50)/4) +36;
        }
        else{
            self.imagesCellHeight =(self.imageArrs.count/4 + 1)*((ScreenWidth - 50)/4 + 10) + 36;
        }
        
        
        
    } failureBlock:^(__kindof JKFilmDetailApi *request) {
        
        
        
    }];
    
    
    [self requestTopicData];
    
}

- (void)requestTopicData{
    
    
    JKTopicsListApi *api = [[JKTopicsListApi alloc]initTopicFilm];
    api.projectId = self.workId;
    
    api.requestModel.limit = RequestLimit;
    
    [api startWithSuccessBlock:^(__kindof JKTopicsListApi *request) {
        
        NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray array];
        for (JKTopicListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleTopicViewModelWithItem:items]];
            
            
        }
        
//        if (cellViewModel.count < RequestLimit) {
//            self.isFinishRequestMoreData = YES;
//        }
        
        self.topicCellVMs = [cellViewModel copy];
        
    } failureBlock:^(__kindof JKTopicsListApi *request) {
        
    }];

    
}

- (JKTopicListCellVM *)assembleTopicViewModelWithItem:(JKTopicListModelItems *)items{
    
    JKTopicListCellVM *cellVM = [[JKTopicListCellVM alloc]init];
    
    cellVM.headerUrl = items.icon;
    
    cellVM.name = items.nickname;
    
    cellVM.time = [HHTGetString timeStrwithTimestamp:items.createTime];
    
    cellVM.related = items.projectName;
    
    cellVM.commentCount = items.topicReplayCount;
    
    cellVM.topicId = items.topicId;
    
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

- (JKFilmStaffCellVM *)assembleViewModelWithStaff:(JKFilmDetailModelStaff *)staff{
    
    JKFilmStaffCellVM *cellVM = [[JKFilmStaffCellVM alloc]init];
    
    cellVM.personId = staff.personId;
    
    cellVM.name = staff.name;
    
    cellVM.actName = staff.actName;
    
    cellVM.degree = staff.degree;
    
    cellVM.img = staff.img;
    
    return cellVM;
}
- (void)checkLogin{
    
    if ([[JKUserManager sharedData] isUserEffective]) {
        self.isLogined = YES;
    }
    else{
        self.isLogined = NO;
    }
    
}

@end

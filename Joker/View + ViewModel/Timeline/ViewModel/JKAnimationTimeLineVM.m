//
//  JKAnimationTimeLineVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKAnimationTimeLineVM.h"
#import "JKTimelineListApi.h"
#import "CHCommonMacro.h"
#import "HHTGetString.h"
@interface JKAnimationTimeLineVM()

@property (nonatomic , strong) NSMutableArray <JKAnimationTimelineCellVM *>*cellViewModels;

@end


@implementation JKAnimationTimeLineVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.titlesArray = @[@"正 在 热 播",@"即 将 播 出"];
        
        self.type = JKAnimationCurrent;
        
        self.cellViewModels = [NSMutableArray array];
        
        self.queryPage = 1;
    }
    return self;
}


- (void)requestData{
    self.isFinishRequestMoreData = NO;
    JKTimelineListApi *api = [[JKTimelineListApi alloc]initTimelineCartoon];
    
    if (self.type  == JKAnimationCurrent) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//        NSDate *datenow = [NSDate date];
//        api.endDate = [formatter stringFromDate:datenow];
//        NSInteger dis = 60; //前后的天数
//        NSDate* theDate;
//        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
//        //之后的天数
//        theDate = [datenow initWithTimeIntervalSinceNow: - oneDay*dis ];
//        api.startDate = [formatter stringFromDate:theDate];
//
//        api.sortOrder = @"desc";
        
        api.queryType = @"reying";
        
    }
    else{
        api.queryType = @"jijiang";
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//        NSDate *datenow = [NSDate date];
//
//        //        NSInteger dis = 30; //前后的天数
//        NSDate* theDate;
//        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
//        //之后的天数
//        theDate = [datenow initWithTimeIntervalSinceNow: +oneDay*1 ];
//        api.startDate = [formatter stringFromDate:theDate];
//        theDate = [datenow initWithTimeIntervalSinceNow: +oneDay*31 ];
//        api.endDate = [formatter stringFromDate:theDate];
//
//        api.sortOrder = @"asc";
//
        
    }
    api.requestModel.limit = 1000;
    
    self.queryPage = 1;
    
    api.queryPage = self.queryPage;
    
    [CHProgressHUD show:YES];
    [api startWithSuccessBlock:^(__kindof JKTimelineListApi *request) {
        [CHProgressHUD hide:YES];
        NSMutableArray <JKAnimationTimelineCellVM *>*cellViewModels = [NSMutableArray array];
        
        NSMutableArray <JKAnimationTimeLineCollectionViewCellVM *>*cellVMs = [NSMutableArray array];
        
        NSString *tempDate;
        
        for (int i = 0 ; i < request.model.data.items.count ; i++) {
            
            JKTimelineFilmModelItems *item = request.model.data.items[i];
            
            if (tempDate == nil) {
                
                JKTimelineFilmModelItems *item0 = request.model.data.items[0];
                tempDate = item0.openDate;
            }
            else{
                
                if (![tempDate isEqualToString:item.openDate]) {
                    
                    if (cellViewModels.count == 0) {
                        [cellViewModels addObject:[self assembleViewModelWithOpenDate:tempDate andCellVMs:cellVMs isFirstDay:YES]];
                        
                        cellVMs  = [NSMutableArray array];
                        
                    }
                    else{
                        
                        
                        [cellViewModels addObject:[self assembleViewModelWithOpenDate:tempDate andCellVMs:cellVMs isFirstDay:NO]];
                        
                        cellVMs  = [NSMutableArray array];
                    }
                    
                    tempDate = item.openDate;
                    
                }
                
            }
            
            JKAnimationTimeLineCollectionViewCellVM *cellVM = [[JKAnimationTimeLineCollectionViewCellVM alloc]init];
            
            cellVM.imageUrl = item.coverImgUrl;
            
            cellVM.name = item.name;
            
            cellVM.extId = item.extId;
            
            cellVM.favoriteCount = item.collectQuantity;
            
            cellVM.belongType = item.belongType;
            
            cellVM.jokerScore = item.jokerScore;
            
            cellVM.score1 = item.doubanScore;
            
            cellVM.score2 = item.imdbScore;
            
            cellVM.score3 = item.tomatoeScore;
            
            cellVM.score4 = item.mcScore;
            
            cellVM.isfavorite = [item.favotite boolValue];
            
            cellVM.isRecommand = [item.recommend boolValue];
            
            cellVM.isON = self.type == JKAnimationCurrent? YES:NO;
            
            for (JKTimelineFilmModelDirector  *director in item.supervision) {
                
                if (cellVM.directors.length > 0) {
                    cellVM.directors = [NSString stringWithFormat:@"%@/%@",cellVM.directors,director.name];
                }
                else{
                    
                    cellVM.directors = [NSString stringWithFormat:@"监督：%@",director.name];
                    
                }
            }
            if (cellVM.directors.length == 0) {
                cellVM.directors = @"监督：";
            }
            for (JKTimelineFilmModelMainActor  *mainActor in item.soundActor) {
                
                if (cellVM.mainActors.length > 0) {
                    cellVM.mainActors = [NSString stringWithFormat:@"%@/%@",cellVM.mainActors,mainActor.name];
                }
                else{
                    
                    cellVM.mainActors = [NSString stringWithFormat:@"声优：%@",mainActor.name];
                    
                }
            }
            
            if (cellVM.mainActors.length == 0) {
                cellVM.mainActors = @"声优：";
            }
            [cellVMs addObject:cellVM];
            
        }
        
        if (cellViewModels.count == 0) {
            if (cellVMs.count>0) {
                [cellViewModels addObject:[self assembleViewModelWithOpenDate:tempDate andCellVMs:cellVMs isFirstDay:YES]];
            }
            
        }
        else{
            
            
            [cellViewModels addObject:[self assembleViewModelWithOpenDate:tempDate andCellVMs:cellVMs isFirstDay:NO]];
        }
        
        self.cellViewModels = [cellViewModels copy];
    } failureBlock:^(__kindof JKTimelineListApi *request) {
        
        [CHProgressHUD hide:YES];
        
    }];
    
    
}

- (JKAnimationTimelineCellVM *)assembleViewModelWithOpenDate:(NSString *)date andCellVMs:(NSMutableArray <JKAnimationTimeLineCollectionViewCellVM *>*)cellVMs isFirstDay:(BOOL)isfirstDay{
    
    JKAnimationTimelineCellVM *cellVM = [[JKAnimationTimelineCellVM alloc]init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:datenow];
    NSString *week;
    
    if (self.type == JKAnimationCurrent) {
        
        week = [HHTGetString passWeekdayWithDate:date];
    }
    else{
        week = [HHTGetString featureWeekdayWithDate:date];
        
    }
    
    
    
    if ([date containsString:dateStr]) {
        
        cellVM.date = [NSString stringWithFormat:@"今天/%@",week];
        
    }
    else{
        
        cellVM.date = [NSString stringWithFormat:@"%@/%@",[HHTGetString assembleMonthDayStrWithDate:date],week];
    }
    
    if (isfirstDay && self.type == JKAnimationCurrent) {
        
        cellVM.isRecommend = YES;
        for (int i = 0; i < cellVMs.count; i ++) {
            JKAnimationTimeLineCollectionViewCellVM *cellViewModel = cellVMs[i];
            
            if (cellViewModel.isRecommand) {
                
                [cellVM.recommendArr addObject:cellViewModel];
                
            }
            else{
                
                [cellVM.cellViewModels addObject:cellViewModel];
            }
            
        }
    }
    else{
        cellVM.isRecommend = NO;
        cellVM.cellViewModels = [cellVMs copy];
    }
    
    cellVM.recommendViewHeight = cellVM.recommendArr.count * 180;
    
    
    if (cellVM.cellViewModels.count%3 == 0) {
        cellVM.collectionViewHeight =(cellVM.cellViewModels.count/3 )*205;
    }
    else{
        cellVM.collectionViewHeight =(cellVM.cellViewModels.count/3 + 1)*205;
    }
    
    cellVM.cellHeight = 36 + cellVM.recommendViewHeight + cellVM.collectionViewHeight;
    
    
    return cellVM;
    
}
- (void)requestMoreData{
  
    JKTimelineListApi *api = [[JKTimelineListApi alloc]initTimelineCartoon];
    
    if (self.type  == JKAnimationCurrent) {
      
        
        api.queryType = @"reying";
        
    }
    else{
        api.queryType = @"jijiang";
        
        
    }
    api.requestModel.limit = 1000;
    
    self.queryPage += 1;
    
    api.queryPage = self.queryPage;
    
    [CHProgressHUD show:YES];
    [api startWithSuccessBlock:^(__kindof JKTimelineListApi *request) {
        [CHProgressHUD hide:YES];
        NSMutableArray <JKAnimationTimelineCellVM *>*cellViewModels = [NSMutableArray arrayWithArray:self.cellViewModels];
        
        NSMutableArray <JKAnimationTimeLineCollectionViewCellVM *>*cellVMs = [NSMutableArray array];
        
        NSString *tempDate;
        
        for (int i = 0 ; i < request.model.data.items.count ; i++) {
            
            JKTimelineFilmModelItems *item = request.model.data.items[i];
            
            if (tempDate == nil) {
                
                JKTimelineFilmModelItems *item0 = request.model.data.items[0];
                tempDate = item0.openDate;
            }
            else{
                
                if (![tempDate isEqualToString:item.openDate]) {
                    
                    if (cellViewModels.count == 0) {
                        [cellViewModels addObject:[self assembleViewModelWithOpenDate:tempDate andCellVMs:cellVMs isFirstDay:YES]];
                        
                        cellVMs  = [NSMutableArray array];
                        
                    }
                    else{
                        
                        
                        [cellViewModels addObject:[self assembleViewModelWithOpenDate:tempDate andCellVMs:cellVMs isFirstDay:NO]];
                        
                        cellVMs  = [NSMutableArray array];
                    }
                    
                    tempDate = item.openDate;
                    
                }
                
            }
            
            JKAnimationTimeLineCollectionViewCellVM *cellVM = [[JKAnimationTimeLineCollectionViewCellVM alloc]init];
            
            cellVM.imageUrl = item.coverImgUrl;
            
            cellVM.name = item.name;
            
            cellVM.extId = item.extId;
            
            cellVM.favoriteCount = item.collectQuantity;
            
            cellVM.belongType = item.belongType;
            
            cellVM.jokerScore = item.jokerScore;
            
            cellVM.score1 = item.doubanScore;
            
            cellVM.score2 = item.imdbScore;
            
            cellVM.score3 = item.tomatoeScore;
            
            cellVM.score4 = item.mcScore;
            
            cellVM.isfavorite = [item.favotite boolValue];
            
            cellVM.isRecommand = [item.recommend boolValue];
            
            cellVM.isON = self.type == JKAnimationCurrent? YES:NO;
            
            for (JKTimelineFilmModelDirector  *director in item.supervision) {
                
                if (cellVM.directors.length > 0) {
                    cellVM.directors = [NSString stringWithFormat:@"%@/%@",cellVM.directors,director.name];
                }
                else{
                    
                    cellVM.directors = [NSString stringWithFormat:@"监督：%@",director.name];
                    
                }
            }
            if (cellVM.directors.length == 0) {
                cellVM.directors = @"监督：";
            }
            for (JKTimelineFilmModelMainActor  *mainActor in item.soundActor) {
                
                if (cellVM.mainActors.length > 0) {
                    cellVM.mainActors = [NSString stringWithFormat:@"%@/%@",cellVM.mainActors,mainActor.name];
                }
                else{
                    
                    cellVM.mainActors = [NSString stringWithFormat:@"声优：%@",mainActor.name];
                    
                }
            }
            
            if (cellVM.mainActors.length == 0) {
                cellVM.mainActors = @"声优：";
            }
            [cellVMs addObject:cellVM];
            
        }
        
        if (cellViewModels.count == 0) {
            if (cellVMs.count>0) {
                [cellViewModels addObject:[self assembleViewModelWithOpenDate:tempDate andCellVMs:cellVMs isFirstDay:YES]];
            }
            
        }
        else{
            
            if (tempDate.length > 0) {
                [cellViewModels addObject:[self assembleViewModelWithOpenDate:tempDate andCellVMs:cellVMs isFirstDay:NO]];
            }
            
        }
        if (self.type == JKAnimationCurrent) {
            if (self.queryPage > 5) {
                
                self.isFinishRequestMoreData = YES;
            }
            else{
                self.isFinishRequestMoreData = NO;
                
            }
        }
        else{
            
            if (self.queryPage > 2) {
                
                self.isFinishRequestMoreData = YES;
            }
            else{
                self.isFinishRequestMoreData = NO;
                
            }
        }
        self.cellViewModels = [cellViewModels copy];
    } failureBlock:^(__kindof JKTimelineListApi *request) {
        
        [CHProgressHUD hide:YES];
        
    }];
    
    
}

@end

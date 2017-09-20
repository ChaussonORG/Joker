//
//  JKVarietyTimeLineVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKVarietyTimeLineVM.h"
#import "JKTimelineListApi.h"
#import "CHCommonMacro.h"
#import "HHTGetString.h"
@interface JKVarietyTimeLineVM()

@property (nonatomic , strong) NSMutableArray <JKVarietyTimelineCellVM *>*cellViewModels;

@end


@implementation JKVarietyTimeLineVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.titlesArray = @[@"正 在 热 播",@"即 将 播 出"];
        
        self.type = JKVarietyCurrent;
        
        self.cellViewModels = [NSMutableArray array];
    }
    return self;
}


- (void)requestData{
    
    JKTimelineListApi *api = [[JKTimelineListApi alloc]initTimelineVariety];
    
    if (self.type  == JKVarietyCurrent) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *datenow = [NSDate date];
        api.endDate = [formatter stringFromDate:datenow];
        NSInteger dis = 60; //前后的天数
        NSDate* theDate;
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        //之后的天数
        theDate = [datenow initWithTimeIntervalSinceNow: - oneDay*dis ];
        api.startDate = [formatter stringFromDate:theDate];
        
        api.sortOrder = @"desc";
        
        
        
    }
    else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *datenow = [NSDate date];
        
        //        NSInteger dis = 30; //前后的天数
        NSDate* theDate;
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        //之后的天数
        theDate = [datenow initWithTimeIntervalSinceNow: +oneDay*1 ];
        api.startDate = [formatter stringFromDate:theDate];
        theDate = [datenow initWithTimeIntervalSinceNow: +oneDay*31 ];
        api.endDate = [formatter stringFromDate:theDate];
        
        api.sortOrder = @"asc";
        
        
    }
    api.requestModel.limit = 1000;
    
    [api startWithSuccessBlock:^(__kindof JKTimelineListApi *request) {
        
        NSMutableArray <JKVarietyTimelineCellVM *>*cellViewModels = [NSMutableArray array];
        
        NSMutableArray <JKVarietyTimeLineCollectionViewCellVM *>*cellVMs = [NSMutableArray array];
        
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
            
            JKVarietyTimeLineCollectionViewCellVM *cellVM = [[JKVarietyTimeLineCollectionViewCellVM alloc]init];
            
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
            
            for (JKTimelineFilmModelDirector  *director in item.hostList) {
                
                if (cellVM.directors.length > 0) {
                    cellVM.directors = [NSString stringWithFormat:@"%@/%@",cellVM.directors,director.name];
                }
                else{
                    
                    cellVM.directors = [NSString stringWithFormat:@"主持人：%@",director.name];
                    
                }
            }
            if (cellVM.directors.length == 0) {
                cellVM.directors = @"主持人：";
            }
            for (JKTimelineFilmModelMainActor  *mainActor in item.guestList) {
                
                if (cellVM.mainActors.length > 0) {
                    cellVM.mainActors = [NSString stringWithFormat:@"%@/%@",cellVM.mainActors,mainActor.name];
                }
                else{
                    
                    cellVM.mainActors = [NSString stringWithFormat:@"嘉宾：%@",mainActor.name];
                    
                }
            }
            
            if (cellVM.mainActors.length == 0) {
                cellVM.mainActors = @"嘉宾：";
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
        
        
        
    }];
    
    
}

- (JKVarietyTimelineCellVM *)assembleViewModelWithOpenDate:(NSString *)date andCellVMs:(NSMutableArray <JKVarietyTimeLineCollectionViewCellVM *>*)cellVMs isFirstDay:(BOOL)isfirstDay{
    
    JKVarietyTimelineCellVM *cellVM = [[JKVarietyTimelineCellVM alloc]init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:datenow];
    NSString *week;
    
    if (self.type == JKVarietyCurrent) {
        
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
    
    if (isfirstDay && self.type == JKVarietyCurrent) {
        
        cellVM.isRecommend = YES;
        for (int i = 0; i < cellVMs.count; i ++) {
            JKVarietyTimeLineCollectionViewCellVM *cellViewModel = cellVMs[i];
            
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

@end

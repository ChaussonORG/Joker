//
//  JKGameTimeLineVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKGameTimeLineVM.h"
#import "JKTimelineListApi.h"
#import "CHCommonMacro.h"
#import "HHTGetString.h"
@interface JKGameTimeLineVM()

@property (nonatomic , strong) NSMutableArray <JKGameTimelineCellVM *>*cellViewModels;

@end


@implementation JKGameTimeLineVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.titlesArray = @[@"正 在 热 卖",@"即 将 上 市"];
        
        self.type = JKGameCurrent;
        
        self.cellViewModels = [NSMutableArray array];
    }
    return self;
}


- (void)requestData{
    self.isFinishRequestMoreData = NO;
    JKTimelineListApi *api = [[JKTimelineListApi alloc]initTimelineGame];
    
    if (self.type  == JKGameCurrent) {
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
        api.queryType = @"jijiang";
    }
    api.requestModel.limit = 1000;
    [CHProgressHUD show:YES];
    [api startWithSuccessBlock:^(__kindof JKTimelineListApi *request) {
         [CHProgressHUD hide:YES];
        NSMutableArray <JKGameTimelineCellVM *>*cellViewModels = [NSMutableArray array];
        
        NSMutableArray <JKGameTimeLineCollectionViewCellVM *>*cellVMs = [NSMutableArray array];
        
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
            
            JKGameTimeLineCollectionViewCellVM *cellVM = [[JKGameTimeLineCollectionViewCellVM alloc]init];
            
            cellVM.imageUrl = item.coverImgUrl;
            
            cellVM.name = item.name;
            
            cellVM.extId = item.extId;
            
            cellVM.favoriteCount = item.collectQuantity;
            
            cellVM.belongType = item.belongType;
            
            cellVM.language = item.language;
            
            cellVM.version = item.version;
            
            
            cellVM.jokerScore = item.joker_score;
            
            cellVM.score1 = item.ign_score;
            
            cellVM.score2 = item.gs_score;
            
            cellVM.score3 = item.fami_score;
            
            cellVM.score4 = item.mc_score;
            
            cellVM.isfavorite = [item.favotite boolValue];
            
            cellVM.isRecommand = [item.recommend boolValue];
            
            cellVM.platform = item.platform;
            
            cellVM.version = item.version;
            
            cellVM.language = item.language;
            
            cellVM.isON = self.type == JKGameCurrent? YES:NO;
            
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

- (JKGameTimelineCellVM *)assembleViewModelWithOpenDate:(NSString *)date andCellVMs:(NSMutableArray <JKGameTimeLineCollectionViewCellVM *>*)cellVMs isFirstDay:(BOOL)isfirstDay{
    
    JKGameTimelineCellVM *cellVM = [[JKGameTimelineCellVM alloc]init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:datenow];
    NSString *week;
    
    if (self.type == JKGameCurrent) {
        
        week = [HHTGetString passWeekdayWithDate:date];
    }
    else{
        week = [HHTGetString featureWeekdayWithDate:date];
        
    }
    
    if (date ) {
        
        if ( [date containsString:dateStr]) {
            
            cellVM.date = [NSString stringWithFormat:@"今天/%@",week];
            
        }
        else{
            
            cellVM.date = [NSString stringWithFormat:@"%@/%@",[HHTGetString assembleMonthDayStrWithDate:date],week];
        }
    }
    
    
    
    if (isfirstDay && self.type == JKGameCurrent) {
        
        cellVM.isRecommend = YES;
        for (int i = 0; i < cellVMs.count; i ++) {
            JKGameTimeLineCollectionViewCellVM *cellViewModel = cellVMs[i];
            
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
    
    JKTimelineListApi *api = [[JKTimelineListApi alloc]initTimelineGame];
    
    if (self.type  == JKGameCurrent) {
        
        
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
        NSMutableArray <JKGameTimelineCellVM *>*cellViewModels = [NSMutableArray arrayWithArray:self.cellViewModels];
        
        NSMutableArray <JKGameTimeLineCollectionViewCellVM *>*cellVMs = [NSMutableArray array];
        
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
            
            JKGameTimeLineCollectionViewCellVM *cellVM = [[JKGameTimeLineCollectionViewCellVM alloc]init];
            
            cellVM.imageUrl = item.coverImgUrl;
            
            cellVM.name = item.name;
            
            cellVM.extId = item.extId;
            
            cellVM.favoriteCount = item.collectQuantity;
            
            cellVM.belongType = item.belongType;
            
            cellVM.language = item.language;
            
            cellVM.version = item.version;
            
            
            cellVM.jokerScore = item.joker_score;
            
            cellVM.score1 = item.ign_score;
            
            cellVM.score2 = item.gs_score;
            
            cellVM.score3 = item.fami_score;
            
            cellVM.score4 = item.mc_score;
            
            cellVM.isfavorite = [item.favotite boolValue];
            
            cellVM.isRecommand = [item.recommend boolValue];
            
            cellVM.platform = item.platform;
            
            cellVM.version = item.version;
            
            cellVM.language = item.language;
            
            cellVM.isON = self.type == JKGameCurrent? YES:NO;
            
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
        if (self.type == JKGameCurrent) {
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

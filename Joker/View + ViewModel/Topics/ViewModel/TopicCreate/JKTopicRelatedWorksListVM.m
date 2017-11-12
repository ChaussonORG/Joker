//
//  JKTopicRelatedWorksListVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicRelatedWorksListVM.h"
#import "JKMyfavoriteWorksApi.h"
#import "HHTGetString.h"

@interface JKTopicRelatedWorksListVM()<chooseFilmDelegate>
@property (nonatomic , strong) NSMutableArray <JKFilmCollectionViewCellVM*>*tempCellViewModels;

@end
@implementation JKTopicRelatedWorksListVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cellViewModels = [NSMutableArray array];
        
        self.tempCellViewModels = [NSMutableArray array];
    }
    return self;
}



- (void)reloadData{
     
    JKMyfavoriteWorksApi *api = [[JKMyfavoriteWorksApi alloc]init];
    api.requestModel.limit = 2000;
    
    [api startWithSuccessBlock:^(__kindof JKMyfavoriteWorksApi *request) {
        
        NSMutableArray <JKFilmCollectionViewCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyfavoriteWorksModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.cellViewModels = [cellViewModels copy];
        
        self.tempCellViewModels = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyfavoriteWorksApi *request) {
        
        
        
        
    }];
    
    
}

- (JKFilmCollectionViewCellVM *)assembleViewModelWithItems:(JKMyfavoriteWorksModelItems *)items{
    
    JKFilmCollectionViewCellVM *cellVM = [[JKFilmCollectionViewCellVM alloc]init];
    
    cellVM.delegate = self;
     cellVM.type = items.type;
    
    NSString *imageUrl;
    NSString *name;
    NSString *score;
    NSString *projectId;
    NSString *favotiteCount;
    BOOL isOn =YES  ;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    if ([items.type isEqualToString:@"MOVIE"]) {
        
        name = items.film.name;
        
        imageUrl = items.film.coverImage;
        
        projectId = items.film.id;
        
        score = items.film.joker_score;
        
        favotiteCount = items.film.favotiteCount;
        
        NSDate *str = [HHTGetString changeTimewithTimestamp:items.film.premiereDate];
        
        if ([self compareDate:datenow withDate:str] == 1) {
            
            isOn = NO;
            
        }
        else{
            
            isOn = YES;
        }
        
        
    }
    else if ([items.type isEqualToString:@"TV"]) {
        
        name = items.tv.name;
        
        imageUrl = items.tv.coverImage;
        
        projectId = items.tv.id;
        
        score = items.tv.joker_score;
        
        favotiteCount = items.tv.favotiteCount;
        
        NSDate *str = [HHTGetString changeTimewithTimestamp:items.tv.premiereDate];
        
        if ([self compareDate:datenow withDate:str] == 1) {
            
            isOn = NO;
            
        }
        else{
            
            isOn = YES;
        }
        
        
    }
    else if ([items.type isEqualToString:@"ANIMATION"]) {
        
        
        name = items.animation.name;
        
        imageUrl = items.animation.coverImage;
        
        projectId = items.animation.id;
        
        score = items.animation.joker_score;
        
        favotiteCount = items.animation.favotiteCount;
        
        NSDate *str = [HHTGetString changeTimewithTimestamp:items.animation.premiereDate];
        
        if ([self compareDate:datenow withDate:str] == 1) {
            
            isOn = NO;
            
        }
        else{
            
            isOn = YES;
        }
        
    }
    
    else if ([items.type isEqualToString:@"GAME"]) {
        
        name = items.game.name;
        
        imageUrl = items.game.coverImage;
        
        projectId = items.game.id;
        
        score = items.game.joker_score;
        
        favotiteCount = items.game.favotiteCount;
        
        NSDate *str = [HHTGetString changeTimewithTimestamp:items.game.premiereDate];
        
        if ([self compareDate:datenow withDate:str] == 1) {
            
            isOn = NO;
            
        }
        else{
            
            isOn = YES;
        }
        
    }
    else if ([items.type isEqualToString:@"VARIETY"]) {
        name = items.variety.name;
        
        imageUrl = items.variety.coverImage;
        
        projectId = items.variety.id;
        
        score = items.variety.joker_score;
        
        favotiteCount = items.variety.favotiteCount;
        
        NSDate *str = [HHTGetString changeTimewithTimestamp:items.variety.premiereDate];
        
        if ([self compareDate:datenow withDate:str] == 1) {
            
            isOn = NO;
            
        }
        else{
            
            isOn = YES;
        }
        
        
        
    }
    cellVM.name = name;
    
    cellVM.imageUrl = imageUrl;
    
    cellVM.projectId = projectId;
    
    cellVM.joker_score = score;
    
    cellVM.isON = isOn;
    
    cellVM.favotiteCount = favotiteCount;
    
    return cellVM;
    
    
}

- (NSInteger)compareDate:(NSDate*)dta withDate:(NSDate*)dtb
{
    NSInteger aa;
//    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
//    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *dta = [[NSDate alloc] init];
//    NSDate *dtb = [[NSDate alloc] init];
//
//    dta = [dateformater dateFromString:aDate];
//    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //        相等
        aa=0;
        
        
    }else if (result==NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else
    {
        //bDate比aDate小
        aa=-1;
        
    }
    
    return aa;
}
- (void)fetchSearchKeywords:(NSString *)keywords{
     
    if (keywords.length == 0 || [[NSString stringWithFormat:@"%d",[keywords characterAtIndex:0]] isEqualToString:@" "]) {
        
        
         self.cellViewModels = [self.tempCellViewModels copy];
       
        
    }
    else{
        
        
        NSMutableArray <JKFilmCollectionViewCellVM*>*cellViewModels = [NSMutableArray array];
        
        for (JKFilmCollectionViewCellVM *cellVM in self.tempCellViewModels) {
            
            if ([cellVM.name containsString:keywords]) {
                
                [cellViewModels addObject:cellVM];
                
            }
        }
         self.cellViewModels = [cellViewModels copy];
        
    }
}

-(void)fetchFilmCollectionViewCellVM:(JKFilmCollectionViewCellVM *)cellViewModel{
    
    [self.delegate fetchRelateWork:cellViewModel.projectId relateType:cellViewModel.type relateWorkName:cellViewModel.name];
    
    [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
    
}
@end

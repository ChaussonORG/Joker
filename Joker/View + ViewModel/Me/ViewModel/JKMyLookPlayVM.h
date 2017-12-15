//
//  JKMyLookPlayVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKMylookPlayCellVM.h"
typedef NS_ENUM(NSInteger, JKMyLookPlayType){
    JKMyLookPlayFavorited,
    JKMyLookPlayCommented,
};

typedef NS_ENUM(NSInteger, JKMyLookPlayWorkType){
    JKMyLookPlayFilm,
    JKMyLookPlayTV,
    JKMyLookPlayAnimation,
    JKMyLookPlayGame,
    JKMyLookPlayVariety,
};

@interface JKMyLookPlayVM : NSObject

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , strong ,readonly) NSArray *titleArrays;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*favouritedFilmCellVMs;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*favouritedTVCellVMs;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*favouritedGameCellVMs;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*favouritedAnimationCellVMs;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*favouritedVarietyCellVMs;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*lookedFilmCellVMs;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*lookedTVCellVMs;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*lookedGameCellVMs;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*lookedAnimationCellVMs;

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*lookedVarietyCellVMs;

@property (nonatomic , assign ,readonly) BOOL isFinishRequestMoreData;


@property (nonatomic , assign) JKMyLookPlayType type;

@property (nonatomic , assign) JKMyLookPlayWorkType workType;

- (void)requestData;

- (void)loadData;

- (void)requestMoreData;

@end

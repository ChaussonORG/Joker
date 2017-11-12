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

@property (nonatomic , strong ,readonly) NSMutableArray <JKMylookPlayCellVM *>*cellViewModels;


@property (nonatomic , assign) JKMyLookPlayType type;

@property (nonatomic , assign) JKMyLookPlayWorkType workType;

- (void)requestData;

@end

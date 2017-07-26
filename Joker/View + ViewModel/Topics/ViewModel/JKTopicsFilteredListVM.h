//
//  JKTopicsFilteredListVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/6/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKTopicListCellVM.h"
#import "JKUserManager.h"
typedef NS_ENUM(NSInteger, JKTopicSort){
    JKTopicFilm,
    JKTopicTV,
    JKTopicCartoon,
    JKTopicGame,
    JKTopicVariety,
};

@interface JKTopicsFilteredListVM : NSObject

@property (nonatomic , strong , readonly) NSMutableArray <JKTopicListCellVM *>*cellViewModels;


@property (nonatomic , assign , readonly) BOOL isFinishRequestMoreData;

@property (nonatomic , assign , readonly) JKTopicSort sort;

@property (nonatomic , assign , readonly) BOOL isLogined;

- (instancetype)initWithTopicSort:(JKTopicSort)sort;

- (void)requestData;

- (void)requestMoreData;

- (void)createTopic;

- (void)checkLogin;
@end


//
//  JKTopicsListVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKTopicListCellVM.h"

#define kHeaderHeight 210
#define kGKHeaderVisibleThreshold 44.f
typedef NS_ENUM(NSInteger, JKTopicFilter){
    JKTopicLast,
    JKTopicAttend,
};


@interface JKTopicsListVM : NSObject

@property (nonatomic , strong , readonly) NSArray *imageArr;

@property (nonatomic , strong , readonly) NSArray *imageSelectedArr;

@property (nonatomic , strong , readonly) NSArray *titlesArray;

@property (nonatomic , strong , readonly) NSMutableArray <JKTopicListCellVM *>*cellViewModels;

@property (nonatomic , strong , readonly) NSMutableArray <JKTopicListCellVM *>*attendCellViewModels;

@property (nonatomic , assign , readonly) BOOL isLogined;

@property (nonatomic , assign , readonly) float headerViewHeight;

@property (nonatomic , assign) JKTopicFilter topicFilterType;


@property (nonatomic , strong , readonly) NSArray *attentFilterTitles;

@property (nonatomic , strong , readonly) NSArray *attentFilterImages;

- (void)requestData;

- (void)changeTypeWithIndex:(NSInteger)index;

- (void)gotoTopicfilteredListWithIndex:(NSInteger)index;

- (void)createTopic;


@end

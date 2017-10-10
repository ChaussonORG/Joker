//
//  JKAnimationTimeLineVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKAnimationTimelineCellVM.h"
typedef NS_ENUM(NSInteger, JKAnimationTimeLineFilter){
    JKAnimationCurrent,
    JKAnimationFuture,
};

@interface JKAnimationTimeLineVM : NSObject

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , assign) JKAnimationTimeLineFilter type;

@property (nonatomic , strong , readonly) NSMutableArray <JKAnimationTimelineCellVM *>*cellViewModels;

@property (nonatomic , assign) BOOL isFinishRequestMoreData;

@property (nonatomic , assign) NSInteger queryPage;
- (void)requestData;
- (void)requestMoreData;
@end

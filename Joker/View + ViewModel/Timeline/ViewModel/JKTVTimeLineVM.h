//
//  JKTVTimeLineVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKTVTimelineCellVM.h"
typedef NS_ENUM(NSInteger, JKTVTimeLineFilter){
    JKTVCurrent,
    JKTVFuture,
};

@interface JKTVTimeLineVM : NSObject

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , assign) JKTVTimeLineFilter type;

@property (nonatomic , strong , readonly) NSMutableArray <JKTVTimelineCellVM *>*cellViewModels;
@property (nonatomic , assign) BOOL isFinishRequestMoreData;

@property (nonatomic , assign) NSInteger queryPage;

- (void)requestData;

- (void)requestMoreData;
@end

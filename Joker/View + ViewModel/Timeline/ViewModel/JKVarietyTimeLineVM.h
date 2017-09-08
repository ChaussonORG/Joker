//
//  JKVarietyTimeLineVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKVarietyTimelineCellVM.h"
typedef NS_ENUM(NSInteger, JKVarietyTimeLineFilter){
    JKVarietyCurrent,
    JKVarietyFuture,
};

@interface JKVarietyTimeLineVM : NSObject

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , assign) JKVarietyTimeLineFilter type;

@property (nonatomic , strong , readonly) NSMutableArray <JKVarietyTimelineCellVM *>*cellViewModels;


- (void)requestData;
@end

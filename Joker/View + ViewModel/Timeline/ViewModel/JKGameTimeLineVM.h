//
//  JKGameTimeLineVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKGameTimelineCellVM.h"
typedef NS_ENUM(NSInteger, JKGameTimeLineFilter){
    JKGameCurrent,
    JKGameFuture,
};

@interface JKGameTimeLineVM : NSObject

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , assign) JKGameTimeLineFilter type;

@property (nonatomic , strong , readonly) NSMutableArray <JKGameTimelineCellVM *>*cellViewModels;


- (void)requestData;
@end

//
//  JKTimelineListVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKFilmTimeLineController.h"
#import "JKTVTimeLineController.h"
#import "JKAnimationTimeLineController.h"
#import "JKGameTimeLineController.h"
#import "JKVarietyTimeLineController.h"
@interface JKTimelineListVM : NSObject

@property (nonatomic , strong ,readonly) NSArray *titleArrays;

@property (nonatomic , strong ,readonly) NSMutableArray *controllerArrays;

@end

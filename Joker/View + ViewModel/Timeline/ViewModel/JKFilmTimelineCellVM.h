//
//  JKFilmTimelineCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/27.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKFilmTimeLineCollectionViewCellVM.h"
@interface JKFilmTimelineCellVM : NSObject

@property (nonatomic , assign) BOOL isRecommend;

@property (nonatomic , strong) NSString *date;

@property (nonatomic , strong) NSMutableArray *recommendArr;

@property (nonatomic , strong) NSMutableArray <JKFilmTimeLineCollectionViewCellVM *>*cellViewModels;



@property (nonatomic , assign) float recommendViewHeight;

@property (nonatomic , assign) float collectionViewHeight;

@property (nonatomic , assign) float cellHeight;



- (void)gotoDetailWithWorkId:(NSString *)workId;

@end
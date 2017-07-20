//
//  JKTopicRelatedWorksListVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKFilmCollectionViewCellVM.h"
@protocol FetchRelateWorkDelegate <NSObject>

- (void)fetchRelateWork:(NSString *)workId relateType:(NSString *)type relateWorkName:(NSString *)name;

@end
@interface JKTopicRelatedWorksListVM : NSObject
@property (nonatomic , weak) id<FetchRelateWorkDelegate>delegate;

@property (nonatomic , strong) NSMutableArray <JKFilmCollectionViewCellVM*>*cellViewModels;

- (void)reloadData;

- (void)fetchSearchKeywords:(NSString *)keywords;

@end

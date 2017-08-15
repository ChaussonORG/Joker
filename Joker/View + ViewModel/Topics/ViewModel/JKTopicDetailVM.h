//
//  JKTopicDetailVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKCommentListCellVM.h"
#import "JKTopicDetailBottomVM.h"

@protocol ScrollTableViewDelegate <NSObject>

- (void)scrollsToTop;

- (void)scrollsToRowsIndex:(NSInteger)index;

@end
@interface JKTopicDetailVM : NSObject

@property (nonatomic , strong ,readonly) NSString *topicId;

@property (nonatomic , strong) NSMutableArray <JKCommentListCellVM *>*cellVMs;

@property (nonatomic , strong) NSMutableArray <JKCommentListCellVM *>*topCellVMs;

@property (nonatomic , strong) NSMutableArray <JKCommentListCellVM *>*bottemCellVMs;

@property (nonatomic , strong , readonly) NSString *detailHtmlStr;

@property (nonatomic , strong) JKTopicDetailBottomVM *bottomVM;

@property (nonatomic ,weak) id<ScrollTableViewDelegate>delegate;


- (instancetype)initWithTopicId:(NSString *)topicId;


- (void)requestData;

- (void)requestMoreData;
@end

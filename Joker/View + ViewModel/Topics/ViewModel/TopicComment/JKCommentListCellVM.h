//
//  JKCommentListCellVM.h
//  JKCommentTableView
//
//  Created by 朱彦君 on 2017/6/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKSubcommentListCellVM.h"

@protocol refreshSuperTableViewDelegate <NSObject>

- (void)refresh;

@end


@interface JKCommentListCellVM : NSObject

@property (nonatomic , strong) NSString *headerUrl;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *time;

@property (nonatomic , strong) NSString *floorCount;

@property (nonatomic , strong) NSString *content;

@property (nonatomic , assign) float nameLabelWeight;

@property (nonatomic , assign) float contentLabelHeight;

@property (nonatomic , assign) float cellHeight;

@property (nonatomic , assign) float subTableViewHeight;

@property (nonatomic , assign) float tempSubTableViewHeight;

@property (nonatomic , assign) BOOL isSpread;

@property (nonatomic , strong) NSMutableArray <JKSubcommentListCellVM *>*cellViewModels;

@property (nonatomic , strong) NSString *likeCount;

@property (nonatomic , strong) NSString *disgustCount;

@property (nonatomic , strong) NSString *topicReplayId;
@property (nonatomic , weak) id<refreshSuperTableViewDelegate>delegate;


@property (nonatomic , strong) NSString *quoteFloor;

@property (nonatomic , strong) NSString *quoteAutor;

@property (nonatomic , strong) NSString *quoteContent;

@property (nonatomic , assign) float quoteFloorLabelWidth;

@property (nonatomic , assign) float quoteAutorLabelWidth;

@property (nonatomic , assign) float quoteContentLabelHeight;

@property (nonatomic , assign) float quoteViewHeight;




- (instancetype)initWithTopicReplayId:(NSString *)topicReplayId;

- (void)requestData;
@end

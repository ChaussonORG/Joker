//
//  JKCommentListCellVM.h
//  JKCommentTableView
//
//  Created by 朱彦君 on 2017/6/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKSubcommentListCellVM.h"

typedef NS_ENUM(NSInteger, JKCommentStatus){
    JKCommentZan,
    JKCommentCai,
    JKCommentWeipinglun,
};


@protocol refreshSuperTableViewDelegate <NSObject>

- (void)refreshSuperTableView;

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

@property (nonatomic , strong) NSString *topicId;


@property (nonatomic , weak) id<refreshSuperTableViewDelegate>delegate;


@property (nonatomic , strong) NSString *quoteFloor;

@property (nonatomic , strong) NSString *quoteAutor;

@property (nonatomic , strong) NSString *quoteContent;

@property (nonatomic , assign) float quoteFloorLabelWidth;

@property (nonatomic , assign) float quoteAutorLabelWidth;

@property (nonatomic , assign) float quoteContentLabelHeight;

@property (nonatomic , assign) float quoteViewHeight;

@property (nonatomic , assign) JKCommentStatus commentStatus;

@property  (nonatomic , assign) BOOL isMyComment;

- (instancetype)initWithTopicReplayId:(NSString *)topicReplayId;
 

- (void)favouriteComment;

- (void)criticismComment;

- (void)turnComment;

- (void)deleteComment;

- (void)replyComment;

//赞后踩
- (void)favouriteAfterCai;


//踩后赞
- (void)criticismAfterZan;
@end

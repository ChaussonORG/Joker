//
//  JKWorkCommentListCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JKWorkCommentStatus){
    JKWorkCommentZan,
    JKWorkCommentCai,
    JKWorkCommentWeipinglun,
};


@protocol WorkrefreshSuperTableViewDelegate <NSObject>

- (void)refreshSuperTableView;

@end


@interface JKWorkCommentListCellVM : NSObject

@property (nonatomic , strong) NSString *headerUrl;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *time;

@property (nonatomic , strong) NSString *score;

@property (nonatomic , strong) NSString *floorCount;

@property (nonatomic , strong) NSString *content;

@property (nonatomic , assign) float nameLabelWeight;

@property (nonatomic , assign) float contentLabelHeight;

@property (nonatomic , assign) float cellHeight;

@property (nonatomic , assign) float subTableViewHeight;

@property (nonatomic , assign) float tempSubTableViewHeight;

@property (nonatomic , assign) BOOL isSpread;



@property (nonatomic , strong) NSString *likeCount;

@property (nonatomic , strong) NSString *disgustCount;

@property (nonatomic , strong) NSString *extId;

@property (nonatomic , strong) NSString *topicId;


@property (nonatomic , weak) id<WorkrefreshSuperTableViewDelegate>delegate;


@property (nonatomic , strong) NSString *quoteFloor;

@property (nonatomic , strong) NSString *quoteAutor;

@property (nonatomic , strong) NSString *quoteContent;

@property (nonatomic , assign) float quoteFloorLabelWidth;

@property (nonatomic , assign) float quoteAutorLabelWidth;

@property (nonatomic , assign) float quoteContentLabelHeight;

@property (nonatomic , assign) float quoteViewHeight;

@property (nonatomic , assign) JKWorkCommentStatus commentStatus;

@property  (nonatomic , assign) BOOL isMyComment;

- (instancetype)initWithWorkId:(NSString *)WorkId;


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

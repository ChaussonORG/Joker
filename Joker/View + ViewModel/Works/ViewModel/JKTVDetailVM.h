//
//  JKTVDetailVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/10.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKFilmStaffCellVM.h"
#import "JKWorkCommentListCellVM.h"
#import "JKTopicListCellVM.h"

typedef NS_ENUM(NSInteger, JKTVDataFilter){
    JKTVDataInfo,
    JKTVDataComment,
    JKTVDataTopic,
};


@protocol TVrefreshTableViewDelegate <NSObject>

- (void)tableViewReload;

@end

@interface JKTVDetailVM : NSObject
@property (nonatomic , weak) id<TVrefreshTableViewDelegate>delegate;

@property (nonatomic , assign) JKTVDataFilter filterType;

@property (nonatomic , strong , readonly) NSString *workId;

@property (nonatomic , strong , readonly) NSArray *titlesArray;


@property (nonatomic , strong) NSString *workImage;

@property (nonatomic , strong) NSString *workBgImage;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *strOne;

@property (nonatomic , strong) NSString *strTwo;

@property (nonatomic , strong) NSString *strThree;

@property (nonatomic , strong) NSString *jokerScore;

@property (nonatomic , strong) NSString *score1;

@property (nonatomic , strong) NSString *score2;

@property (nonatomic , strong) NSString *score3;

@property (nonatomic , strong) NSString *score4;

@property (nonatomic , strong) NSMutableArray <JKFilmStaffCellVM*>*directorsArr;

@property (nonatomic , strong) NSString *desc;

@property (nonatomic , strong) NSArray *imageArrs;


@property (nonatomic , strong) NSMutableArray <JKWorkCommentListCellVM *>*commentCellVMs;
@property (nonatomic , strong) NSMutableArray <JKWorkCommentListCellVM *>*topCellVMs;

@property (nonatomic , strong) NSMutableArray <JKWorkCommentListCellVM *>*bottemCellVMs;

@property (nonatomic , strong) NSMutableArray <JKWorkCommentListCellVM *>*myCellVMs;

@property (nonatomic , strong) NSMutableArray <JKTopicListCellVM *>*topicCellVMs;

@property (nonatomic , assign , readonly) BOOL isLogined;

@property (nonatomic , strong) NSString *favoritedSize;

@property (nonatomic , strong) NSString *commentSize;

@property (nonatomic , assign) BOOL isfavorited;

@property (nonatomic , readonly, getter = isClear ) BOOL clear;

@property (nonatomic , assign) float directorsCellHeight;

@property (nonatomic , assign) float descCellHeight;

@property (nonatomic , assign) float imagesCellHeight;


- (instancetype)init __unavailable;

- (instancetype)initWithWorkId:(NSString *)workId;



- (void)requestData;

- (void)requestMoreData;

- (void)checkLogin;

- (void)favoriteWork;

- (void)commentWork;

- (void)createTopic;

- (void)clear;

@end

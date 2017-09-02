//
//  JKTopicsListApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/6/21.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKTopicListModel.h"
@interface JKTopicsListApi : JKCommonApi


@property (nonatomic , strong ,readonly) JKTopicListModel *model;

@property (nonatomic , strong ,readonly) NSString *projectType;

@property (nonatomic , strong) NSString *projectId;

@property (nonatomic , assign) BOOL favorite;

@property (nonatomic , assign) BOOL querySelf;


- (instancetype)initTopicFilm;

- (instancetype)initTopicTV;

- (instancetype)initTopicCartoon;

- (instancetype)initTopicGame;

- (instancetype)initTopicVariety;
@end

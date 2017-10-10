//
//  JKTimelineListApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKTimelineFilmModel.h"
@interface JKTimelineListApi : JKCommonApi


@property (nonatomic , strong ,readonly) JKTimelineFilmModel *model;

@property (nonatomic , strong ,readonly) NSString *axisType;

//@property (nonatomic , strong) NSString *startDate;
//
//@property (nonatomic , strong) NSString *endDate;

@property (nonatomic , strong) NSString* sortOrder;

@property (nonatomic , strong) NSString *queryType;

@property (nonatomic , assign) NSInteger queryPage;


- (instancetype)initTimelineFilm;

- (instancetype)initTimelineTV;

- (instancetype)initTimelineCartoon;

- (instancetype)initTimelineGame;

- (instancetype)initTimelineVariety;
@end

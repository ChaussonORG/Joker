//
//  JKGameDetailApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/13.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKFilmDetailModel.h"
@interface JKGameDetailApi : JKCommonApi

@property (nonatomic , strong , readonly) JKFilmDetailModel *model;

@property (nonatomic , strong ,readonly) NSString *workId;

- (instancetype)initWithWorkId:(NSString *)workId;


@end

//
//  JKWorkCommentApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKWorkCommentModel.h"
@interface JKWorkCommentApi : JKCommonApi

@property (nonatomic , strong) NSString *extId;

@property (nonatomic , strong) NSString *commentType;

@property (nonatomic , strong) JKWorkCommentModel *model;
- (instancetype)initWithWorkId:(NSString *)workId;
@end

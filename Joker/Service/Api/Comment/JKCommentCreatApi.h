//
//  JKCommentCreatApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKCommentCreatModel.h"
@interface JKCommentCreatApi : JKCommonApi

@property (nonatomic , strong , readonly) JKCommentCreatModel *creatModel;
- (instancetype)init __unavailable;

- (instancetype)initWithCommentCreatModel:(JKCommentCreatModel *)model;

@end

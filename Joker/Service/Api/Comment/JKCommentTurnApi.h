//
//  JKCommentTurnApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKCommentTurnModel.h"
@interface JKCommentTurnApi : JKCommonApi
@property (nonatomic , strong , readonly) JKCommentTurnModel *commentTurnModel;


- (instancetype)init __unavailable;

- (instancetype)initWithCommentTurnModel:(JKCommentTurnModel *)commentTurnModel;
@end

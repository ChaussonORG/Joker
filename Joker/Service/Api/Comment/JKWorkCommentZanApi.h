//
//  JKWorkCommentZanApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKWorkCommentZanApi : JKCommonApi
@property (nonatomic , strong , readonly) NSString *extId;


- (instancetype)init __unavailable;

- (instancetype)initWithExtId:(NSString *)extId;
@end

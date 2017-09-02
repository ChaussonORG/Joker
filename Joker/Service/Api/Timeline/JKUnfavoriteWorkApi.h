//
//  JKUnfavoriteWorkApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"

@interface JKUnfavoriteWorkApi : JKCommonApi
 

@property (nonatomic , strong ,readonly) NSString *targetId;

@property (nonatomic , strong) NSString *type;


- (instancetype)initWithWorkId:(NSString *)workId;



@end

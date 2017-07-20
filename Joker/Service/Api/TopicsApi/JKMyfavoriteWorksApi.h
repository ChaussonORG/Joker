//
//  JKMyfavoriteWorksApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKMyfavoriteWorksModel.h"
@interface JKMyfavoriteWorksApi : JKCommonApi
@property (nonatomic , strong ,readonly) JKMyfavoriteWorksModel *model;


@property (nonatomic , strong) NSString *type;
@end

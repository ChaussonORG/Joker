//
//  JKMyLookPlayFavouriteApi.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/11.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommonApi.h"
#import "JKMyLookPlayModel.h"
@interface JKMyLookPlayFavouriteApi : JKCommonApi

@property (nonatomic , strong ,readonly) JKMyLookPlayModel *model;

@property (nonatomic , strong) NSString *type;


@end

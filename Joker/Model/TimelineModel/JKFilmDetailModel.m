//
//  JKFilmDetailModel.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKFilmDetailModel.h"

@implementation JKVarietyDetailModelImage



@end

@implementation JKVarietyDetailModelHostList



@end

@implementation JKVarietyDetailModelAreaList



@end


@implementation JKGameDetailModelLanguage

@end

@implementation JKGameDetailModelType

@end


@implementation JKFilmDetailModelStaff

@end

@implementation JKFilmDetailModelData

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"desc"}];
}
@end

@implementation JKFilmDetailModel

@end

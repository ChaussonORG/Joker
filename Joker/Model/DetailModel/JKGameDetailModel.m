//
//  JKGameDetailModel.m
//  joker
//
//  Created by Chausson on 2017/1/15.
//  Copyright © 2017年 chausson. All rights reserved.
//

#import "JKGameDetailModel.h"

@implementation JKGameDetailModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"desc": @"description",
                                                                  }];
}
@end
@implementation JKGameModel


@end

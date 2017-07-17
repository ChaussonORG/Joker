//
//  JKDetailModel.m
//  joker
//
//  Created by 郭金涛 on 16/11/19.
//  Copyright © 2016年 chausson. All rights reserved.
//

#import "JKDetailModel.h"
@implementation JKStaffModel

@end
@implementation JKDetailContent
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"desc": @"description",
                                                                  }];
}
@end

@implementation JKDetailModel

@end

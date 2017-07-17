//
//  JKCommentList.m
//  joker
//
//  Created by Chausson on 2016/12/29.
//  Copyright © 2016年 chausson. All rights reserved.
//

#import "JKCommentList.h"

@implementation JKCommentList

@end
@implementation JKCommentData


@end
@implementation JKCommentDetail


@end
@implementation JKCommentModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"identifier": @"id",
                                                                  @"nickName": @"appUser.nickname",
                                                                  @"icon": @"appUser.photo"
                                                                  }];
}

@end

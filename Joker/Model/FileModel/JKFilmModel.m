//
//  JKFilmModel.m
//  joker
//
//  Created by Chausson on 16/11/18.
//  Copyright © 2016年 chausson. All rights reserved.
//

#import "JKFilmModel.h"

@implementation JKFilmModel

@end
@implementation JKFilmContent
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"currentCount"])
        return YES;
    
    return NO;
}
@end
@implementation JKDateClassModel

@end
@implementation JKFilmListModel

@end

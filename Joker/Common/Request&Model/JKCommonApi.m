//
//  HHTCommonApi.m
//  Shipping
//
//  Created by 朱彦君 on 2016/12/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "JKCommonApi.h"

@implementation JKCommonApi
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.requestModel = [[JKCommonRequestModel alloc]init];
        
        self.responseModel = [[JKCommonResponseModel alloc]init];
    }
    return self;
}
@end

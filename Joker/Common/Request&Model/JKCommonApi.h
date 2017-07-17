//
//  HHTCommonApi.h
//  Shipping
//
//  Created by 朱彦君 on 2016/12/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <CHNetworking/CHNetworking.h>
#import "JKCommonModel.h"
@interface JKCommonApi : CHNetRequest

@property (nonatomic , strong) JKCommonRequestModel *requestModel;

@property (nonatomic , strong) JKCommonResponseModel *responseModel;

@property (nonatomic , strong) NSError *error;

@end

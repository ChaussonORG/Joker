//
//  HHTCommonModel.h
//  Shipping
//
//  Created by 朱彦君 on 2016/12/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JKCommonRequestModel : JSONModel

@property (nonatomic , assign) NSInteger offset;

@property (nonatomic , assign) NSInteger page;

@property (nonatomic , assign) NSInteger limit;

@end


@interface JKCommonResponseModel : JSONModel

@property (nonatomic , assign) int code;

@property (nonatomic , strong) NSString <Optional>*message;

@end

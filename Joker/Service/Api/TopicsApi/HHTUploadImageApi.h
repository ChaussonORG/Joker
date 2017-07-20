//
//  TOYBuyUploadImageApi.h
//  ToyMan
//
//  Created by 郭金涛 on 16/9/9.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <CHNetworking/CHNetworking.h>

#import "SDBaseResponse.h"

@interface HHTUploadImageApi : CHNetRequest
+ (instancetype)new __unavailable;
- (instancetype)init  __unavailable;
- (instancetype)initWithImage:(UIImage *)image
                    imageName:(NSString *)imageName
                     fileName:(NSString *)fileName;

@property (nonatomic ,readonly ) SDBaseResponse *baseResponse;

@property (nonatomic ,readonly) NSString *imageName;

@property (nonatomic ,readonly) NSString *fileName;

@end

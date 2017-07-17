//
//  BaseModel.h
//  joker
//
//  Created by 肖松 on 15-10-5.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#import "JSONModel.h"

@interface BaseModel : JSONModel
@property (strong ,nonatomic) NSString* message;
@property (assign ,nonatomic) int status;
@property (assign ,nonatomic) int errorCode;
@end

@interface JKBaseModel : JSONModel
@property (strong ,nonatomic) NSString* code;
@property (strong ,nonatomic) NSString* message;
@end

//
//  ClassifyModel.h
//  joker
//
//  Created by 肖松 on 15-6-25.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#import "JSONModel.h"
@interface ClassifyData: JSONModel
@property (strong ,nonatomic) NSString<Optional>* mouth;
@property (strong ,nonatomic) NSString<Optional>* day;
@property (strong ,nonatomic) NSString<Optional>* url;
@property (strong ,nonatomic) NSString<Optional>* img;
@property (strong ,nonatomic) NSString<Optional>* topic;
@property (strong ,nonatomic) NSString<Optional>* content;
@end
@interface ClassifyModel : JSONModel
@property (strong ,nonatomic) ClassifyData* data;
@property (strong ,nonatomic) NSString* message;
@property (assign ,nonatomic) int status;
@property (assign ,nonatomic) int errcode;
@end

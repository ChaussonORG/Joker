//
//  UserInfoModel.h
//  joker
//
//  Created by 肖松 on 15-8-25.
//  Copyright (c) 2015年 chausson. All rights reserved.
//
#import "JSONModel.h"
@interface UserInfoData : JSONModel
//@property (strong ,nonatomic) NSArray *favourIds;
@property (strong ,nonatomic) NSString<Optional> *nickname;
@property (strong ,nonatomic) NSString<Optional> *account;
@property (strong ,nonatomic) NSString<Optional> *photo;
@property (strong ,nonatomic) NSString<Optional> *userId;
@property (strong ,nonatomic) NSString<Optional> *birthday;
@property (strong ,nonatomic) NSString<Optional> *sex;
@property (strong ,nonatomic) NSString<Optional> *createtime;
@property (strong ,nonatomic) NSString<Optional> *token;
@end
@interface UserData : JSONModel
@property (strong ,nonatomic) UserInfoData<Optional>*profile;
@property (strong ,nonatomic) NSString<Optional> *token;
@end
@interface UserInfoModel : JSONModel
@property (strong ,nonatomic) UserData<Optional> *data;
@property (strong ,nonatomic) NSString *message;
@property (assign ,nonatomic) int status;
@property (assign ,nonatomic) int errorCode;

@end

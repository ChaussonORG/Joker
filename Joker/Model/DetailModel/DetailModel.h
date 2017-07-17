//
//  DetailModel.h
//  joker
//
//  Created by 肖松 on 15-8-17.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#import "JSONModel.h"
@class CommentModel;
@class PersonModel;
@class PersonInfo;
@protocol CommentModel <NSObject>@end
@protocol PersonModel <NSObject>@end
@protocol PersonInfo <NSObject>@end
@interface CommentModel : JSONModel
@property (strong ,nonatomic)NSString <Optional>*name;
@property (strong ,nonatomic)NSString <Optional>*icon;
@property (strong ,nonatomic)NSString <Optional>*content;
@property (strong ,nonatomic)NSString <Optional>*comtentId;
@property (strong ,nonatomic)NSString <Optional>*favourNumber;
@property (strong ,nonatomic)NSString <Optional>*unfavourNumber;
@property (strong ,nonatomic)NSString <Optional>*score;
- (instancetype )initWithTest;
@end
@interface CommentListStatus : JSONModel
@property (strong ,nonatomic) NSArray  <Optional,CommentModel>*data;
@property (strong ,nonatomic) NSString <Optional>*message;
@property (assign ,nonatomic) int status;
@property (assign ,nonatomic) int errorCode;
- (instancetype )initWithTest;
@end
@interface PersonInfo : JSONModel
@property (strong ,nonatomic)NSString <Optional>*personName;
@property (strong ,nonatomic)NSString <Optional>*personIcon;
@property (strong ,nonatomic)NSString <Optional>*personId;
@end
@interface PersonModel : JSONModel
@property (strong ,nonatomic)NSString <Optional>*personPosition;
@property (strong ,nonatomic)NSArray  <Optional,PersonInfo>*personInfo;
@end
@interface DetailContent : JSONModel
@property (strong ,nonatomic)NSMutableArray <Optional,PersonModel>*personArray;
@property (strong ,nonatomic)NSArray <Optional>*posterImages;
@property (strong ,nonatomic)NSArray <Optional>*scores;
@property (strong ,nonatomic)NSString <Optional>*number;
@property (strong ,nonatomic)NSString <Optional>*classify;
@property (strong ,nonatomic)NSString <Optional>*country;
@property (strong ,nonatomic)NSString <Optional>*showDate;
@property (assign ,nonatomic)BOOL favourFlag;
//@property (assign ,nonatomic)NSString *favour;
- (instancetype )initWithTest;
@end

@interface DetailModel : JSONModel
@property (strong ,nonatomic) DetailContent *data;
@property (strong ,nonatomic) NSString *message;
@property (assign ,nonatomic) int status;
@property (assign ,nonatomic) int errorCode;
@end

//
//  JKFilmModel.h
//  joker
//
//  Created by Chausson on 16/11/18.
//  Copyright © 2016年 chausson. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class JKDateClassModel;
@protocol JKDateClassModel <NSObject>@end
@class JKFilmContent;
@protocol JKFilmContent <NSObject>
@end
@class JKFilmListModel;
@protocol JKFilmListModel <NSObject>
@end
@interface JKFilmContent : JSONModel
@property (strong ,nonatomic)NSString <Optional>*coverImage;
@property (assign ,nonatomic)float totalScore;
@property (assign ,nonatomic)float doubanScore;
@property (assign ,nonatomic)NSInteger currentCount;
@property (assign ,nonatomic)float tomatoScore;
@property (strong ,nonatomic)NSString <Optional>*versionName;
@property (strong ,nonatomic)NSString <Optional>*name;
@property (strong ,nonatomic)NSString <Optional>*belongType;
@property (copy ,nonatomic)NSString <Optional>*gamePlatform;
@property (assign ,nonatomic)NSNumber <Optional>*id;

@end
@interface JKDateClassModel : JSONModel
@property (strong ,nonatomic)NSArray<Optional,JKFilmContent> *items;
@property (strong ,nonatomic)NSString<Optional> *date;
@property (strong ,nonatomic)NSString<Optional> *month;
@property (strong ,nonatomic)NSString<Optional> *day;
@end

@interface JKFilmListModel : JSONModel
@property (strong ,nonatomic) NSArray<Optional,JKDateClassModel>*items;
@end
@interface JKFilmModel : JSONModel
@property (strong ,nonatomic) JKFilmListModel* data;
@property (strong ,nonatomic) NSString *message;
@property (assign ,nonatomic) NSString *code;

@end

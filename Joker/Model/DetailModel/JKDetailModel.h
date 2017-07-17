//
//  JKDetailModel.h
//  joker
//
//  Created by 郭金涛 on 16/11/19.
//  Copyright © 2016年 chausson. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class JKStaffModel;
@protocol JKStaffModel <NSObject>

@end
@interface JKStaffModel : JSONModel
@property (strong ,nonatomic) NSString <Optional>*img;
@property (assign ,nonatomic) NSInteger personId;
@property (strong ,nonatomic) NSString <Optional>*name;
@property (strong ,nonatomic) NSString <Optional>*actName;
@property (strong ,nonatomic) NSString <Optional>*degree;
//@property (assign ,nonatomic) NSInteger type;

@end

@interface JKDetailContent : JSONModel
@property (assign ,nonatomic) BOOL favorited;
@property (assign ,nonatomic) float jokerScore;
@property (assign ,nonatomic) float doubanScore;
@property (assign ,nonatomic) float tomatoeScore;
@property (assign ,nonatomic) float imdbScore;
@property (assign ,nonatomic) float totalScore;
@property (strong ,nonatomic) NSNumber <Optional>*animation_now_nb;//动漫播出当前集数
@property (assign ,nonatomic) NSInteger favoritedSize;
@property (strong ,nonatomic) NSString <Optional>*name;
@property (strong ,nonatomic) NSString <Optional>*count;
@property (strong ,nonatomic) NSString <Optional>*broadcast_platform;// 播出平台
@property (strong ,nonatomic) NSString <Optional>*coverImage;
@property (strong ,nonatomic) NSString <Optional>*release_date_global;//动漫的时间
@property (strong ,nonatomic) NSArray <Optional>*leixing;
@property (strong ,nonatomic) NSArray <Optional>*types;
@property (strong ,nonatomic) NSArray <Optional,JKStaffModel>*staff;
@property (strong ,nonatomic) NSArray <Optional>*languages;
@property (strong ,nonatomic) NSString <Optional>*releaseDate;
@property (strong ,nonatomic) NSArray <Optional>*areas;
@property (strong ,nonatomic) NSArray <Optional>*coverImageList;
@property (strong ,nonatomic) NSString <Optional>*duration;
@property (strong ,nonatomic) NSString <Optional>*desc;

@end
@interface JKDetailModel : JSONModel
@property (strong ,nonatomic) JKDetailContent <Optional>*data;
@property (strong ,nonatomic) NSString <Optional>*message;
@property (assign ,nonatomic) int code;
@end

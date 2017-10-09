//
//  JKFilmDetailModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>




@class JKVarietyDetailModelImage;
@protocol JKVarietyDetailModelImage <NSObject>
@end
@interface JKVarietyDetailModelImage : JSONModel

@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*url;
@end

@class JKVarietyDetailModelHostList;
@protocol JKVarietyDetailModelHostList <NSObject>
@end
@interface JKVarietyDetailModelHostList : JSONModel

@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*english_name;
@property (nonatomic, strong)NSString <Optional>*other_name;
@property (nonatomic, strong)NSString <Optional>*gender;
@property (nonatomic, strong)NSString <Optional>*nationality;
@property (nonatomic, strong)NSString <Optional>*birthday;
@property (nonatomic, strong)NSString <Optional>*birthplace;
@property (nonatomic, strong)NSString <Optional>*bloodType;
@property (nonatomic, strong)NSString <Optional>*age;
@property (nonatomic, strong)NSString <Optional>*height;
@property (nonatomic, strong)NSString <Optional>*constellation;
@property (nonatomic, strong)NSString <Optional>*introduction;
@property (nonatomic, strong)NSString <Optional>*country;
@property (nonatomic, strong)NSString <Optional>*death_date;
@property (nonatomic, strong)NSString <Optional>*reward;
@property (nonatomic, strong)NSString <Optional>*professionName;
@property (nonatomic, strong)NSString <Optional>*honorId;
@property (nonatomic, strong)NSString <Optional>*honorName;
@property (nonatomic, strong)NSString <Optional>*images;
@property (nonatomic, strong)NSString <Optional>*professions;
@property (nonatomic, strong)NSString <Optional>*img;
@property (nonatomic, strong)NSString <Optional>*actorName;
@property (nonatomic, strong)NSString <Optional>*professionId;
@property (nonatomic, strong)NSString <Optional>*ralationId;
@end

@class JKVarietyDetailModelAreaList;
@protocol JKVarietyDetailModelAreaList <NSObject>
@end
@interface JKVarietyDetailModelAreaList : JSONModel

@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*ralationId;
@end

@class JKGameDetailModelLanguage;
@protocol JKGameDetailModelLanguage <NSObject>
@end
@interface JKGameDetailModelLanguage : JSONModel

@property (nonatomic, strong)NSString <Optional>*createTime;
@property (nonatomic, strong)NSString <Optional>*lastUpdate;
@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*category;
@property (nonatomic, strong)NSString <Optional>*ralationId;
@end

@class JKGameDetailModelType;
@protocol JKGameDetailModelType <NSObject>
@end
@interface JKGameDetailModelType : JSONModel

@property (nonatomic, strong)NSString <Optional>*createTime;
@property (nonatomic, strong)NSString <Optional>*lastUpdate;
@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*category;
@property (nonatomic, strong)NSString <Optional>*ralationId;
@end


@class JKFilmDetailModelStaff;
@protocol JKFilmDetailModelStaff <NSObject>
@end
@interface JKFilmDetailModelStaff : JSONModel

@property (nonatomic, strong)NSString <Optional>*personId;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*degree;
@property (nonatomic, strong)NSString <Optional>*actName;
@property (nonatomic, strong)NSString <Optional>*img;
@end


 
@interface JKFilmDetailModelData : JSONModel
@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*coverImage;
@property (nonatomic, strong)NSArray <Optional>*coverImageList;
@property (nonatomic, strong)NSArray <Optional>*areas;
@property (nonatomic, strong)NSArray <Optional>*types;
@property (nonatomic, strong)NSArray <Optional>*leixing;
@property (nonatomic, strong)NSString <Optional>*duration;
@property (nonatomic, strong)NSArray <Optional>*languages;
@property (nonatomic, strong)NSString <Optional>*releaseDate;
@property (nonatomic, strong)NSArray <Optional, JKFilmDetailModelStaff>*staff;
@property (nonatomic, strong)NSString <Optional>*jokerScore;
@property (nonatomic, strong)NSString <Optional>*doubanScore;
@property (nonatomic, strong)NSString <Optional>*mcScore;
@property (nonatomic, strong)NSString <Optional>*imdbScore;
@property (nonatomic, strong)NSString <Optional>*tomatoeScore;
@property (nonatomic, strong)NSString <Optional>*totalScore;
@property (nonatomic, strong)NSString <Optional>*desc;
@property (nonatomic, strong)NSString <Optional>*favoritedSize;
@property (nonatomic, strong)NSString <Optional>*commentSize;
@property (nonatomic, strong)NSString <Optional>*favorited;
@property (nonatomic, strong)NSString <Optional>*count;

@property (nonatomic, strong)NSString <Optional>*animation_counts;
@property (nonatomic, strong)NSString <Optional>*release_date_global;
@property (nonatomic, strong)NSString <Optional>*game_platform;
@property (nonatomic, strong)NSArray <Optional, JKGameDetailModelType>*gameType;
@property (nonatomic, strong)NSArray <Optional, JKGameDetailModelLanguage>*gameLanguage;
@property (nonatomic, strong)NSString <Optional>*favotiteCount;

@property (nonatomic, strong)NSArray <Optional, JKVarietyDetailModelAreaList>*areaList;
@property (nonatomic, strong)NSArray <Optional, JKVarietyDetailModelHostList>*hostList;
@property (nonatomic, strong)NSArray <Optional, JKVarietyDetailModelHostList>*guestList;
@property (nonatomic, strong)NSArray <Optional, JKVarietyDetailModelImage>*imageList;
@property (nonatomic, strong)NSString <Optional>*platform;

@property (nonatomic, strong)NSString <Optional>*introduce;

@property (nonatomic, strong)NSString <Optional>*coverImg;

@property (nonatomic, strong)NSString <Optional>*openDate;

@property (nonatomic, strong)NSArray <Optional, JKVarietyDetailModelImage>*gameImage;

@property (nonatomic, strong)NSString <Optional>*ign_score;
@property (nonatomic, strong)NSString <Optional>*gs_score;
@property (nonatomic, strong)NSString <Optional>*fami_score;
@property (nonatomic, strong)NSString <Optional>*mc_score;
@end


@interface JKFilmDetailModel : JSONModel
@property (strong ,nonatomic) JKFilmDetailModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

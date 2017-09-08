//
//  JKTimelineFilmModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/24.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@class JKTimelineFilmModelMainActor;
@protocol JKTimelineFilmModelMainActor <NSObject>
@end



@interface JKTimelineFilmModelMainActor : JSONModel
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


@class JKTimelineFilmModelDirector;
@protocol JKTimelineFilmModelDirector <NSObject>
@end



@interface JKTimelineFilmModelDirector : JSONModel
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


@class JKTimelineFilmModelItems;
@protocol JKTimelineFilmModelItems <NSObject>
@end

@interface JKTimelineFilmModelItems : JSONModel
@property (nonatomic, strong)NSString <Optional>*openDate;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*coverImgUrl;
@property (nonatomic, strong)NSString <Optional>*extId;
@property (nonatomic, strong)NSString <Optional>*collectQuantity;
@property (nonatomic, strong)NSString <Optional>*favotite;
@property (nonatomic, strong)NSString <Optional>*recommend;
@property (nonatomic, strong)NSString <Optional>*jokerScore;
@property (nonatomic, strong)NSString <Optional>*doubanScore;
@property (nonatomic, strong)NSString <Optional>*imdbScore;
@property (nonatomic, strong)NSString <Optional>*tomatoeScore;
@property (nonatomic, strong)NSString <Optional>*mcScore;
@property (nonatomic, strong)NSString <Optional>*belongType;
@property (nonatomic, strong)NSString <Optional>*fami_score;
@property (nonatomic, strong)NSString <Optional>*ign_score;
@property (nonatomic, strong)NSString <Optional>*gs_score;
@property (nonatomic, strong)NSString <Optional>*joker_score;
@property (nonatomic, strong)NSString <Optional>*mc_score;
@property (nonatomic, strong)NSString <Optional>*platform;
@property (nonatomic, strong)NSString <Optional>*version;
@property (nonatomic, strong)NSString <Optional>*language;
@property (nonatomic, strong)NSArray <Optional, JKTimelineFilmModelDirector>*director;
@property (nonatomic, strong)NSArray <Optional, JKTimelineFilmModelMainActor>*mainActor;


@property (nonatomic, strong)NSArray <Optional, JKTimelineFilmModelDirector>*supervision;
@property (nonatomic, strong)NSArray <Optional, JKTimelineFilmModelDirector>*soundActor;

@property (nonatomic, strong)NSArray <Optional, JKTimelineFilmModelDirector>*hostList;
@property (nonatomic, strong)NSArray <Optional, JKTimelineFilmModelDirector>*guestList;
@end

@interface JKTimelineFilmModelData : JSONModel
@property (nonatomic, strong)NSArray <Optional,JKTimelineFilmModelItems>*items;


@end


@interface JKTimelineFilmModel : JSONModel
@property (strong ,nonatomic) JKTimelineFilmModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

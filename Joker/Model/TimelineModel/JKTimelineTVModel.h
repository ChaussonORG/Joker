//
//  JKTimelineTVModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/29.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class JKTimelineTVModelMainActor;
@protocol JKTimelineTVModelMainActor <NSObject>
@end



@interface JKTimelineTVModelMainActor : JSONModel
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


@class JKTimelineTVModelDirector;
@protocol JKTimelineTVModelDirector <NSObject>
@end



@interface JKTimelineTVModelDirector : JSONModel
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


@class JKTimelineTVModelItems;
@protocol JKTimelineTVModelItems <NSObject>
@end

@interface JKTimelineTVModelItems : JSONModel
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
@property (nonatomic, strong)NSArray <Optional, JKTimelineTVModelDirector>*director;
@property (nonatomic, strong)NSArray <Optional, JKTimelineTVModelMainActor>*mainActor;

@end

@interface JKTimelineTVModelData : JSONModel
@property (nonatomic, strong)NSArray <Optional,JKTimelineTVModelItems>*items;


@end


@interface JKTimelineTVModel : JSONModel
@property (strong ,nonatomic) JKTimelineTVModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

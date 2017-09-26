//
//  JKMyfavoriteWorksModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JKMyfavoriteWorksModelStatus: JSONModel

@property (copy ,nonatomic) NSString <Optional>*name;
@property (copy ,nonatomic) NSString <Optional>*text;

@end

@interface JKMyfavoriteWorksModelVariety : JSONModel

@property (copy ,nonatomic) NSString <Optional>*id;
@property (copy ,nonatomic) NSString <Optional>*name;
@property (copy ,nonatomic) NSString <Optional>*english_name;
@property (copy ,nonatomic) NSString <Optional>*other_name;
@property (copy ,nonatomic) NSString <Optional>*product_company;
@property (copy ,nonatomic) NSString <Optional>*issuing_company;
@property (copy ,nonatomic) NSString <Optional>*release_date_global;
@property (copy ,nonatomic) NSString <Optional>*release_statuts;
@property (copy ,nonatomic) NSString <Optional>*animation_counts;
@property (copy ,nonatomic) NSString <Optional>*animation_now_nb;
@property (copy ,nonatomic) NSString <Optional>*broadcast_time;
@property (copy ,nonatomic) NSString <Optional>*broadcast_platform;
@property (copy ,nonatomic) NSString <Optional>*douban_score;
@property (copy ,nonatomic) NSString <Optional>*imdb_score;
@property (copy ,nonatomic) NSString <Optional>*rotten_tomatoes_score;
@property (copy ,nonatomic) NSString <Optional>*joker_score;
@property (copy ,nonatomic) NSString <Optional>*whole_network_score;
@property (copy ,nonatomic) NSString <Optional>*prevue_url;
@property (copy ,nonatomic) JKMyfavoriteWorksModelStatus <Optional>*animationStatus;
@property (copy ,nonatomic) NSString <Optional>*favotiteCount;
@property (copy ,nonatomic) NSString <Optional>*languages;
@property (copy ,nonatomic) NSString <Optional>*types;
@property (copy ,nonatomic) NSString <Optional>*areas;
@property (copy ,nonatomic) NSString <Optional>*staff;
@property (copy ,nonatomic) NSString <Optional>*releaseDate;
@property (copy ,nonatomic) NSString <Optional>*animationPrevue;
@property (copy ,nonatomic) NSString <Optional>*coverImage;
@property (copy ,nonatomic) NSString <Optional>*coverImageList;
@property (copy ,nonatomic) NSString <Optional>*favorited;
@property (copy ,nonatomic) NSString <Optional>*favoritedSize;
@property (copy ,nonatomic) NSString <Optional>*doubanScore;
@property (copy ,nonatomic) NSString <Optional>*imdbScore;
@property (copy ,nonatomic) NSString <Optional>*tomatoeScore;
@property (copy ,nonatomic) NSString <Optional>*jokerScore;
@property (copy ,nonatomic) NSString <Optional>*totalScore;
@property (copy ,nonatomic) NSString <Optional>*commentSize;
@property (copy ,nonatomic) NSString <Optional>*animatiomName;
@property (copy ,nonatomic) NSString <Optional>*animationEnglishname;
@property (copy ,nonatomic) NSString <Optional>*areaName;
@property (copy ,nonatomic) NSString <Optional>*personName;
@property (copy ,nonatomic) NSString <Optional>*typeName;
@property (copy ,nonatomic) NSString <Optional>*desc;
@property (copy ,nonatomic) NSString <Optional>*premiereDate;


@end


@interface JKMyfavoriteWorksModelAnimation : JSONModel

@property (copy ,nonatomic) NSString <Optional>*id;
@property (copy ,nonatomic) NSString <Optional>*name;
@property (copy ,nonatomic) NSString <Optional>*english_name;
@property (copy ,nonatomic) NSString <Optional>*other_name;
@property (copy ,nonatomic) NSString <Optional>*product_company;
@property (copy ,nonatomic) NSString <Optional>*issuing_company;
@property (copy ,nonatomic) NSString <Optional>*release_date_global;
@property (copy ,nonatomic) NSString <Optional>*release_statuts;
@property (copy ,nonatomic) NSString <Optional>*animation_counts;
@property (copy ,nonatomic) NSString <Optional>*animation_now_nb;
@property (copy ,nonatomic) NSString <Optional>*broadcast_time;
@property (copy ,nonatomic) NSString <Optional>*broadcast_platform;
@property (copy ,nonatomic) NSString <Optional>*douban_score;
@property (copy ,nonatomic) NSString <Optional>*imdb_score;
@property (copy ,nonatomic) NSString <Optional>*rotten_tomatoes_score;
@property (copy ,nonatomic) NSString <Optional>*joker_score;
@property (copy ,nonatomic) NSString <Optional>*whole_network_score;
@property (copy ,nonatomic) NSString <Optional>*prevue_url;
@property (copy ,nonatomic) JKMyfavoriteWorksModelStatus <Optional>*animationStatus;
@property (copy ,nonatomic) NSString <Optional>*favotiteCount;
@property (copy ,nonatomic) NSString <Optional>*languages;
@property (copy ,nonatomic) NSString <Optional>*types;
@property (copy ,nonatomic) NSString <Optional>*areas;
@property (copy ,nonatomic) NSString <Optional>*staff;
@property (copy ,nonatomic) NSString <Optional>*releaseDate;
@property (copy ,nonatomic) NSString <Optional>*animationPrevue;
@property (copy ,nonatomic) NSString <Optional>*coverImage;
@property (copy ,nonatomic) NSString <Optional>*coverImageList;
@property (copy ,nonatomic) NSString <Optional>*favorited;
@property (copy ,nonatomic) NSString <Optional>*favoritedSize;
@property (copy ,nonatomic) NSString <Optional>*doubanScore;
@property (copy ,nonatomic) NSString <Optional>*imdbScore;
@property (copy ,nonatomic) NSString <Optional>*tomatoeScore;
@property (copy ,nonatomic) NSString <Optional>*jokerScore;
@property (copy ,nonatomic) NSString <Optional>*totalScore;
@property (copy ,nonatomic) NSString <Optional>*commentSize;
@property (copy ,nonatomic) NSString <Optional>*animatiomName;
@property (copy ,nonatomic) NSString <Optional>*animationEnglishname;
@property (copy ,nonatomic) NSString <Optional>*areaName;
@property (copy ,nonatomic) NSString <Optional>*personName;
@property (copy ,nonatomic) NSString <Optional>*typeName;
@property (copy ,nonatomic) NSString <Optional>*desc;
@property (copy ,nonatomic) NSString <Optional>*premiereDate;


@end
@interface JKMyfavoriteWorksModelTV : JSONModel
@property (copy ,nonatomic) NSString <Optional>*status;
@property (copy ,nonatomic) NSString <Optional>*id;
@property (copy ,nonatomic) NSString <Optional>*name;
@property (copy ,nonatomic) NSString <Optional>*english_name;
@property (copy ,nonatomic) NSString <Optional>*other_name;
@property (copy ,nonatomic) NSString <Optional>*game_platform;
@property (copy ,nonatomic) NSString <Optional>*product_company;
@property (copy ,nonatomic) NSString <Optional>*issuing_company;
@property (copy ,nonatomic) NSString <Optional>*release_date_global;
@property (copy ,nonatomic) NSString <Optional>*release_statuts;
@property (copy ,nonatomic) NSString <Optional>*tv_counts;
@property (copy ,nonatomic) NSString <Optional>*tv_now_nb;
@property (copy ,nonatomic) NSString <Optional>*broadcast_time;
@property (copy ,nonatomic) NSString <Optional>*broadcast_platform;
@property (copy ,nonatomic) JKMyfavoriteWorksModelStatus <Optional>*tvStatus;
@property (copy ,nonatomic) NSString <Optional>*douban_score;
@property (copy ,nonatomic) NSString <Optional>*imdb_score;
@property (copy ,nonatomic) NSString <Optional>*rotten_tomatoes_score;
@property (copy ,nonatomic) NSString <Optional>*joker_score;
@property (copy ,nonatomic) NSString <Optional>*whole_network_score;
@property (copy ,nonatomic) NSString <Optional>*prevue_url;
@property (copy ,nonatomic) NSString <Optional>*doubanUrl;
@property (copy ,nonatomic) NSString <Optional>*imdbUrl;
@property (copy ,nonatomic) NSString <Optional>*tomatoeUrl;
@property (copy ,nonatomic) NSString <Optional>*belongType;
@property (copy ,nonatomic) NSString <Optional>*favotiteCount;
@property (copy ,nonatomic) NSString <Optional>*tvLanguage;
@property (copy ,nonatomic) NSString <Optional>*tvType;
@property (copy ,nonatomic) NSString <Optional>*tvLeiXing;
@property (copy ,nonatomic) NSString <Optional>*tvArea;
@property (copy ,nonatomic) NSString <Optional>*tvDirector;
@property (copy ,nonatomic) NSString <Optional>*tvScreenwriter;
@property (copy ,nonatomic) NSString <Optional>*tvMainActor;
@property (copy ,nonatomic) NSString <Optional>*tvImage;
@property (copy ,nonatomic) NSString <Optional>*areaName;
@property (copy ,nonatomic) NSString <Optional>*personName;
@property (copy ,nonatomic) NSString <Optional>*typeName;
@property (copy ,nonatomic) NSString <Optional>*tvname;
@property (copy ,nonatomic) NSString <Optional>*tvenglishName;
@property (copy ,nonatomic) NSString <Optional>*desc;
@property (copy ,nonatomic) NSString <Optional>*coverImage;
@property (copy ,nonatomic) NSString <Optional>*premiereDate;

@end

@interface JKMyfavoriteWorksModelGame : JSONModel

@property (copy ,nonatomic) NSString <Optional>*id;
@property (copy ,nonatomic) NSString <Optional>*name;
@property (copy ,nonatomic) NSString <Optional>*english_name;
@property (copy ,nonatomic) NSString <Optional>*other_name;
@property (copy ,nonatomic) NSString <Optional>*game_platform;
@property (copy ,nonatomic) NSString <Optional>*product_company;
@property (copy ,nonatomic) NSString <Optional>*issuing_company;
@property (copy ,nonatomic) NSString <Optional>*fami_score;
@property (copy ,nonatomic) NSString <Optional>*ign_score;
@property (copy ,nonatomic) NSString <Optional>*gs_score;
@property (copy ,nonatomic) NSString <Optional>*joker_score;
@property (copy ,nonatomic) NSString <Optional>*whole_network_score;
@property (copy ,nonatomic) NSString <Optional>*prevue_url;
@property (copy ,nonatomic) JKMyfavoriteWorksModelStatus <Optional>*gameStatus;
@property (copy ,nonatomic) NSString <Optional>*release_date_global;
@property (copy ,nonatomic) NSString <Optional>*favotiteCount;
@property (copy ,nonatomic) NSString <Optional>*relationLanguageIds;
@property (copy ,nonatomic) NSString <Optional>*gameLanguage;
@property (copy ,nonatomic) NSString <Optional>*gameType;
@property (copy ,nonatomic) NSString <Optional>*gameImage;
@property (copy ,nonatomic) NSString <Optional>*gameVersion;
@property (copy ,nonatomic) NSString <Optional>*commentList;
@property (copy ,nonatomic) NSString <Optional>*gameName;
@property (copy ,nonatomic) NSString <Optional>*gameEnglishName;
@property (copy ,nonatomic) NSString <Optional>*gamePlatform;
@property (copy ,nonatomic) NSString <Optional>*typeName;
@property (copy ,nonatomic) NSString <Optional>*gameLang;
@property (copy ,nonatomic) NSString <Optional>*desc;
@property (copy ,nonatomic) NSString <Optional>*coverImage;
@property (copy ,nonatomic) NSString <Optional>*premiereDate;

@end

@interface JKMyfavoriteWorksModelFilm : JSONModel

@property (copy ,nonatomic) NSString <Optional>*id;
@property (copy ,nonatomic) NSString <Optional>*name;
@property (copy ,nonatomic) NSString <Optional>*english_name;
@property (copy ,nonatomic) NSString <Optional>*other_name;
@property (copy ,nonatomic) NSString <Optional>*product_company;
@property (copy ,nonatomic) NSString <Optional>*issuing_company;
@property (copy ,nonatomic) NSString <Optional>*isrelease;
@property (copy ,nonatomic) NSString <Optional>*release_date_china;
@property (copy ,nonatomic) NSString <Optional>*release_date_global;
@property (copy ,nonatomic) NSString <Optional>*running_time;
@property (copy ,nonatomic) NSString <Optional>*desc;
@property (copy ,nonatomic) NSString <Optional>*douban_score;
@property (copy ,nonatomic) NSString <Optional>*imdb_score;
@property (copy ,nonatomic) NSString <Optional>*rotten_tomatoes_score;
@property (copy ,nonatomic) NSString <Optional>*joker_score;
@property (copy ,nonatomic) NSString <Optional>*whole_network_score;
@property (copy ,nonatomic) NSString <Optional>*prevue_url;
@property (copy ,nonatomic) NSString <Optional>*chinaOnTime;
@property (copy ,nonatomic) JKMyfavoriteWorksModelStatus <Optional>*filmStatus;
@property (copy ,nonatomic) NSString <Optional>*reward;
@property (copy ,nonatomic) NSString <Optional>*doubanUrl;
@property (copy ,nonatomic) NSString <Optional>*imdbUrl;
@property (copy ,nonatomic) NSString <Optional>*tomatoeUrl;
@property (copy ,nonatomic) NSString <Optional>*favotiteCount;
@property (copy ,nonatomic) NSString <Optional>*relationLanguageIds;
@property (copy ,nonatomic) NSString <Optional>*relationAreaIds;
@property (copy ,nonatomic) NSString <Optional>*filmLanguage;
@property (copy ,nonatomic) NSString <Optional>*filmType;
@property (copy ,nonatomic) NSString <Optional>*filmArea;
@property (copy ,nonatomic) NSString <Optional>*filmDirector;
@property (copy ,nonatomic) NSString <Optional>*filmScreenwriter;
@property (copy ,nonatomic) NSString <Optional>*filmMainActor;
@property (copy ,nonatomic) NSString <Optional>*filmImage;
@property (copy ,nonatomic) NSString <Optional>*filmName;
@property (copy ,nonatomic) NSString <Optional>*filmEnglishName;
@property (copy ,nonatomic) NSString <Optional>*personName;
@property (copy ,nonatomic) NSString <Optional>*typeName;
@property (copy ,nonatomic) NSString <Optional>*areaName;
@property (copy ,nonatomic) NSString <Optional>*coverImage;
@property (copy ,nonatomic) NSString <Optional>*premiereDate;
@end



@class JKMyfavoriteWorksModelItems;
@protocol JKMyfavoriteWorksModelItems <NSObject>
@end

@interface JKMyfavoriteWorksModelItems : JSONModel

@property (copy ,nonatomic) NSString <Optional>*favoriteId;
@property (copy ,nonatomic) NSString <Optional>*userId;
@property (copy ,nonatomic) NSString <Optional>*type;
@property (copy ,nonatomic) NSString <Optional>*targetId;
@property (copy ,nonatomic) NSString <Optional>*target;
@property (copy ,nonatomic) JKMyfavoriteWorksModelFilm <Optional>*film;
@property (copy ,nonatomic) JKMyfavoriteWorksModelTV <Optional>*tv;
@property (copy ,nonatomic) JKMyfavoriteWorksModelAnimation <Optional>*animation;
@property (copy ,nonatomic) JKMyfavoriteWorksModelGame <Optional>*game;
@property (copy ,nonatomic) JKMyfavoriteWorksModelVariety <Optional>*variety;

@end


@interface JKMyfavoriteWorksModelData : JSONModel
@property (strong ,nonatomic) NSArray <Optional,JKMyfavoriteWorksModelItems>*items;

@end


@interface JKMyfavoriteWorksModel : JSONModel
@property (strong ,nonatomic) JKMyfavoriteWorksModelData*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

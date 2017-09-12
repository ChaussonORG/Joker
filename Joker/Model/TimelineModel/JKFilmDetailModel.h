//
//  JKFilmDetailModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

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


@end


@interface JKFilmDetailModel : JSONModel
@property (strong ,nonatomic) JKFilmDetailModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

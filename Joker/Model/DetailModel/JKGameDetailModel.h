//
//  JKGameDetailModel.h
//  joker
//
//  Created by Chausson on 2017/1/15.
//  Copyright © 2017年 chausson. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JKGameDetailModel : JSONModel
//@property (assign ,nonatomic) BOOL favorited;
@property (assign ,nonatomic) float fami_score;
@property (assign ,nonatomic) float ign_score;
@property (assign ,nonatomic) float gs_score;
@property (assign ,nonatomic) float joker_score;
@property (assign ,nonatomic) float whole_network_score;
@property (strong ,nonatomic) NSString <Optional>*desc;
@property (strong ,nonatomic) NSArray <Optional>*gameLanguage;
@property (strong ,nonatomic) NSArray <Optional>*gameType;
@property (strong ,nonatomic) NSArray <Optional>*gameImage;

@end

@interface JKGameModel : JSONModel
@property (strong ,nonatomic) JKGameDetailModel <Optional>*data;
@property (strong ,nonatomic) NSString <Optional>*message;
@property (assign ,nonatomic) int code;
@end

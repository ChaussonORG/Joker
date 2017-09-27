//
//  JKFilmTimeLineCollectionViewCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKFilmTimeLineCollectionViewCellVM : NSObject

@property (nonatomic , strong) NSString *imageUrl;

@property (nonatomic , strong) NSString *filmCounty;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *favoriteCount;

@property (nonatomic , strong) NSString *directors;

@property (nonatomic , strong) NSString *mainActors;

@property (nonatomic , assign) BOOL isfavorite;

@property (nonatomic , assign) BOOL isRecommand;

@property (nonatomic , strong) NSString *jokerScore;

@property (nonatomic , strong) NSString *score1;

@property (nonatomic , strong) NSString *score2;

@property (nonatomic , strong) NSString *score3;

@property (nonatomic , strong) NSString *score4;


@property (nonatomic , strong) NSString *extId;

@property (nonatomic , assign) BOOL isON;

- (void)gotoDetail;
@end

//
//  JKFilmTimeLineVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JKFilmTimeLineFilter){
    JKFilmCurrent,
    JKFilmFuture,
};

@interface JKFilmTimeLineVM : NSObject

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , assign) JKFilmTimeLineFilter type;

@end

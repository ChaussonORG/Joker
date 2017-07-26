//
//  JKTVTimeLineVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/26.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JKTVTimeLineFilter){
    JKTVCurrent,
    JKTVFuture,
};


@interface JKTVTimeLineVM : NSObject

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , assign) JKTVTimeLineFilter type;


@end

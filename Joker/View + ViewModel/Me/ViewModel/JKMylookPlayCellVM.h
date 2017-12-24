//
//  JKMylookPlayCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JKMylookPlayCellVM : NSObject



@property (nonatomic , strong) NSString *img;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *projectId;

@property (nonatomic , strong) NSString *type;

@property (nonatomic , strong) NSString *score;

@property (nonatomic , strong) NSString *directors;

@property (nonatomic , strong) NSString *actors;

@property (nonatomic , assign) float cellHeight;


- (void)gotoDetail;

@end

//
//  JKMEListCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKUserManager.h"

@protocol MeControllerDelegate <NSObject>

- (void)refreshUI;

@end
@interface JKMEListCellVM : NSObject

@property (nonatomic , strong) NSString *title;

@property (nonatomic , assign) BOOL isRed;

@property (nonatomic , assign) id<MeControllerDelegate>delegate;
- (void)goNext;



@end

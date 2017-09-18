//
//  JKMEListCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKUserManager.h"
@interface JKMEListCellVM : NSObject

@property (nonatomic , strong) NSString *title;

@property (nonatomic , assign) BOOL isRed;


- (void)goNext;


@end

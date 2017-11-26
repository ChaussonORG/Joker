//
//  JKMEVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKMEListCellVM.h"
#import "CHLoginModalController.h"
@interface JKMEVM : NSObject

@property (nonatomic , strong) NSMutableArray <JKMEListCellVM *>*cellViewModels;
@property (nonatomic ,strong) NSString *icon;

@property (nonatomic ,strong) NSString *name;

@property (nonatomic ,strong) NSString *favorCount;

@property (nonatomic ,strong) NSString *lookCount;

@property (nonatomic ,strong) NSString *myMessageCount;



- (void)initData;

- (void)gotoSetting;

- (void)requestMyMessage;
@end

//
//  JKMyMessageVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKMyMessageCellVM.h"
@interface JKMyMessageVM : NSObject

@property (nonatomic , strong) NSMutableArray <JKMyMessageCellVM *>*cellViewModels;

@property (nonatomic , assign ,readonly) BOOL isFinishRequestMoreData;



- (void)requestData;
@end

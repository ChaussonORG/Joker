//
//  JKPersonInfoVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/12/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKPersonInfoCellVM.h"
@interface JKPersonInfoVM : NSObject

@property (nonatomic , strong) NSMutableArray <JKPersonInfoCellVM *>*cellViewModels;

- (void)requestData;
@end

//
//  JKMyTopicVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKTopicListCellVM.h"
typedef NS_ENUM(NSInteger, JKMyTopicType){
    JKMyTopicCreated,
    JKMyTopicCommented,
    JKMyTopicdraft,
};

@interface JKMyTopicVM : NSObject


@property (nonatomic , assign) JKMyTopicType type;

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , strong , readonly) NSMutableArray <JKTopicListCellVM *>*cellViewModels;

@property (nonatomic , assign ,readonly) BOOL isFinishRequestMoreData;



- (void)requestData;

- (void)requestMoreData;
@end

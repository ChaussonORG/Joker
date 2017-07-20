//
//  JKTopicCreateVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/5.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKTopicCreateModel.h"
@interface JKTopicCreateVM : NSObject

@property (nonatomic , strong) NSString *type;
@property (nonatomic , strong) NSString *projectId;

@property (nonatomic , strong) NSString *relateWorkName;

- (void)createTopicWithTitle:(NSString *)title
                        data:(NSArray <JKTopicCreateModel *>*)data;

- (void)goToRelate;
@end

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


- (void)createTopicWithTitle:(NSString *)title
                        data:(NSArray <JKTopicCreateModel *>*)data;
@end

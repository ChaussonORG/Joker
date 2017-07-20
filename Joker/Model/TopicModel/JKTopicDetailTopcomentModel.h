//
//  JKTopicDetailTopcomentModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "JKTopicDetailCommentListModel.h"
 
@interface JKTopicDetailTopcomentModel : JSONModel

@property (nonatomic , strong) NSArray <Optional,JKTopicDetailCommentListModelTopicReplayPojoList>*data;
@end

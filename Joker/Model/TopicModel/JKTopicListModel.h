//
//  JKTopicListModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/6/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class JKTopicListModelTopicContentBeans;
@protocol JKTopicListModelTopicContentBeans <NSObject>
@end



@interface JKTopicListModelTopicContentBeans : JSONModel
@property (nonatomic, strong)NSString <Optional>*contentType;
@property (nonatomic, strong)NSString <Optional>*content;
@property (nonatomic, strong)NSString <Optional>*displayOrder;
 
@end


@class JKTopicListModelItems;
@protocol JKTopicListModelItems <NSObject>
@end

@interface JKTopicListModelItems : JSONModel
@property (nonatomic, strong)NSString <Optional>*title;
@property (nonatomic, strong)NSString <Optional>*icon;
@property (nonatomic, strong)NSString <Optional>*nickname;
@property (nonatomic, strong)NSString <Optional>*createTime;
@property (nonatomic, strong)NSString <Optional>*topicId;
@property (nonatomic, strong)NSString <Optional>*projectType;
@property (nonatomic, strong)NSString <Optional>*projectId;
@property (nonatomic, strong)NSString <Optional>*topicReplayCount;
@property (nonatomic, strong)NSString <Optional>*projectName;
@property (nonatomic, strong)NSString <Optional>*topicReplayPojoList;
@property (nonatomic, strong)NSArray <Optional, JKTopicListModelTopicContentBeans>*topicContentBeans;

@end

@interface JKTopicListModelData : JSONModel
@property (nonatomic, strong)NSArray <Optional,JKTopicListModelItems>*items;


@end


@interface JKTopicListModel : JSONModel
@property (strong ,nonatomic) JKTopicListModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

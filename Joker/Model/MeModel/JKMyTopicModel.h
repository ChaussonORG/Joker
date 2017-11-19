//
//  JKMyTopicModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JKMyTopicModelUserInfo : JSONModel
@property (nonatomic, strong) NSString <Optional>*img;
@property (nonatomic, strong) NSString <Optional>*nickname;
@end


@class JKMyTopicModelItems;
@protocol JKMyTopicModelItems <NSObject>
@end

@interface JKMyTopicModelItems : JSONModel
@property (nonatomic, strong)NSString <Optional>*commentNum;
@property (nonatomic, strong)NSString <Optional>*content;
@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*projectId;
@property (nonatomic, strong)NSString <Optional>*projectType;
@property (nonatomic, strong)JKMyTopicModelUserInfo <Optional>*userInfo;
@property (nonatomic, strong)NSString <Optional>*createTime;
@property (nonatomic, strong)NSString <Optional>*projectName;

@end


@interface JKMyTopicModelData : JSONModel
@property (nonatomic, strong)NSArray <Optional,JKMyTopicModelItems>*items;
@end


@interface JKMyTopicModel : JSONModel
@property (strong ,nonatomic) JKMyTopicModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

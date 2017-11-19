//
//  JKMyMessageListModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@interface JKMyMessageListModelUserInfo : JSONModel
@property (nonatomic, strong)NSString <Optional>*img;
@property (nonatomic, strong)NSString <Optional>*nickname;
@end



@class JKMyMessageListModelItems;
@protocol JKMyMessageListModelItems <NSObject>
@end

@interface JKMyMessageListModelItems : JSONModel
@property (nonatomic, strong)NSString <Optional>*commentNum;
@property (nonatomic, strong)NSString <Optional>*content;
@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*projectId;
@property (nonatomic, strong)NSString <Optional>*projectName;
@property (nonatomic, strong)NSString <Optional>*projectType;
@property (nonatomic, strong)JKMyMessageListModelUserInfo <Optional>*userInfo;

@property (nonatomic, strong)NSString <Optional>*readStatus;
@property (nonatomic, strong)NSString <Optional>*mType;
@property (nonatomic, strong)NSString <Optional>*createTime;

@end


@interface JKMyMessageListModelData : JSONModel
@property (nonatomic, strong)NSArray <Optional,JKMyMessageListModelItems>*items;
@end


@interface JKMyMessageListModel : JSONModel
@property (strong ,nonatomic) JKMyMessageListModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

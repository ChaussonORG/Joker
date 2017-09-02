//
//  JKWorkCommentModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JKWorkCommentModelAppUser : JSONModel

@property (nonatomic, strong)NSString <Optional>*nickname;
@property (nonatomic, strong)NSString <Optional>*photo;
@property (nonatomic, strong)NSString <Optional>*userId;

@end

@class JKWorkCommentModelItems;
@protocol JKWorkCommentModelItems <NSObject>
@end

@interface JKWorkCommentModelItems : JSONModel
@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*userId;
@property (nonatomic, strong)NSString <Optional>*extId;
@property (nonatomic, strong)NSString <Optional>*commentType;
@property (nonatomic, strong)NSString <Optional>*score;
@property (nonatomic, strong)NSString <Optional>*replyId;
@property (nonatomic, strong)NSString <Optional>*content;
@property (nonatomic, strong)NSString <Optional>*disgust;
@property (nonatomic, strong)NSString <Optional>*favour;
@property (nonatomic, strong)NSString <Optional>*parentId;
@property (nonatomic, strong)NSString <Optional>*count;
@property (nonatomic, strong)JKWorkCommentModelAppUser *appUser;


@end

@interface JKWorkCommentModelData : JSONModel
@property (nonatomic, strong)NSArray <Optional,JKWorkCommentModelItems>*items;
@property (nonatomic, strong)NSArray <Optional,JKWorkCommentModelItems>*favourComment;
@property (nonatomic, strong)NSArray <Optional,JKWorkCommentModelItems>*disgustComment;

@property (nonatomic, strong)NSString <Optional>*total;

@end


@interface JKWorkCommentModel : JSONModel
@property (strong ,nonatomic) JKWorkCommentModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

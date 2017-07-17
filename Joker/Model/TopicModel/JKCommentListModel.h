//
//  JKCommentListModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/10.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@class JKCommentListModelData;
@protocol JKCommentListModelData <NSObject>
@end


@interface JKCommentListModelData : JSONModel

@property (nonatomic, strong) NSString *topicReplayId;
@property (nonatomic, strong) NSString *topicId;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *content;
@end


@interface JKCommentListModel : JSONModel
@property (strong ,nonatomic) NSArray <Optional,JKCommentListModelData>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end




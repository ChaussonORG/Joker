//
//  JKTopicDetailCommentListModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JKTopicDetailCommentListModelAuthor : JSONModel

@property (nonatomic, strong)NSString  <Optional>*nickname;
@property (nonatomic, strong)NSString  <Optional>*icon;
@property (nonatomic, strong)NSString  <Optional>*userId;


@end


@interface JKTopicDetailCommentListModelReplyInfo : JSONModel

@property (nonatomic, strong) NSString <Optional>*replyId;
@property (nonatomic, strong) JKTopicDetailCommentListModelAuthor <Optional>*author;
@property (nonatomic, strong) NSString <Optional>*content;

@end


@class JKTopicDetailCommentListModelTopicReplayPojoList;
@protocol JKTopicDetailCommentListModelTopicReplayPojoList <NSObject>
@end


@interface JKTopicDetailCommentListModelTopicReplayPojoList : JSONModel

@property (nonatomic, strong) JKTopicDetailCommentListModelAuthor *author;
@property (nonatomic, strong)NSString  <Optional>*topicReplayId;
@property (nonatomic, strong)NSString  <Optional>*topicId;
@property (nonatomic, strong)NSString  <Optional>*parentId;
@property (nonatomic, strong)NSString  <Optional>*content;
@property (nonatomic, strong)NSString  <Optional>*likeCount;
@property (nonatomic, strong)NSString  <Optional>*disgustCount;
@property (nonatomic, strong)NSString  <Optional>*evaluation;
@property (nonatomic, strong)NSString  <Optional>*createTime;

@property (nonatomic, strong)JKTopicDetailCommentListModelReplyInfo <Optional>*replyInfo;

@end


@interface JKTopicDetailCommentListModel : JSONModel

@property (nonatomic, strong) NSArray <Optional,JKTopicDetailCommentListModelTopicReplayPojoList>*items;

@property (nonatomic , strong) NSString *total;

@property (nonatomic , strong) NSString *page;
//@property (assign ,nonatomic) int code;
//@property (copy ,nonatomic) NSString *message;


@end

//
//  JKTopicListCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JKTopicCommentStyle){
    TopicCommentNormal,
    TopicCommentDraft,
};

@protocol TopicCommentDelegate <NSObject>

- (void)commentTopicWithId:(NSString *)topicId title:(NSString *)title;

@end


@interface JKTopicListCellVM : NSObject

@property (nonatomic , assign) JKTopicCommentStyle style;

@property (nonatomic ,weak) id<TopicCommentDelegate>delegate;

@property (nonatomic , strong) NSString *headerUrl;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *time;

@property (nonatomic , strong) NSString *related;

@property (nonatomic , strong) NSString *content;

@property (nonatomic , strong) NSString *commentCount;

@property (nonatomic , assign) float nameLabelWeight;

@property (nonatomic , assign) float contentLabelHeight;

@property (nonatomic , assign) float cellHeight;

@property (nonatomic , strong) NSString *topicId;

@property (nonatomic , strong) NSString *projectId;

@property (nonatomic , strong) NSString *projectType;

@property (nonatomic , strong) NSString *topicContent;

@property (nonatomic , strong) NSString *draftNum;

- (void)openTopicDetail;

- (void)openTopicComment;

- (void)openWorkDetail;

- (void)editDraft;
@end

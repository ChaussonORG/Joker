//
//  JKTopicListCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TopicCommentDelegate <NSObject>

- (void)commentTopicWithId:(NSString *)topicId title:(NSString *)title;

@end


@interface JKTopicListCellVM : NSObject

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

- (void)openTopicDetail;

- (void)openTopicComment;

- (void)openWorkDetail;

@end

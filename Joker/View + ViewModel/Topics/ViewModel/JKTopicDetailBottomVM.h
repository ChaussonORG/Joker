//
//  JKTopicDetailBottomVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PAGELIMIT 10.0

@protocol TopicDetailBottomDelegate <NSObject>

- (void)refresh;

- (void)upWithOffset:(NSInteger)offset;

- (void)downWithOffset:(NSInteger)offset;

- (void)reply;

@end
@interface JKTopicDetailBottomVM : NSObject

@property (nonatomic , assign) NSInteger pageCount;

@property (nonatomic , assign) NSInteger currentPage;

@property (nonatomic , assign) BOOL isUpable;

@property (nonatomic , assign) BOOL isDownable;

@property (nonatomic , weak) id<TopicDetailBottomDelegate>delegate;

- (void)refresh;

- (void)up;

- (void)down;

- (void)reply;

@end

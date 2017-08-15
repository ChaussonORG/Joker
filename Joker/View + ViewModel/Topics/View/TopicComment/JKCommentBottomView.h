//
//  JKCommentBottomView.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/7.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentStatusDelegate <NSObject>

- (void)favourComment;

- (void)criticismComment;

- (void)turnComment;

- (void)deleteComment;

- (void)replyComment;

@end

@interface JKCommentBottomView : UIView

@property (nonatomic , strong) UIButton *favourBtn;

@property (nonatomic , strong) UIButton *criticismBtn;

@property (nonatomic , strong) UIButton *turnBtn;

@property (nonatomic , strong) UIButton *deleteBtn;

@property (nonatomic , strong) UIButton *commentBtn;

@property (nonatomic , weak) id<CommentStatusDelegate>delegate;


@end

//
//  JKCommentOpenCell.h
//  JKCommentTableView
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentListOpenDelegate <NSObject>

- (void)openCommentList;

@end

@interface JKCommentOpenCell : UITableViewCell

@property (nonatomic ,weak) id<CommentListOpenDelegate>delegate;

@property (nonatomic , strong) UILabel *contentLabel;

@end

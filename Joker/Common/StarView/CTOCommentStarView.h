//
//  TOYCommentStarView.h
//  ToyMan
//
//  Created by 朱彦君 on 16/8/15.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CTOCommentStarView : UIView



- (instancetype)initWithFrame:(CGRect)frame SelectedCount:(CGFloat)selectedCount commentable:(BOOL)isCommentable starMargin:(CGFloat)starMargin starWidth:(CGFloat)starWidth;


- (void)refreshFrame:(CGRect)frame SelectedCount:(CGFloat)selectedCount commentable:(BOOL)isCommentable starMargin:(CGFloat)starMargin starWidth:(CGFloat)starWidth;

- (NSInteger)selectedCount;
@end

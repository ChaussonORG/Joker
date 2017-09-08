//
//  JKTopicListHeaderView.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/4.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#define JKFilterTitleNum 8888

@protocol ChooseTopicDelegate <NSObject>

- (void)chooseTopicWithIndex:(NSInteger)index;

@end
@interface JKTopicListHeaderView : UIView

- (instancetype)initWithFilterTitles:(NSArray *)filterTitleArr selectedColor:(UIColor *)color isLine:(BOOL)isLine;

@property (nonatomic , weak) id<ChooseTopicDelegate>delegate;

@property (nonatomic , strong , readonly) NSArray *filterTilteArr;

@property (nonatomic , assign) NSInteger selectedIndex;

@property (nonatomic , assign) BOOL isSeperator;

@property (nonatomic , strong) UIView *bottomLine;

- (void)changeSelectedUIWithIndex:(NSInteger)index;
@end

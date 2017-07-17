//
//  JKTopicFilterView.h
//  Joker
//
//  Created by 朱彦君 on 2017/6/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JKFilterSerialNum 9999
#define JKFilterImageWidth 40

@protocol FilterTopicDelegate <NSObject>

- (void)filterTopicWithIndex:(NSInteger)index;

@end
@interface JKTopicFilterView : UITableViewCell

@property (nonatomic , weak) id<FilterTopicDelegate>delegate;

@property (nonatomic , strong) UILabel *mainTitleLabel;

@property (nonatomic , strong , readonly) NSArray *dataSource;

@property (nonatomic , strong) NSArray *imageSource;


- (void)fetchData:(NSArray *)dataSource;

@end

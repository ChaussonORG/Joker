//
//  JKWorkImageListCell.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/2.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoBroswerVC.h"
#import "PhotoCotentView.h"


@protocol PhotoBroswerVCDelegate <NSObject>

-(void)networkImageShow:(NSUInteger)index;

@end
@interface JKWorkImageListCell : UITableViewCell
@property (nonatomic , strong) UILabel *mainTitleLabel;

@property (nonatomic , weak) id<PhotoBroswerVCDelegate>delegate;

@property (strong, nonatomic) PhotoCotentView *contentImageView;

- (void)LoadUIWithTitle:(NSString *)title images:(NSArray *)images descLabelHeight:(CGFloat)imagesCollectionViewHeight;
@end

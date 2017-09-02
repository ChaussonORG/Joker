//
//  JKWorkCommentCreatVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKWorkCommentCreatVM : NSObject

@property (nonatomic , strong) NSString *commentType;

@property (nonatomic , strong) NSString *extId;

@property (nonatomic , strong) NSString *score;

@property (nonatomic , strong ) NSString *content;

@property (nonatomic , strong ) NSString *titleStr;

- (void)creatCommentWithContent:(NSString *)str;


@end

//
//  JKCommentCreatVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/8.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKCommentCreatVM : NSObject

@property (nonatomic , strong) NSString *titleStr;

@property (nonatomic , strong) NSString *topicId;

@property (nonatomic , strong) NSString *parentId;

@property (nonatomic , strong , readonly) NSString *content;


- (void)creatCommentWithContent:(NSString *)str;
@end

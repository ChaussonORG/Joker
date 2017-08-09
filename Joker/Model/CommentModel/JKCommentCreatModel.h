//
//  JKCommentCreatModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JKCommentCreatModel : JSONModel
@property (nonatomic , strong) NSString *parentId;
@property (nonatomic , strong) NSString *topicId;
@property (nonatomic , strong) NSString *content;
@end

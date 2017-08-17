//
//  JKCommentTurnModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/8/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JKCommentTurnModel : JSONModel


@property (nonatomic , strong) NSString <Optional>*topicReplayId;

@property (nonatomic , strong) NSString <Optional>*content;
@end

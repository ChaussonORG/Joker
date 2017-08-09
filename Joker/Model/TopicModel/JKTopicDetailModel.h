//
//  JKTopicDetailModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>



@interface JKTopicDetailModelData : JSONModel
//@property (nonatomic, strong) NSArray <Optional,JKTopicDetailModelTopicReplayPojoList>*topicReplayPojoList;
//
//@property (strong ,nonatomic) NSArray <Optional,JKTopicDetailModelTopicReplayPojoList>*topicTop5ReplayPojoList;
//@property (strong ,nonatomic) NSArray <Optional,JKTopicDetailModelTopicReplayPojoList>*topicBottom5ReplayPojoList;

@property (nonatomic, strong)NSString  *commentCount;
@property (nonatomic, strong)NSString  *url;
@property (nonatomic, strong)NSString  *title;

@end


@interface JKTopicDetailModel : JSONModel
@property (strong ,nonatomic) JKTopicDetailModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

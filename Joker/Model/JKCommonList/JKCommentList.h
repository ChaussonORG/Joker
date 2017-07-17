//
//  JKCommentList.h
//  joker
//
//  Created by Chausson on 2016/12/29.
//  Copyright © 2016年 chausson. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class JKCommentModel;
@protocol JKCommentModel <NSObject>
@end
@interface JKCommentModel : JSONModel
@property (nonatomic) NSInteger identifier;
@property (assign ,nonatomic) NSInteger userId;
@property (assign ,nonatomic) NSInteger extId;
@property (strong ,nonatomic) NSString *commentType;
@property (strong ,nonatomic) NSString <Optional>*content;
@property (nonatomic) NSString <Optional>*nickName;
@property (nonatomic) NSString <Optional>*icon;
@property (nonatomic) float score;
@property (nonatomic,strong) NSNumber <Ignore>*height;
@property (nonatomic,strong) NSString <Ignore>*title;
@property (assign ,nonatomic) NSInteger favour;
@property (assign ,nonatomic) NSInteger disgust;
@end
@interface JKCommentList : JSONModel
@property (strong ,nonatomic) NSArray <JKCommentModel,Optional>*items;
@property (strong ,nonatomic) NSArray <JKCommentModel,Optional>*disgustComment;
@property (strong ,nonatomic) NSArray <JKCommentModel,Optional>*favourComment;
@property (strong ,nonatomic) NSArray <JKCommentModel,Optional>*mineComment;

@end

@interface JKCommentData : JSONModel
@property (strong ,nonatomic) NSString* code;
@property (strong ,nonatomic) NSString* message;
@property (strong ,nonatomic) JKCommentList <Optional>*data;
@end
@interface JKCommentDetail : JSONModel
@property (strong ,nonatomic) NSString* code;
@property (strong ,nonatomic) NSString* message;
@property (strong ,nonatomic) NSArray <JKCommentModel>*data;
@end

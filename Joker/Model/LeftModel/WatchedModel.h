//
//  WatchedModel.h
//  joker
//
//  Created by 肖松 on 15-10-5.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#import "BaseModel.h"
@class WatchedInfo;
@protocol WatchedInfo <NSObject>


@end
@interface WatchedInfo : JSONModel
@property (copy ,nonatomic) NSString <Optional>*detailId;
@property (copy ,nonatomic) NSString <Optional>*imageUrl;
@property (copy ,nonatomic) NSString <Optional>*name;
@property (copy ,nonatomic) NSString <Optional>*score;
@property (copy ,nonatomic) NSString <Optional>*date;
@property (copy ,nonatomic) NSString <Optional>*time;
@end
@interface WatchedModel : BaseModel
@property (strong ,nonatomic)NSArray<WatchedInfo,Optional> *data;
@end

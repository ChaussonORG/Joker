//
//  JKNewsModel.h
//  joker
//
//  Created by Chausson on 2017/1/6.
//  Copyright © 2017年 chausson. All rights reserved.
//

#import "BaseModel.h"
@class JKNewsContent;
@protocol JKNewsContent <NSObject>

@end
@interface JKNewsContent : JSONModel
@property (assign ,nonatomic) NSInteger id;
@property (strong ,nonatomic) NSString *title;
@property (strong ,nonatomic) NSString <Optional>*url;
@property (strong ,nonatomic) NSString <Optional>*imgUrl;
@property (strong ,nonatomic) NSString <Optional>*content;
@property (strong ,nonatomic) NSString <Optional>*date;
//@property (assign ,nonatomic) NSInteger commentSize;
@end
@interface JKNewsModel : JKBaseModel
@property (strong ,nonatomic)  NSArray <Optional,JKNewsContent>*data;
@end

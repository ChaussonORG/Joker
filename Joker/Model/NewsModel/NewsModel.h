//
//  NewsModel.h
//  joker
//
//  Created by 肖松 on 15-7-5.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#import "JSONModel.h"
@class NewsData;
@protocol NewsData <NSObject>


@end
@interface  NewsData : JSONModel
@property (strong ,nonatomic) NSString<Optional>* newsId;
@property (strong ,nonatomic) NSString<Optional>* date;
@property (strong ,nonatomic) NSString<Optional>* url;
@property (strong ,nonatomic) NSString<Optional>* imageUrl;
@property (strong ,nonatomic) NSString<Optional>* title;
@property (strong ,nonatomic) NSString<Optional>* content;
@end
@interface NewsModel : JSONModel
@property (strong ,nonatomic) NSArray<NewsData>* data;
@property (strong ,nonatomic) NSString* message;
@property (assign ,nonatomic) int status;
@property (assign ,nonatomic) int errorCode;
@end

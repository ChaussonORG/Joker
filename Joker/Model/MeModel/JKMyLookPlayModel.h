//
//  JKMyLookPlayModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/11.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class JKMyLookPlayModelItems;
@protocol JKMyLookPlayModelItems <NSObject>
@end

@interface JKMyLookPlayModelItems : JSONModel
@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*img;
@property (nonatomic, strong)NSString <Optional>*commentType;
@property (nonatomic, strong)NSString <Optional>*wholeScore;
@property (nonatomic, strong)NSArray <Optional>*actors1;
@property (nonatomic, strong)NSArray <Optional>*actors2;
@property (nonatomic, strong)NSArray <Optional>*actors3;
@property (nonatomic, strong)NSString <Optional>*jokerScore;
@end


@interface JKMyLookPlayModelData : JSONModel
@property (nonatomic, strong)NSArray <Optional,JKMyLookPlayModelItems>*items;
@end


@interface JKMyLookPlayModel : JSONModel
@property (strong ,nonatomic) JKMyLookPlayModelData <Optional>*data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end

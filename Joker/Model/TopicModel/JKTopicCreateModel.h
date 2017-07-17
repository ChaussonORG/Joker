//
//  JKTopicCreateModel.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/11.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JKTopicCreateDataType){
    JKTopicDataImage,
    JKTopicDataCharacter,
};

@interface JKTopicCreateModel : NSObject

@property (nonatomic , assign) JKTopicCreateDataType dataType;

@property (nonatomic , strong) NSString *content;

@property (nonatomic , strong) UIImage *image;

@property (nonatomic , assign) NSInteger minIndex;

@property (nonatomic , assign) NSInteger maxIndex;

@end

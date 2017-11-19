//
//  JKMyMessageCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/11/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JKMyMessageType){
    JKMyMessageZan,
    JKMyMessageCai,
    JKMyMessageReply,
    JKMyMessageTopicReply,
};
@interface JKMyMessageCellVM : NSObject

@property (nonatomic ,assign) JKMyMessageType type;

@property (nonatomic , strong) NSString *icon;

@property (nonatomic , assign) BOOL isRead;

@property (nonatomic , strong) NSString *time;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *projectName;

@property (nonatomic , strong) NSString *content;

@property (nonatomic , strong) NSString *title;

@property (nonatomic , assign) NSInteger titleStr2Count;

@property (nonatomic , assign) float titleHeight;

@property (nonatomic , assign) float contentHeight;

@property (nonatomic , assign) float cellHeight;

@property (nonatomic , strong) NSString *projectType;

@property (nonatomic , strong) NSString *mType;

@property (nonatomic , strong) NSString *id;

@property (nonatomic , strong) NSString *projectId;
- (void)gotoDetail;
@end

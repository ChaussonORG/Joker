//
//  JKSubcommentListCellVM.h
//  JKCommentTableView
//
//  Created by 朱彦君 on 2017/6/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKSubcommentListCellVM : NSObject

@property (nonatomic , strong) NSString *content;

@property (nonatomic , assign) BOOL isSpread;

@property (nonatomic , assign) float contentLabelHeight;

@property (nonatomic , assign) float tempContentLabelHeight;

@property (nonatomic , assign) float cellHeight;

@end

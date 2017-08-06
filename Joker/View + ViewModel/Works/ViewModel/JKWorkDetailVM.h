//
//  JKWorkDetailVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/30.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKWorkDetailVM : NSObject

@property (nonatomic , strong , readonly) NSString *workId;

- (instancetype)init __unavailable;

- (instancetype)initWithWorkId:(NSString *)workId;


@end

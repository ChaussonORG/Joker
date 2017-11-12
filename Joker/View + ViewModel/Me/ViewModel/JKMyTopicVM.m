 //
//  JKMyTopicVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyTopicVM.h"

@implementation JKMyTopicVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.titlesArray = @[@"我发起的",@"我评论的",@"草稿箱"];
        
        
    }
    return self;
}

@end

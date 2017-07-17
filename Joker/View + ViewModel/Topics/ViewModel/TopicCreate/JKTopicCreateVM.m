//
//  JKTopicCreateVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/5.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicCreateVM.h"
#import "ASNavigator.h"
#import "JKTopicCreateApi.h"
@implementation JKTopicCreateVM

- (void)createTopicWithTitle:(NSString *)title
                        data:(NSArray <JKTopicCreateModel *>*)data{
    
    
    JKTopicCreateApi *api = [[JKTopicCreateApi alloc]init];
    
    api.topicContent = [NSMutableArray array];
    for (int i = 0; i < data.count; i++) {
        JKTopicCreateModel *model = data[i];
        
        if (model.dataType == JKTopicDataCharacter) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:model.content forKey:@"content"];
            
            [dic setObject:@"TEXT" forKey:@"contentType"];
            
            [dic setObject:@(i + 1) forKey:@"displayOrder"];
            
            [api.topicContent addObject:dic];
        }
        else if (model.dataType == JKTopicDataCharacter) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:model.content forKey:@"content"];
            
            [dic setObject:@"IMAGE" forKey:@"contentType"];
            
            [dic setObject:@(i + 1) forKey:@"displayOrder"];
            
            [api.topicContent addObject:dic];
            
        }
        
    }
  
    
    [api startWithSuccessBlock:^(__kindof JKTopicCreateApi *request) {
        
        
        [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:NO];
        
        
    } failureBlock:^(__kindof JKTopicCreateApi *request) {
        
        
        
    }];
    
    
}

@end

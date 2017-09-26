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
#import "JKTopicRelatedWorksListController.h"
#import <CHProgressHUD/CHProgressHUD.h>

@interface JKTopicCreateVM()<FetchRelateWorkDelegate>

@end
@implementation JKTopicCreateVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.isWithWork = NO;
        self.relateWorkName = @"关联作品";
    }
    return self;
}

- (void)createTopicWithTitle:(NSString *)title
                        data:(NSArray <JKTopicCreateModel *>*)data{
    
    if (self.projectId.length == 0) {
        
        
        [CHProgressHUD showPlainText:@"请选择关联作品"];
        return;
    }
    
    JKTopicCreateApi *api = [[JKTopicCreateApi alloc]init];
    
    api.projectId = self.projectId;
    api.projectType = self.type;
    api.title = title;
    
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
        else if (model.dataType == JKTopicDataImage) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            [dic setObject:model.image forKey:@"content"];
            
            [dic setObject:@"IMAGE" forKey:@"contentType"];
            
            [dic setObject:@(i + 1) forKey:@"displayOrder"];
            
            [api.topicContent addObject:dic];
            
        }
        
    }
   
    [api startWithSuccessBlock:^(__kindof JKTopicCreateApi *request) {
        
        
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:NO];
        }
        
        
        
    } failureBlock:^(__kindof JKTopicCreateApi *request) {
        
    }];
    
}

- (void)goToRelate{
    
    JKTopicRelatedWorksListController *vc = [[JKTopicRelatedWorksListController alloc]init];
    
    vc.viewModel.delegate = self;
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
}

- (void)fetchRelateWork:(NSString *)workId relateType:(NSString *)type relateWorkName:(NSString *)name{
    
    self.projectId = workId;
    
    self.type = type;
    
    self.relateWorkName = name;
    
    [self.delegate refreshSendBtn];
}

@end

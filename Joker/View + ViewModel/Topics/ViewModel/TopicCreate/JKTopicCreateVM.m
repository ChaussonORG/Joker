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
        else{
            
            
            [CHProgressHUD showPlainText:@"发送失败"];
        }
        
        
    } failureBlock:^(__kindof JKTopicCreateApi *request) {
        
        [CHProgressHUD showPlainText:@"发送失败"];
        
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
- (void)draftTopicWithTitle:(NSString *)title
                       data:(NSArray <JKTopicCreateModel *>*)data content:(NSAttributedString *)content{
    
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
    
    
    //寻找TopicDraft.plist
    
    if ([self isFileExist:@"topicDraft.plist"]) {
        
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path1 = [pathArray objectAtIndex:0];
        NSString *myPath = [path1 stringByAppendingPathComponent:@"topicDraft.plist"];
 
        NSMutableDictionary *data2 = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
       
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        
        NSData *contentData  = [content dataFromRange:NSMakeRange(0, content.length) documentAttributes:@{NSDocumentTypeDocumentAttribute:NSRTFDTextDocumentType} error:nil];   //将 NSAttributedString 转为NSData
        [data setObject:contentData forKey:@"content"];
        [data setObject:api.projectId forKey:@"projectId"];
        [data setObject:api.projectType forKey:@"projectType"];
        [data setObject:api.title forKey:@"title"];
        [data setObject:self.relateWorkName forKey:@"relateWorkName"];
        
        NSString *key = [NSString stringWithFormat:@"%ld",data2.count + 1];
        [data2 setObject:data forKey:key];
        [data2 writeToFile:myPath atomically:YES];
    }
    else{
        
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path=[paths objectAtIndex:0];
        NSLog(@"path = %@",path);
        NSString *filename=[path stringByAppendingPathComponent:@"topicDraft.plist"];
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
        
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        NSData *contentData  = [content dataFromRange:NSMakeRange(0, content.length) documentAttributes:@{NSDocumentTypeDocumentAttribute:NSRTFDTextDocumentType} error:nil];   //将 NSAttributedString 转为NSData
        [data setObject:contentData forKey:@"content"];
        [data setObject:api.projectId forKey:@"projectId"];
        [data setObject:api.projectType forKey:@"projectType"];
        [data setObject:api.title forKey:@"title"];
        [data setObject:self.relateWorkName forKey:@"relateWorkName"];
        
        NSMutableDictionary *data2 = [NSMutableDictionary dictionary];
        [data2 setObject:data forKey:@"1"];
        [data2 writeToFile:filename atomically:YES];
        
    }
}


-(BOOL)isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}
@end

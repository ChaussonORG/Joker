//
//  JKWorkCommentListCellVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkCommentListCellVM.h"
#import "CHCommonMacro.h"
#import "JKStyleConfiguration.h"
#import "JKCommentListApi.h"
#import "JKWorkCommentCaiApi.h"
#import "JKWorkCommentZanApi.h"
#import "JKCommentCreatController.h"
#import "JKCommetDeleteApi.h"
#import "JKWorkCommentCreatController.h"

@implementation JKWorkCommentListCellVM
- (instancetype)initWithWorkId:(NSString *)WorkId;

{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}






- (void)favouriteAfterCai{
    
    JKWorkCommentZanApi *api = [[JKWorkCommentZanApi alloc]initWithExtId:self.extId];
    
    [api startWithSuccessBlock:^(__kindof JKWorkCommentZanApi *request) {
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            [self criticismComment];
            
        }
        else{
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }
        
        
    } failureBlock:^(__kindof JKWorkCommentZanApi *request) {
        
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
        
    }];
    
}

- (void)favouriteComment{
    
    
    JKWorkCommentZanApi *api = [[JKWorkCommentZanApi alloc]initWithExtId:self.extId];
    
    [api startWithSuccessBlock:^(__kindof JKWorkCommentZanApi *request) {
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            
            [self.delegate refreshSuperTableView];
            
        }
        else{
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }
        
        
    } failureBlock:^(__kindof JKWorkCommentZanApi *request) {
        
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
        
    }];
}
- (void)criticismAfterZan{
    
    JKWorkCommentCaiApi *api = [[JKWorkCommentCaiApi alloc]initWithExtId:self.extId];
    
    [api startWithSuccessBlock:^(__kindof JKWorkCommentCaiApi *request) {
        
        
        if([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            [self favouriteComment];
            
            
        }
        else{
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }
        
        
        
    } failureBlock:^(__kindof JKWorkCommentCaiApi *request) {
        
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
    }];
    
    
    
    
}
- (void)criticismComment{
    JKWorkCommentCaiApi *api = [[JKWorkCommentCaiApi alloc]initWithExtId:self.extId];
    
    [api startWithSuccessBlock:^(__kindof JKWorkCommentCaiApi *request) {
        
        
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            [self.delegate refreshSuperTableView];
            
            
        }
        else{
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }
        
        
        
    } failureBlock:^(__kindof JKWorkCommentCaiApi *request) {
        
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
    }];
    
}

- (void)turnComment{
    
    JKWorkCommentCreatController *vc = [[JKWorkCommentCreatController alloc]init];
    
//    if (self.quoteFloor) {
//        vc.viewModel.titleStr = [NSString stringWithFormat:@"回复：%@%@发表的",self.quoteFloor,self.quoteAutor];
//        vc.viewModel.topicId = self.extId;
//    }
//    else{
//        vc.viewModel.titleStr = [NSString stringWithFormat:@"回复话题"];
//        vc.viewModel.topicId = self.topicReplayId;
//        
//    }
    vc.viewModel.content = self.content;
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
    
    
}

- (void)deleteComment{
    
    UIAlertView *aAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [aAlertView show];
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        JKCommetDeleteApi *api = [[JKCommetDeleteApi alloc]initWithTopicReplayId:self.extId];
        
        [api startWithSuccessBlock:^(__kindof JKCommetDeleteApi *request) {
            
            
            if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
                
                [self.delegate refreshSuperTableView];
                
                
            }
            else{
                [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
                
            }
            
            
            
        } failureBlock:^(__kindof JKCommetDeleteApi *request) {
            
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }];
        
    }
}
- (void)replyComment{
    
    
//    JKCommentCreatController *vc = [[JKCommentCreatController alloc]init];
//    
//    vc.viewModel.titleStr = [NSString stringWithFormat:@"回复：%@楼'%@'",self.floorCount,self.content];
//    
//    vc.viewModel.topicId = self.topicId;
//    
//    vc.viewModel.parentId = self.extId;
//    
//    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
}
@end

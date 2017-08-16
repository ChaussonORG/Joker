//
//  JKCommentListCellVM.m
//  JKCommentTableView
//
//  Created by 朱彦君 on 2017/6/28.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommentListCellVM.h"
#import "CHCommonMacro.h"
#import "JKStyleConfiguration.h"
#import "JKCommentListApi.h"
#import "JKCommentCaiApi.h"
#import "JKCommentZanApi.h"
#import "JKCommentCreatController.h"
#import "JKCommetDeleteApi.h"


@implementation JKCommentListCellVM
- (instancetype)initWithTopicReplayId:(NSString *)topicReplayId;

{
    self = [super init];
    if (self) {
        
        self.cellViewModels = [NSMutableArray array];
    }
    return self;
}




- (JKSubcommentListCellVM *)assembleViewModelWithData:(JKCommentListModelData                                                               *)data{
    
    JKSubcommentListCellVM *subcellVM = [[JKSubcommentListCellVM alloc]init];
    
    subcellVM.content = data.content;
    
    CGSize size = CH_TRANSFORM_TEXTSIZE(subcellVM.content, [JKStyleConfiguration titleFont], CGSizeMake([UIScreen mainScreen].bounds.size.width - 100, MAXFLOAT));
    
    subcellVM.contentLabelHeight = size.height;
    
    
    subcellVM.cellHeight = subcellVM.contentLabelHeight + 20;

    
    self.subTableViewHeight += subcellVM.cellHeight;
    
    self.tempSubTableViewHeight += subcellVM.cellHeight;
    
    return subcellVM;
    
}


- (void)favouriteAfterCai{
    
    JKCommentZanApi *api = [[JKCommentZanApi alloc]initWithTopicReplayId:self.topicReplayId];
    
    [api startWithSuccessBlock:^(__kindof JKCommentZanApi *request) {
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            [self criticismComment];
            
        }
        else{
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }
        
        
    } failureBlock:^(__kindof JKCommentZanApi *request) {
        
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
        
    }];
    
}

- (void)favouriteComment{
    

    JKCommentZanApi *api = [[JKCommentZanApi alloc]initWithTopicReplayId:self.topicReplayId];
    
    [api startWithSuccessBlock:^(__kindof JKCommentZanApi *request) {
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            
            [self.delegate refreshSuperTableView];
            
        }
        else{
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }
        
        
    } failureBlock:^(__kindof JKCommentZanApi *request) {
        
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
        
    }];
}
- (void)criticismAfterZan{
    
    JKCommentCaiApi *api = [[JKCommentCaiApi alloc]initWithTopicReplayId:self.topicReplayId];
    
    [api startWithSuccessBlock:^(__kindof JKCommentCaiApi *request) {
        
        
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            [self favouriteComment];
            
            
        }
        else{
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }
        
        
        
    } failureBlock:^(__kindof JKCommentCaiApi *request) {
        
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
    }];

    
    
    
}
- (void)criticismComment{
    JKCommentCaiApi *api = [[JKCommentCaiApi alloc]initWithTopicReplayId:self.topicReplayId];
    
    [api startWithSuccessBlock:^(__kindof JKCommentCaiApi *request) {
        
        
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            [self.delegate refreshSuperTableView];
            
            
        }
        else{
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }
        
        
        
    } failureBlock:^(__kindof JKCommentCaiApi *request) {
        
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
    }];
 
}

- (void)turnComment{
    
    
    
}

- (void)deleteComment{
    
    UIAlertView *aAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [aAlertView show];
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        JKCommetDeleteApi *api = [[JKCommetDeleteApi alloc]initWithTopicReplayId:self.topicReplayId];
        
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
    
    
    JKCommentCreatController *vc = [[JKCommentCreatController alloc]init];
    
    vc.viewModel.titleStr = [NSString stringWithFormat:@"回复：%@楼'%@'",self.floorCount,self.content];
    
    vc.viewModel.topicId = self.topicId;
    
    vc.viewModel.parentId = self.topicReplayId;
    
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
}
@end

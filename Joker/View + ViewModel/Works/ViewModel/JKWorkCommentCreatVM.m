//
//  JKWorkCommentCreatVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkCommentCreatVM.h"
#import "JKWorkCommentCreatApi.h"
@implementation JKWorkCommentCreatVM


- (void)creatCommentWithContent:(NSString *)str{
    
    if (self.content.length > 0) {
//        JKCommentTurnModel *model = [[JKCommentTurnModel alloc]init];
//        model.content = str;
//        model.topicReplayId = self.topicId;
//        
//        JKCommentTurnApi *api = [[JKCommentTurnApi alloc]initWithCommentTurnModel:model];
//        
//        [api startWithSuccessBlock:^(__kindof JKCommentTurnApi *request) {
//            
//            if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
//                
//                [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
//                
//            }
//            else{
//                
//                [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
//            }
//        } failureBlock:^(__kindof JKCommentTurnApi *request) {
//            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
//            
//        }];
        
    }
    else{
        _content = str;
        
        JKWorkCommentCreatApi *api = [[JKWorkCommentCreatApi alloc]initWithWorkId:self.extId];
        api.content = _content;
        api.commentType = self.commentType;
        api.score = self.score;
         
        [api startWithSuccessBlock:^(__kindof JKWorkCommentCreatApi *request) {
            
            if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
                
                [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
                
            }
            else{
                
                [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            }
            
        } failureBlock:^(__kindof JKWorkCommentCreatApi *request) {
            
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }];
        
        
    }
    
    
    
    
    
}

@end

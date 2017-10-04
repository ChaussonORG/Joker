//
//  JKWorkCommentCreatVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/3.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkCommentCreatVM.h"
#import "JKWorkCommentCreatApi.h"
#import "JKChangeWorkCommentApi.h"
@implementation JKWorkCommentCreatVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.score = @"7";
    }
    return self;
}


- (void)creatCommentWithContent:(NSString *)str{
    
    if (self.content.length > 0) {
        
        JKChangeWorkCommentApi *api = [[JKChangeWorkCommentApi alloc]initWithWorkId:self.extId];
        api.content = str;
        api.commentType = self.commentType;
        api.score = self.score;
        
        [api startWithSuccessBlock:^(__kindof JKChangeWorkCommentApi *request) {
            
            if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
                
                [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
                
            }
            else{
                
                [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            }
            
        } failureBlock:^(__kindof JKChangeWorkCommentApi *request) {
            
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }];
        
        
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

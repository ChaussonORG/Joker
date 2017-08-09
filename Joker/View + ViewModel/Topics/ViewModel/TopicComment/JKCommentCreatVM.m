//
//  JKCommentCreatVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/8/8.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKCommentCreatVM.h"
#import "JKCommentCreatApi.h"
@implementation JKCommentCreatVM


- (void)creatCommentWithContent:(NSString *)str{
    
    _content = str;
     
    JKCommentCreatModel *model = [[JKCommentCreatModel alloc]init];
    model.content = _content;
    model.topicId = self.topicId;
    model.parentId = self.parentId;
    JKCommentCreatApi *api = [[JKCommentCreatApi alloc]initWithCommentCreatModel:model];
    
    [api startWithSuccessBlock:^(__kindof JKCommentCreatApi *request) {
        
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
            
        }
        else{
            
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        }
        
    } failureBlock:^(__kindof JKCommentCreatApi *request) {
        
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
    }];
    
    
    
    
    
    
}
@end

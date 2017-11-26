
//
//  JKMEVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMEVM.h"
#import "JKFavoriteCountApi.h"
#import "JKCommentCountApi.h"
#import "JKMyMessageCountApi.h"
#import "JKMySettingController.h"
@implementation JKMEVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cellViewModels = [NSMutableArray array];
        
        [self initData];
    }
    return self;
}


- (void)initData{
    
    self.name = [JKUserManager sharedData].currentUser.nickname;
    
    self.icon = [JKUserManager sharedData].currentUser.photo;
    
    NSMutableArray <JKMEListCellVM *>*cellViewModels = [NSMutableArray array];
    for (int i = 0 ; i < 5 ; i ++ ) {
        
        JKMEListCellVM   *cellVM = [[JKMEListCellVM alloc]init];
        
        
        if (i ==  0 ) {
            
            cellVM.title = @"我的消息";
        }
        else if (i ==  1 ) {
            
            cellVM.title = @"我的看玩";
        }
        else if (i ==  2 ) {
            
            cellVM.title = @"我的话题";
        }
        else if (i ==  3 ) {
            
            cellVM.title = @"修改密码";
        }
//        else if (i ==  4 ) {
//
//            cellVM.title = @"喜好设置";
//        }
        else if (i ==  4 ) {
            cellVM.title = @"退出登录";
            
        }
        
        [cellViewModels addObject:cellVM];
    }
    self.cellViewModels = [cellViewModels copy];
    
    
    JKCommentCountApi *commetApi = [[JKCommentCountApi alloc]init];
    
    [commetApi startWithSuccessBlock:^(__kindof JKCommentCountApi *request) {
        
        self.lookCount = (NSString *)request.response.responseJSONObject[@"data"];
        
    } failureBlock:^(__kindof JKCommentCountApi *request) {
        
        
        
    }];
    
    
    JKFavoriteCountApi *favorite = [[JKFavoriteCountApi alloc]init];
    
    [favorite startWithSuccessBlock:^(__kindof JKFavoriteCountApi *request) {
        
        self.favorCount = (NSString *)request.response.responseJSONObject[@"data"];
        
    } failureBlock:^(__kindof JKFavoriteCountApi *request) {
        
        
        
    }];
    JKMyMessageCountApi *myMessageApi = [[JKMyMessageCountApi alloc]init];
    [myMessageApi startWithSuccessBlock:^(__kindof JKMyMessageCountApi *request) {
        
        self.myMessageCount = (NSString *)request.response.responseJSONObject[@"data"];
        
        
        
        
    } failureBlock:^(__kindof JKMyMessageCountApi *request) {
        
        
    }];
    
}

- (void)gotoSetting{
    
    
    JKMySettingController *vc = [[JKMySettingController alloc]init];
    
    [[ASNavigator  shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
}

- (void)requestMyMessage{
    
    
    
    
    
    
}

@end

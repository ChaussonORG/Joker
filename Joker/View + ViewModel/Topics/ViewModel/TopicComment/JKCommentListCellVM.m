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
@implementation JKCommentListCellVM
- (instancetype)initWithTopicReplayId:(NSString *)topicReplayId;

{
    self = [super init];
    if (self) {
        
        self.cellViewModels = [NSMutableArray array];
    }
    return self;
}

- (void)requestData{
    
    self.isSpread = YES;
    self.tempSubTableViewHeight = 0;
     
    JKCommentListApi *api = [[JKCommentListApi alloc]initWithTopicReplayId:self.topicReplayId];

    
    [api startWithSuccessBlock:^(__kindof JKCommentListApi *request) {
        NSMutableArray  <JKSubcommentListCellVM *>*cellViewModels = [NSMutableArray array];
        
        for (JKCommentListModelData *data in request.model.data) {
            
            [cellViewModels addObject:[self assembleViewModelWithData:data]];
  
        }
  
        self.cellHeight = self.contentLabelHeight + 120 + self.tempSubTableViewHeight;
        
        self.cellViewModels = [cellViewModels copy];
        
        [self.delegate refresh];
    } failureBlock:^(__kindof JKCommentListApi *request) {
        
        
        
    }];
    
 
    
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
@end

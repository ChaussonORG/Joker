//
//  JKMyMessageVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyMessageVM.h"
#import "JKMyMessageListApi.h"
#import "CHCommonMacro.h"
#import "HHTGetString.h"

@interface JKMyMessageVM()

@property (nonatomic , assign) BOOL isFinishRequestMoreData;
@end
@implementation JKMyMessageVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cellViewModels  = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)requestData{
 
    JKMyMessageListApi *api = [[JKMyMessageListApi alloc]init];
    
    api.requestModel.limit = 20000;
    
    [api startWithSuccessBlock:^(__kindof JKMyMessageListApi *request) {
        
        NSMutableArray <JKMyMessageCellVM *>*cellViewModel = [NSMutableArray array];
        for (JKMyMessageListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleviewModelWithItem:items]];
            
        }
        
        if (cellViewModel.count < RequestLimit) {
            self.isFinishRequestMoreData = YES;
        }
        
        self.cellViewModels = [cellViewModel copy];
        
        
    } failureBlock:^(__kindof JKMyMessageListApi *request) {
        
        
    }];
}

- (JKMyMessageCellVM *)assembleviewModelWithItem:(JKMyMessageListModelItems *)items{
    
    JKMyMessageCellVM *cellVM = [[JKMyMessageCellVM alloc]init];
    
    cellVM.isRead = [items.readStatus boolValue];
    
    cellVM.icon = items.userInfo.img;
    
    cellVM.name = items.userInfo.nickname;
    
    cellVM.projectName = items.projectName;
    
    cellVM.time = [HHTGetString timeStrwithTimestamp:items.createTime];
    
    cellVM.mType = items.mType;
    
    cellVM.projectType = items.projectType;
    
    cellVM.projectId = items.projectId;
    
    cellVM.id = items.id;

    
    if ([items.projectType isEqualToString:@"MOVIE"]) {
        
        if ([items.mType isEqualToString:@"ZAN"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在电影%@的评分一个客观",cellVM.name,cellVM.projectName];
            
            cellVM.titleStr2Count = 5;
            
        }
        else if ([items.mType isEqualToString:@"CAI"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在电影%@的评分一个不客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 5;
        }
        else if ([items.mType isEqualToString:@"REPLAY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在电影%@的评分",cellVM.name,cellVM.projectName];
            
            cellVM.titleStr2Count = 7;
            
        }
        else if ([items.mType isEqualToString:@"TOPIC_REPLY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在话题%@的发言",cellVM.name,cellVM.projectName];
            
            cellVM.titleStr2Count = 7;
            
        }
    }
    else if ([items.projectType isEqualToString:@"TV"]) {
        if ([items.mType isEqualToString:@"ZAN"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在电视剧%@的评分一个客观",cellVM.name,cellVM.projectName];
            
            cellVM.titleStr2Count = 6;
            
        }
        else if ([items.mType isEqualToString:@"CAI"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在电视剧%@的评分一个不客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 6;
        }
        else if ([items.mType isEqualToString:@"REPLAY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在电视剧%@的评分",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 8;
        }
        else if ([items.mType isEqualToString:@"TOPIC_REPLY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在话题%@的发言",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 8;
        }
        
        
    }
    else if ([items.projectType isEqualToString:@"ANIMATION"]) {
        if ([items.mType isEqualToString:@"ZAN"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在动漫%@的评分一个客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 5;
        }
        else if ([items.mType isEqualToString:@"CAI"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在动漫%@的评分一个不客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 5;
        }
        else if ([items.mType isEqualToString:@"REPLAY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在动漫%@的评分",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 7;
        }
        else if ([items.mType isEqualToString:@"TOPIC_REPLY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在话题%@的发言",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 7;
        }
        
        
    }
    else if ([items.projectType isEqualToString:@"GAME"]) {
        
        if ([items.mType isEqualToString:@"ZAN"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在游戏%@的评分一个客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 5;
        }
        else if ([items.mType isEqualToString:@"CAI"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在游戏%@的评分一个不客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 5;
        }
        else if ([items.mType isEqualToString:@"REPLAY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在游戏%@的评分",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 7;
        }
        else if ([items.mType isEqualToString:@"TOPIC_REPLY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在话题%@的发言",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 7;
        }
        
    }
    else if ([items.projectType isEqualToString:@"VARIETY"]) {
        if ([items.mType isEqualToString:@"ZAN"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在综艺%@的评分一个客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 5;
        }
        else if ([items.mType isEqualToString:@"CAI"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在综艺%@的评分一个不客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 5;
        }
        else if ([items.mType isEqualToString:@"REPLAY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在综艺%@的评分",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 7;
        }
        else if ([items.mType isEqualToString:@"TOPIC_REPLY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在话题%@的发言",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 7;
        }
        
        
    }
    else if ([items.projectType isEqualToString:@"TOPIC"]) {
        if ([items.mType isEqualToString:@"ZAN"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在话题%@的评分一个客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 5;
        }
        else if ([items.mType isEqualToString:@"CAI"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@给我在话题%@的评分一个不客观",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 5;
        }
        else if ([items.mType isEqualToString:@"REPLAY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在话题%@的评分",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 7;
        }
        else if ([items.mType isEqualToString:@"TOPIC_REPLY"]) {
            
            cellVM.title = [NSString stringWithFormat:@"%@回复了我在话题%@的发言",cellVM.name,cellVM.projectName];
            cellVM.titleStr2Count = 7;
        }
        
    }
    
    CGSize titleLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.title, [JKStyleConfiguration titleFont], CGSizeMake(ScreenWidth - 85, MAXFLOAT));
    
    cellVM.titleHeight = titleLabelSize.height;
    
    
    cellVM.content = items.content;
    CGSize contentLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake(ScreenWidth - 60, MAXFLOAT));
    
    cellVM.contentHeight = contentLabelSize.height;
    
    
    if (cellVM.content.length == 0) {
    
        cellVM.cellHeight = cellVM.titleHeight + 80;
        
    }
    else{
        
        cellVM.cellHeight = cellVM.titleHeight + cellVM.contentHeight + 120;
    }
    return cellVM;
    
}
@end

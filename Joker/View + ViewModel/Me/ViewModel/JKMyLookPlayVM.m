//
//  JKMyLookPlayVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyLookPlayVM.h"
#import "JKMylookPlayCellVM.h"
#import "JKMyLookPlayFavouriteApi.h"
#import "JKMyLookPlayCommentedApi.h"

@interface JKMyLookPlayVM()

@property (nonatomic , strong) NSArray *titleArrays;

@property (nonatomic , strong) NSMutableArray <JKMylookPlayCellVM *>*cellViewModels;

@property (nonatomic , assign) BOOL isFinishRequestMoreData;

@end
@implementation JKMyLookPlayVM
- (instancetype)init
{
    self = [super init];
    if (self) {

         self.titlesArray = @[@"我的关注",@"我看过的"];

         self.titleArrays = @[@"电 影",@"电 视",@"动 画",@"游 戏",@"综 艺"];

        self.cellViewModels = [NSMutableArray array];

        self.type = JKMyLookPlayFavorited;

        self.workType = JKMyLookPlayFilm;
    }
    return self;
}


- (void)requestData{
    
    if (self.type == JKMyLookPlayFavorited) {
        
        if (self.workType == JKMyLookPlayFilm) {
            
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"MOVIE";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayTV) {
            
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"TV";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayAnimation) {
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"ANIMATION";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
            
        }
        else if (self.workType == JKMyLookPlayGame) {
            
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"GAME";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayVariety) {
            
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"VARIETY";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
        }
        
    }
    else{
        if (self.workType == JKMyLookPlayFilm) {
            
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"MOVIE";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayTV) {
            
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"TV";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayAnimation) {
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"ANIMATION";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                
                
                
            }];
            
            
        }
        else if (self.workType == JKMyLookPlayGame) {
            
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"GAME";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayVariety) {
            
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = 2000;
            api.type = @"VARIETY";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.cellViewModels = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                
                
                
            }];
            
        }
        
    }
    
    
    
    
}

- (JKMylookPlayCellVM *)assembleViewModelWithItems:(JKMyLookPlayModelItems *)items{
    JKMylookPlayCellVM *cellVM = [[JKMylookPlayCellVM alloc]init];

    cellVM.img = items.img;

    cellVM.name = items.name;
    
    cellVM.type = items.commentType;
    
    cellVM.projectId = items.id;

    cellVM.cellHeight = 130;
    
    if ([items.commentType isEqualToString:@"MOVIE"]) {

        cellVM.directors = @"导演：";
        
        cellVM.actors = @"演员：";

    }
    else if ([items.commentType isEqualToString:@"TV"]) {

        cellVM.directors = @"导演：";
        
        cellVM.actors = @"演员：";

    }
    else if ([items.commentType isEqualToString:@"ANIMATION"]) {

        cellVM.directors = @"监督：";
        
        cellVM.actors = @"声优：";
    }
    else if ([items.commentType isEqualToString:@"GAME"]) {

        cellVM.directors = @"";

    }
    else if ([items.commentType isEqualToString:@"VARIETY"]) {

        cellVM.directors = @"主持人：";
        
        cellVM.actors = @"嘉宾：";

    }
    else{


    }
    for ( int i = 0 ; i <items.actors1.count;i ++) {
        NSString *director = items.actors1[i];
        
        if (i == 0) {
            cellVM.directors = [NSString stringWithFormat:@"%@%@",cellVM.directors,director];
        }
        else{
            
            cellVM.directors = [NSString stringWithFormat:@"%@／%@",cellVM.directors,director];
        }
        
    }
    
    for (int i = 0 ; i <items.actors2.count;i ++) {
        NSString *actor = items.actors2[i];
        if (i == 0) {
            cellVM.actors = [NSString stringWithFormat:@"%@%@",cellVM.actors,actor];
        }
        else{
            
            cellVM.actors = [NSString stringWithFormat:@"%@／%@",cellVM.actors,actor];
        }
        
        
    }
    
    
    if ([items.commentType isEqualToString:@"ANIMATION"]) {
        
        cellVM.actors = @"声优：";
        
        
        for (int i = 0 ; i <items.actors3.count;i ++) {
            NSString *actor = items.actors3[i];
            if (i == 0) {
                cellVM.actors = [NSString stringWithFormat:@"%@%@",cellVM.actors,actor];
            }
            else{
                
                cellVM.actors = [NSString stringWithFormat:@"%@／%@",cellVM.actors,actor];
            }
            
            
        }
        
    }
    
 

    return cellVM;
}

@end

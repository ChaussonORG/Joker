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
#import "CHCommonMacro.h"
@interface JKMyLookPlayVM()

@property (nonatomic , strong) NSArray *titleArrays;

@property (nonatomic , strong) NSMutableArray <JKMylookPlayCellVM *>*favouritedFilmCellVMs;

@property (nonatomic , strong) NSMutableArray <JKMylookPlayCellVM *>*favouritedTVCellVMs;

@property (nonatomic , strong) NSMutableArray <JKMylookPlayCellVM *>*favouritedGameCellVMs;

@property (nonatomic , strong ) NSMutableArray <JKMylookPlayCellVM *>*favouritedAnimationCellVMs;

@property (nonatomic , strong ) NSMutableArray <JKMylookPlayCellVM *>*favouritedVarietyCellVMs;

@property (nonatomic , strong) NSMutableArray <JKMylookPlayCellVM *>*lookedFilmCellVMs;

@property (nonatomic , strong) NSMutableArray <JKMylookPlayCellVM *>*lookedTVCellVMs;

@property (nonatomic , strong) NSMutableArray <JKMylookPlayCellVM *>*lookedGameCellVMs;

@property (nonatomic , strong) NSMutableArray <JKMylookPlayCellVM *>*lookedAnimationCellVMs;

@property (nonatomic , strong) NSMutableArray <JKMylookPlayCellVM *>*lookedVarietyCellVMs;

@property (nonatomic , assign) BOOL isFinishRequestMoreData;

@end
@implementation JKMyLookPlayVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.titlesArray = @[@"我的关注",@"我看过的"];
        
        self.titleArrays = @[@"电 影",@"电 视",@"动 画",@"游 戏",@"综 艺"];
        
        self.type = JKMyLookPlayFavorited;
        
        self.workType = JKMyLookPlayFilm;
        
        self.favouritedFilmCellVMs = [NSMutableArray array];
        
        self.favouritedTVCellVMs = [NSMutableArray array];
        
        self.favouritedAnimationCellVMs = [NSMutableArray array];
        
        self.favouritedGameCellVMs = [NSMutableArray array];
        
        self.favouritedVarietyCellVMs = [NSMutableArray array];
        
        self.lookedFilmCellVMs = [NSMutableArray array];
        
        self.lookedTVCellVMs = [NSMutableArray array];
        
        self.lookedAnimationCellVMs = [NSMutableArray array];
        
        self.lookedGameCellVMs = [NSMutableArray array];
        
        self.lookedVarietyCellVMs = [NSMutableArray array];
        
    }
    return self;
}
- (void)loadData{
    
    JKMyLookPlayFavouriteApi *favouritedFilmApi = [[JKMyLookPlayFavouriteApi alloc]init];
    favouritedFilmApi.requestModel.limit = RequestLimit;
    favouritedFilmApi.type = @"MOVIE";
    
    [favouritedFilmApi startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.favouritedFilmCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        
        
        
    }];
    
    
    JKMyLookPlayFavouriteApi *favouritedTVApi = [[JKMyLookPlayFavouriteApi alloc]init];
    favouritedTVApi.requestModel.limit = RequestLimit;
    favouritedTVApi.type = @"TV";
    
    [favouritedTVApi startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.favouritedTVCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        
        
        
    }];
    
    
    JKMyLookPlayFavouriteApi *favouritedAnimationApi = [[JKMyLookPlayFavouriteApi alloc]init];
    favouritedAnimationApi.requestModel.limit = RequestLimit;
    favouritedAnimationApi.type = @"ANIMATION";
    
    [favouritedAnimationApi startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.favouritedAnimationCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        
        
        
    }];
    
    
    
    JKMyLookPlayFavouriteApi *favouritedGameApi = [[JKMyLookPlayFavouriteApi alloc]init];
    favouritedGameApi.requestModel.limit = RequestLimit;
    favouritedGameApi.type = @"GAME";
    
    [favouritedGameApi startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.favouritedGameCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        
        
        
    }];
    
    
    
    JKMyLookPlayFavouriteApi *favouritedVarietyApi = [[JKMyLookPlayFavouriteApi alloc]init];
    favouritedVarietyApi.requestModel.limit = RequestLimit;
    favouritedVarietyApi.type = @"VARIETY";
    
    [favouritedVarietyApi startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.favouritedVarietyCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
        
        
        
        
    }];
    
    
    
    JKMyLookPlayCommentedApi *lookedFilmApi = [[JKMyLookPlayCommentedApi alloc]init];
    lookedFilmApi.requestModel.limit = RequestLimit;
    lookedFilmApi.type = @"MOVIE";
    
    [lookedFilmApi startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.lookedFilmCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        
        
        
    }];
    
    
    JKMyLookPlayCommentedApi *lookedTVApi = [[JKMyLookPlayCommentedApi alloc]init];
    lookedTVApi.requestModel.limit = RequestLimit;
    lookedTVApi.type = @"TV";
    
    [lookedTVApi startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.lookedTVCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        
        
        
    }];
    
    
    JKMyLookPlayCommentedApi *lookedAnimationApi = [[JKMyLookPlayCommentedApi alloc]init];
    lookedAnimationApi.requestModel.limit = RequestLimit;
    lookedAnimationApi.type = @"ANIMATION";
    
    [lookedAnimationApi startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.lookedAnimationCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        
        
        
    }];
    
    
    
    JKMyLookPlayCommentedApi *lookedGameApi = [[JKMyLookPlayCommentedApi alloc]init];
    lookedGameApi.requestModel.limit = RequestLimit;
    lookedGameApi.type = @"GAME";
    
    [lookedGameApi startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.lookedGameCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        
        
        
    }];
    
    
    JKMyLookPlayCommentedApi *lookedVarietyApi = [[JKMyLookPlayCommentedApi alloc]init];
    lookedVarietyApi.requestModel.limit = RequestLimit;
    lookedVarietyApi.type = @"VARIETY";
    
    [lookedVarietyApi startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyLookPlayModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.lookedVarietyCellVMs = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
        
        
        
        
    }];
    
     
}

- (void)requestData{
    
    if (self.type == JKMyLookPlayFavorited) {
        
        if (self.workType == JKMyLookPlayFilm) {
            
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"MOVIE";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.favouritedFilmCellVMs = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayTV) {
            
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"TV";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.favouritedTVCellVMs = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayAnimation) {
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"ANIMATION";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.favouritedAnimationCellVMs = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
            
        }
        else if (self.workType == JKMyLookPlayGame) {
            
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"GAME";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.favouritedGameCellVMs = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayVariety) {
            
            JKMyLookPlayFavouriteApi *api = [[JKMyLookPlayFavouriteApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"VARIETY";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.favouritedVarietyCellVMs = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayFavouriteApi *request) {
                
                
                
                
            }];
            
        }
        
    }
    else{
        if (self.workType == JKMyLookPlayFilm) {
            
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"MOVIE";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.lookedFilmCellVMs = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayTV) {
            
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"TV";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.lookedTVCellVMs = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayAnimation) {
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"ANIMATION";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.lookedAnimationCellVMs = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                
                
                
            }];
            
            
        }
        else if (self.workType == JKMyLookPlayGame) {
            
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"GAME";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.lookedGameCellVMs = [cellViewModels copy];
                
            } failureBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                
                
                
            }];
            
        }
        else if (self.workType == JKMyLookPlayVariety) {
            
            JKMyLookPlayCommentedApi *api = [[JKMyLookPlayCommentedApi alloc]init];
            api.requestModel.limit = RequestLimit;
            api.type = @"VARIETY";
            
            [api startWithSuccessBlock:^(__kindof JKMyLookPlayCommentedApi *request) {
                
                NSMutableArray <JKMylookPlayCellVM*>*cellViewModels = [NSMutableArray array];
                for (JKMyLookPlayModelItems *items in request.model.data.items) {
                    
                    [cellViewModels addObject:[self assembleViewModelWithItems:items]];
                    
                }
                
                self.lookedVarietyCellVMs = [cellViewModels copy];
                
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
    
    cellVM.score = items.jokerScore;
    
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


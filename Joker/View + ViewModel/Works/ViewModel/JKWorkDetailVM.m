//
//  JKWorkDetailVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/30.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkDetailVM.h"
#import "JKFilmDetailApi.h"
#import "JKTopicsListApi.h"
#import "CHCommonMacro.h"
#import "HHTGetString.h"
#import "JKUserManager.h"
#import "JKWorkCommentApi.h"
#import "JKFavoriteWorkApi.h"
#import "JKUnfavoriteWorkApi.h"
#import "JKWorkCommentCreatController.h"
#import "CHLoginModalController.h"
#import "JKTopicCreateController.h"

@interface JKWorkDetailVM()<WorkrefreshSuperTableViewDelegate,CHLoginModalControllerDelegate>

@property (nonatomic , strong) NSArray *titlesArray;

@property (nonatomic , assign) BOOL isLogined;

@property  (nonatomic , assign) NSInteger commentCount;


@end
@implementation JKWorkDetailVM

- (instancetype)initWithWorkId:(NSString *)workId
{
    self = [super init];
    if (self) {
        
        _workId = workId;
        
        
        self.directorsArr = [NSMutableArray array];
        
        self.titlesArray = @[@"信 息",@"评 论",@"话 题"];
       
        self.filterType = JKFilmDataInfo;
        
        self.topicCellVMs = [NSMutableArray array];
        
        self.topCellVMs = [NSMutableArray array];
        
        self.bottemCellVMs = [NSMutableArray array];
        
        self.commentCellVMs = [NSMutableArray array];
        
        self.myCellVMs = [NSMutableArray array];
    }
    return self;
}
- (void)requestData{
    
    self.directorsArr = [NSMutableArray array];
    
    JKFilmDetailApi *api = [[JKFilmDetailApi alloc]initWithWorkId:self.workId];
    
    [api startWithSuccessBlock:^(__kindof JKFilmDetailApi *request) {
        
        self.favoritedSize = request.model.data.favoritedSize;
        
        self.commentSize = request.model.data.commentSize;
        
        self.isfavorited = [request.model.data.favorited boolValue];
        
        self.workImage = request.model.data.coverImage;
        
        self.workBgImage = self.workImage;//[NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fixed,h_300,w_500",self.workImage];
        
        self.name = request.model.data.name;
        self.strOne = @"";
        for (NSString *str1 in request.model.data.types) {
            
            if (self.strOne.length > 0) {
                 self.strOne = [NSString stringWithFormat:@"%@ %@",self.strOne,str1];
            }
            else{
                self.strOne = str1;
                
            }
           
        }
        self.strTwo = @"";
        for (int i = 0 ; i <request.model.data.areas.count; i ++) {
            
            NSString *str2 = request.model.data.areas[i];
            
            if (i < 2) {
                if (self.strTwo.length > 0) {
                    self.strTwo = [NSString stringWithFormat:@"%@ %@",self.strTwo,str2];
                }
                else{
                    self.strTwo = str2;
                    
                }

            }
            else{
                self.strTwo = [NSString stringWithFormat:@"%@...",self.strTwo];
                
            }
            
            
        }
        
        if (![request.model.data.duration isEqualToString:@"null分钟"]) {
            self.strTwo = [NSString stringWithFormat:@"%@/%@",self.strTwo,request.model.data.duration];
        }
          
        
        if (request.model.data.releaseDate) {
            self.strThree = [NSString stringWithFormat:@"%@上映",request.model.data.releaseDate];
        }
    
        
        
        self.score1 = [self reviseString:request.model.data.doubanScore];
        
        self.score2 = [self reviseString:request.model.data.imdbScore];
        
        self.score3 = [self reviseString:request.model.data.tomatoeScore];
        
        self.score4 = [self reviseString:request.model.data.mcScore];
        
        self.jokerScore = request.model.data.jokerScore;
        
        self.imageArrs = request.model.data.coverImageList;
        
        if (!request.model.data.desc) {
            
            self.desc = [JKStyleConfiguration convertNull:request.response.responseJSONObject[@"data"][@"desc"]];
        }
        else{
            self.desc = request.model.data.desc;
        }
        
        
        
        for (JKFilmDetailModelStaff *staff in request.model.data.staff) {
            
            [self.directorsArr addObject:[self assembleViewModelWithStaff:staff]];
        }
        
        if (self.directorsArr.count%4 == 0 &&self.directorsArr.count<10) {
            self.directorsCellHeight =(self.directorsArr.count/4 )*110 +36;
        }
        else{
            
            if (self.directorsArr.count > 8) {
                 self.directorsCellHeight =2*110 + 36;
            }
            else{
                 self.directorsCellHeight =(self.directorsArr.count/4 + 1)*110 + 36;
                
            }
           
        }
        
        CGSize descLabelSize =  CH_TRANSFORM_TEXTSIZE(self.desc, [JKStyleConfiguration titleFont], CGSizeMake(ScreenWidth - 40, MAXFLOAT));
        
        self.descCellHeight = descLabelSize.height + 36 + 40;

        if (self.imageArrs.count%4 == 0) {
            self.imagesCellHeight =(self.imageArrs.count/4 )*((ScreenWidth - 35)/4 + 10) +36;
        }
        else{
            
            if (self.imageArrs.count%4 < 4) {
                self.imagesCellHeight =(self.imageArrs.count/4 + 1)*((ScreenWidth - 35)/4 + 10)+36;
            }
            else{
                
                self.imagesCellHeight =(self.imageArrs.count/4)*((ScreenWidth - 35)/4 + 10)+36;
            }
            
        }
        
        
    } failureBlock:^(__kindof JKFilmDetailApi *request) {
        
        
        
    }];
    
    
    [self requestTopicData];
    
    [self requestCommentData];
}

- (void)requestTopicData{
    
    
    JKTopicsListApi *api = [[JKTopicsListApi alloc]initTopicFilm];
    api.projectId = self.workId;
    
    api.requestModel.limit = RequestLimit;
    
    [api startWithSuccessBlock:^(__kindof JKTopicsListApi *request) {
        
        NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray array];
        for (JKTopicListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleTopicViewModelWithItem:items]];
            
            
        }
        
//        if (cellViewModel.count < RequestLimit) {
//            self.isFinishRequestMoreData = YES;
//        }
        
        self.topicCellVMs = [cellViewModel copy];
        
    } failureBlock:^(__kindof JKTopicsListApi *request) {
        
    }];

    
}

- (void)requestCommentData{
    
    JKWorkCommentApi *api = [[JKWorkCommentApi alloc]initWithWorkId:self.workId];
    
    api.commentType = @"MOVIE";
    
    api.requestModel.limit = RequestLimit;
    
    [api startWithSuccessBlock:^(__kindof JKWorkCommentApi *request) {
        
        NSMutableArray <JKWorkCommentListCellVM *>*myCellViewModels = [NSMutableArray array];
        
        for (NSInteger i = 0 ; i < request.model.data.mineComment.count ; i ++) {
            
            JKWorkCommentModelItems *list  = request.model.data.mineComment[i];
            
            [myCellViewModels addObject:[self assembleViewModelWithList:list withIndex:0]];
        }
        
        self.myCellVMs = [myCellViewModels copy];
        
        NSMutableArray <JKWorkCommentListCellVM *>*topCellViewModels = [NSMutableArray array];
        
        for (NSInteger i = 0 ; i < request.model.data.favourComment.count ; i ++) {
            
            JKWorkCommentModelItems *list  = request.model.data.favourComment[i];
            
            [topCellViewModels addObject:[self assembleViewModelWithList:list withIndex:0]];
        }
        
        self.topCellVMs = [topCellViewModels copy];
        
        
        NSMutableArray <JKWorkCommentListCellVM *>*bottomCellViewModels = [NSMutableArray array];
        
        for (NSInteger i = 0 ; i < request.model.data.disgustComment.count ; i ++) {
            
            JKWorkCommentModelItems *list  = request.model.data.disgustComment[i];
            
            [bottomCellViewModels addObject:[self assembleViewModelWithList:list withIndex:0]];
        }
        
        self.bottemCellVMs = [bottomCellViewModels copy];
        
        NSMutableArray <JKWorkCommentListCellVM *>*cellViewModels = [NSMutableArray array];
        
        self.commentCount = [request.model.data.total integerValue];
        
        for (NSInteger i = 0 ; i < request.model.data.items.count ; i ++) {
            
            JKWorkCommentModelItems *list  = request.model.data.items[i];
            
            [cellViewModels addObject:[self assembleViewModelWithList:list withIndex:self.commentCount - i]];
        }
        
        self.commentCellVMs = [cellViewModels copy];
        
        
        
    } failureBlock:^(__kindof JKWorkCommentApi *request) {
        
        
    }];
    
    
}

- (NSString *)reviseString:(NSString *)string{
    
    double conversionValue = (double)[string doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf",conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    
    
    return [decNumber stringValue];
}
- (JKWorkCommentListCellVM *)assembleViewModelWithList:(JKWorkCommentModelItems                                                               *)list withIndex:(NSInteger)index{
    
    JKWorkCommentListCellVM *cellVM = [[JKWorkCommentListCellVM alloc]init];
    
    
    cellVM.score =  [self reviseString:list.score];
    
    cellVM.delegate = self;
    
//    cellVM.topicId = list.extId;
    
    cellVM.extId = list.id;
    
    cellVM.name = list.appUser.nickname;
    
    cellVM.headerUrl = list.appUser.photo;
    
    cellVM.likeCount = list.favour;
    
    cellVM.disgustCount = list.disgust;
    
    if ([list.favotite isEqualToString:@"1"]) {
        
        cellVM.commentStatus = JKWorkCommentZan;
    }
    else if ([list.favotite isEqualToString:@"0"]) {
        
        cellVM.commentStatus  = JKWorkCommentCai;
    }
    else{
        
        cellVM.commentStatus  = JKWorkCommentWeipinglun;
    }
    CGSize nameLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.name, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.nameLabelWeight = nameLabelSize.width;
    
//    cellVM.time =  [HHTGetString timeStrwithTimestamp:list.createTime];
    
    if ([list.appUser.userId isEqualToString:[JKUserManager sharedData].currentUser.userId]) {
        
        cellVM.isMyComment = YES;
    }
    else{
        
        cellVM.isMyComment = NO;
        
    }
//    cellVM.quoteAutor = list.replyInfo.author.nickname;
    
    CGSize quoteAutorLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.quoteAutor, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.quoteAutorLabelWidth = quoteAutorLabelSize.width;
    
//    cellVM.quoteContent = list.replyInfo.content;
    
    CGSize quoteContentLabelSize = CH_TRANSFORM_TEXTSIZE(cellVM.quoteContent, [JKStyleConfiguration titleFont], CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, MAXFLOAT));
    
    cellVM.quoteContentLabelHeight = quoteContentLabelSize.height;
    
    if (cellVM.quoteContent) {
        cellVM.quoteViewHeight = cellVM.quoteContentLabelHeight + 40 + 10;
        
        cellVM.quoteFloor = @"引用@";
        
        CGSize quoteFloorLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.quoteFloor, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
        
        cellVM.quoteFloorLabelWidth = quoteFloorLabelSize.width;
    }
    else{
        
        cellVM.quoteViewHeight = cellVM.quoteContentLabelHeight;
    }
    
    
    if (index == 0) {
        
        
        
    }else{
        
        cellVM.floorCount = [NSString stringWithFormat:@"%ld",index];
    }
    
    cellVM.content = list.content;
    
    CGSize size = CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT));
    
    cellVM.contentLabelHeight = size.height;
    
    cellVM.cellHeight = 75 + cellVM.contentLabelHeight + cellVM.quoteViewHeight + 45;
    
    return cellVM;
    
    
}

- (JKTopicListCellVM *)assembleTopicViewModelWithItem:(JKTopicListModelItems *)items{
    
    JKTopicListCellVM *cellVM = [[JKTopicListCellVM alloc]init];
    
    cellVM.headerUrl = items.icon;
    
    cellVM.name = items.nickname;
    
    cellVM.time = [HHTGetString timeStrwithTimestamp:items.createTime];
    
    cellVM.related = items.projectName;
    
    cellVM.commentCount = items.topicReplayCount;
    
    cellVM.topicId = items.topicId;
    
    cellVM.projectId = items.projectId;
    
    JKTopicListModelTopicContentBeans *bean = items.topicContentBeans[0];
    
    //    cellVM.content = bean.content;
    
    cellVM.content = items.title;
    
    CGSize nameLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.name, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.nameLabelWeight = nameLabelSize.width;
    
    CGSize contentLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake(ScreenWidth - 50, MAXFLOAT));
    
    cellVM.contentLabelHeight = contentLabelSize.height;
    
    
    cellVM.cellHeight = 110 + cellVM.contentLabelHeight;
    
    return cellVM;
    
}

- (JKFilmStaffCellVM *)assembleViewModelWithStaff:(JKFilmDetailModelStaff *)staff{
    
    JKFilmStaffCellVM *cellVM = [[JKFilmStaffCellVM alloc]init];
    
    cellVM.personId = staff.personId;
    
    cellVM.name = staff.name;
    
    cellVM.actName = staff.actName;
    
    cellVM.degree = staff.degree;
    
    cellVM.img = staff.img;
    
    return cellVM;
}
- (void)checkLogin{
    
    if ([[JKUserManager sharedData] isUserEffective]) {
        self.isLogined = YES;
    }
    else{
        self.isLogined = NO;
    }
    
}
- (void)requestMoreData{
    
    if (self.filterType == JKFilmDataComment) {
        
        [self  requestMoreCommentData];
    }
    else if(self.filterType == JKFilmDataTopic){
        
        [self  requestMoreTopicData];
        
        
    }
    
    
    
}

- (void)requestMoreTopicData{
    
    
    JKTopicsListApi *api = [[JKTopicsListApi alloc]initTopicFilm];
    api.projectId = self.workId;
    
    api.requestModel.limit = RequestLimit;
    
    [api startWithSuccessBlock:^(__kindof JKTopicsListApi *request) {
        
        NSMutableArray <JKTopicListCellVM *>*cellViewModel = [NSMutableArray array];
        for (JKTopicListModelItems *items in request.model.data.items) {
            
            [cellViewModel addObject:[self assembleTopicViewModelWithItem:items]];
            
            
        }
        
        //        if (cellViewModel.count < RequestLimit) {
        //            self.isFinishRequestMoreData = YES;
        //        }
        
        self.topicCellVMs = [cellViewModel copy];
        
    } failureBlock:^(__kindof JKTopicsListApi *request) {
        
    }];
    
    
}

- (void)requestMoreCommentData{
    
    JKWorkCommentApi *api = [[JKWorkCommentApi alloc]initWithWorkId:self.workId];
    
    api.commentType = @"MOVIE";
    
    api.requestModel.limit = RequestLimit;
    
    api.requestModel.offset = self.commentCellVMs.count;
    
    [api startWithSuccessBlock:^(__kindof JKWorkCommentApi *request) {
        
        
//        NSMutableArray <JKWorkCommentListCellVM *>*topCellViewModels = [NSMutableArray array];
//        
//        for (NSInteger i = 0 ; i < request.model.data.favourComment.count ; i ++) {
//            
//            JKWorkCommentModelItems *list  = request.model.data.favourComment[i];
//            
//            [topCellViewModels addObject:[self assembleViewModelWithList:list withIndex:0]];
//        }
//        
//        self.topCellVMs = [topCellViewModels copy];
//        
//        
//        NSMutableArray <JKWorkCommentListCellVM *>*bottomCellViewModels = [NSMutableArray array];
//        
//        for (NSInteger i = 0 ; i < request.model.data.disgustComment.count ; i ++) {
//            
//            JKWorkCommentModelItems *list  = request.model.data.disgustComment[i];
//            
//            [bottomCellViewModels addObject:[self assembleViewModelWithList:list withIndex:0]];
//        }
//        
//        self.bottemCellVMs = [bottomCellViewModels copy];
        
        NSMutableArray <JKWorkCommentListCellVM *>*cellViewModels = [NSMutableArray arrayWithArray:self.commentCellVMs];
        
        self.commentCount = [request.model.data.total integerValue];
        
        for (NSInteger i = 0 ; i < request.model.data.items.count ; i ++) {
            
            JKWorkCommentModelItems *list  = request.model.data.items[i];
            
            [cellViewModels addObject:[self assembleViewModelWithList:list withIndex:self.commentCount - i]];
        }
        
        self.commentCellVMs = [cellViewModels copy];
        
        
        
    } failureBlock:^(__kindof JKWorkCommentApi *request) {
        
        
    }];
    
    
}


- (void)favoriteWork{
    
    
    
    if ([[JKUserManager sharedData] isUserEffective]) {
        
        if (self.isfavorited) {
            
            JKUnfavoriteWorkApi *api = [[JKUnfavoriteWorkApi alloc]initWithWorkId:self.workId];
            api.type = @"MOVIE";
            
            [api startWithSuccessBlock:^(__kindof JKUnfavoriteWorkApi *request) {
                
                if([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
                    
                    [self requestData];
                }
                else{
                    
                    [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"] ];
                }
                
            } failureBlock:^(__kindof JKUnfavoriteWorkApi *request) {
                
                
                [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"] ];
            }];
            
        }
        else{
            
            
            JKFavoriteWorkApi *api = [[JKFavoriteWorkApi alloc]initWithWorkId:self.workId];
            api.type = @"MOVIE";
            
            [api startWithSuccessBlock:^(__kindof JKFavoriteWorkApi *request) {
                
                if([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
                    
                    [self requestData];
                }
                else{
                    
                    [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"] ];
                }
            } failureBlock:^(__kindof JKFavoriteWorkApi *request) {
                
                [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"] ];
                
            }];
        }
    }
    else{
        
        [self login];
    }
    
}

- (void)commentWork{
  
    
    if ([[JKUserManager sharedData] isUserEffective]) {
        
        JKWorkCommentCreatController *vc = [[JKWorkCommentCreatController alloc]init];
        vc.viewModel.titleStr = [NSString stringWithFormat:@"评论：%@",self.name];
        vc.viewModel.extId = self.workId;
        
        vc.viewModel.commentType = @"MOVIE";
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    else{
        
        [self login];
    }
 
}

- (void)login
{
    CHLoginModalController *vc = [[CHLoginModalController alloc] init];
    vc.delegate = self;
    [[ASNavigator shareModalCenter].fetchCurrentViewController presentViewController:vc animated:YES completion:nil];
}
- (void)ch_willCompletionWithSuccess:(NSDictionary *)info
{
    [[JKUserManager sharedData] saveUserWithInfo:info];
    
    
}

-(void)refreshSuperTableView{
    
    
    
    [self.delegate tableViewReload];
}

- (void)createTopic{
    
    if (self.isLogined) {
        
        JKTopicCreateController *vc = [[JKTopicCreateController alloc]init];
         
        vc.viewModel.relateWorkName = self.name;
        
        vc.viewModel.type = @"MOVIE";
        
        vc.viewModel.projectId = self.workId;
        
        vc.viewModel.isWithWork = YES;
        
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    }
    
    
}

@end

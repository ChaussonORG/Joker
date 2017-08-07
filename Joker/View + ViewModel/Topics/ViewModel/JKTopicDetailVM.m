//
//  JKTopicDetailVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicDetailVM.h"
#import "CHCommonMacro.h"
#import "JKTopicDetailApi.h"
#import "HHTGetString.h"
#import "JKTopicDetailCommentListApi.h"
#import "JKTopicDetailTopcomentApi.h"
#import "JKUserManager.h"
#import "CHLoginModalController.h"
#import "CHNetworkConfig.h"
@interface JKTopicDetailVM()<TopicDetailBottomDelegate,CHLoginModalControllerDelegate>

@property (nonatomic , assign) NSInteger offset;

@property (nonatomic , strong) NSString *detailHtmlStr;

@end

@implementation JKTopicDetailVM
- (instancetype)initWithTopicId:(NSString *)topicId
{
    self = [super init];
    if (self) {
        
        _topicId = topicId;
        
        self.bottomVM = [[JKTopicDetailBottomVM alloc]init];
        
        self.bottomVM.delegate = self;
        
        self.cellVMs = [NSMutableArray array];
        
        self.topCellVMs = [NSMutableArray array];
        
        self.bottemCellVMs = [NSMutableArray array];
        
        self.offset = 0;
        
        
        
    }
    return self;
}


- (void)requestData{
    
    
    JKTopicDetailApi *api = [[JKTopicDetailApi alloc]initWithTopicId:self.topicId];
    
    [api startWithSuccessBlock:^(__kindof JKTopicDetailApi *request) {
        
        self.bottomVM.pageCount = ceil([request.model.data.commentCount doubleValue]/PAGELIMIT) == 0?1: ceil([request.model.data.commentCount doubleValue]/PAGELIMIT) ;
        self.detailHtmlStr = request.model.data.url;
//        
//        self.detailHtmlStr =@"<p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>新华社记者周效政 杨士龙 王文</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>美国佛罗里达州诺顿艺术博物馆中国馆馆长巴恩斯发现，近来展厅访客明显增多，其中不乏媒体记者。这和中美元首即将举行的会晤密不可分，而会晤举行地——棕榈滩的海湖庄园距博物馆不到10分钟车程。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>中美两国3月30日同时宣布，中美元首将于4月6日至7日在美国佛罗里达州海湖庄园举行会晤。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>美国白宫发言人肖恩·斯派塞在3月底举行的例行记者会上说，两位领导人“将就各自的优先工作重点交换意见，并为两国关系规划一条前进路线”。双方还将讨论相互关切的其他重大问题。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>斯派塞还表示，这次会晤将为美国总统特朗普与中国国家主席习近平建立私人关系提供一个机会。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>美国前驻华大使芮效俭日前在美国智库战略与国际问题研究中心举行的研讨会上说，两位领导人将通过会晤更好地了解对方，并力图建立有助双方共同应对各种问题的关系。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>芮效俭还说，两国元首应在会晤中既讨论双方有共同利益的问题，同时也以相互尊重的方式就两国存在的分歧进行磋商。如果双方以力图取得进展而非制造障碍的方式进行沟通，则有望在十分困难的问题上取得进展。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>哈佛大学教授约瑟夫·奈表示，美中元首保持良好沟通接触一直以来都很重要。他希望此次会晤能充分表明，合作给美中两国带来的好处将远远大于分歧。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>美国前副国务卿、基辛格咨询公司副总裁罗伯特·霍马茨认为，两国元首面对面会谈，将向外界传递“美中互不视对方为对手且愿意开展合作”的明确信号。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>霍马茨指出，从引领世界经济较快走出金融危机阴影，到应对恐怖主义、气候变化、核扩散等一系列重大挑战，事实证明世界的稳定与发展离不开美中两国的紧密合作。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>虽然会晤时间很短，但美国各界人士普遍希望，两国元首就一系列双边、地区和国际问题深入坦诚地交换意见。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>宾夕法尼亚大学教授金骏远说，希望此次会晤有助于两位领导人充分了解对方对“双边关系的总体看法”，为未来开展合作、管控分歧制定“总体路线图”。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>卡内基国际和平基金会高级研究员史文希望，本次会晤能够推动两国在“加深相互了解和建立更坚固可行的关系”方面迈出关键一步。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>科罗拉多州州长约翰·希肯卢珀表示，中国在国际事务中的巨大影响力不容忽视，希望特朗普总统能把中国视为一个重要合作伙伴。</p><p style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; font-size: 16px; padding: 0px; margin-bottom: 28px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34); text-align: justify; text-indent: 2em;'>加利福尼亚州旅游业全球推广机构“访问加利福尼亚”总裁卡罗琳·贝特塔注意到，此次海湖庄园会晤跳出“办公室围墙和仪规束缚”，这种沟通交流无疑有助于加深领导人之间的关系。（完）&nbsp;<span class='ifengLogo' style='vertical-align: baseline; font-weight: inherit; font-family: SimSun, Arial; font-style: inherit; padding: 0px; margin: 0px; border: 0px;'><a href='http://www.ifeng.com/' target='_blank' style='vertical-align: baseline; font-family: &quot;Microsoft YaHei&quot;; padding: 0px; margin: 0px; border: 0px; font-stretch: normal; line-height: 28px; color: rgb(34, 34, 34);'><img src='http://p2.ifengimg.com/a/2016/0810/204c433878d5cf9size1_w16_h16.png' style='vertical-align: baseline; font-weight: inherit; font-family: SimSun, Arial; font-style: inherit; padding: 0px; margin: 0px auto; display: inline; max-width: 640px; height: auto;'></a></span></p>";
        
    } failureBlock:^(__kindof JKTopicDetailApi *request) {
        
        
        
    }];
    
    
    [self requestComment];
   
}

- (void)requestComment{
    
    JKTopicDetailTopcomentApi *topApi = [[JKTopicDetailTopcomentApi alloc]initWithTopicId:self.topicId];
    topApi.commentType = @"true";
    
    topApi.requestModel.limit = PAGELIMIT;
    
    topApi.requestModel.offset = 0;
    
    [topApi startWithSuccessBlock:^(__kindof JKTopicDetailTopcomentApi *request) {
    
        NSMutableArray <JKCommentListCellVM *>*topCellViewModels = [NSMutableArray array];
    
        for (JKTopicDetailCommentListModelTopicReplayPojoList *list in request.model.data) {
            
            [topCellViewModels addObject:[self assembleViewModelWithList:list]];
            
        }
        self.topCellVMs = [topCellViewModels copy];
        
        
    } failureBlock:^(__kindof JKTopicDetailTopcomentApi *request) {
        
        
        
    }];
    
    
    JKTopicDetailTopcomentApi *bottomApi = [[JKTopicDetailTopcomentApi alloc]initWithTopicId:self.topicId];
    
    bottomApi.commentType = @"flase";
    
    bottomApi.requestModel.limit = PAGELIMIT;
    
    bottomApi.requestModel.offset = 0;
    
    [bottomApi startWithSuccessBlock:^(__kindof JKTopicDetailTopcomentApi *request) {
     
        NSMutableArray <JKCommentListCellVM *>*bottomCellViewModels = [NSMutableArray array];
        for (JKTopicDetailCommentListModelTopicReplayPojoList *list in request.model.data) {
            
            [bottomCellViewModels addObject:[self assembleViewModelWithList:list]];
            
        }
        self.bottemCellVMs = [bottomCellViewModels copy];
        
    } failureBlock:^(__kindof JKTopicDetailTopcomentApi *request) {
        
        
        
    }];
    
    JKTopicDetailCommentListApi *api = [[JKTopicDetailCommentListApi alloc]initWithTopicId:self.topicId];
    
    api.requestModel.limit = PAGELIMIT;
    
    api.requestModel.offset = self.offset;
    
    [api startWithSuccessBlock:^(__kindof JKTopicDetailCommentListApi *request) {
        NSMutableArray <JKCommentListCellVM *>*cellViewModels = [NSMutableArray array];
        
        NSMutableArray <JKCommentListCellVM *>*topCellViewModels = [NSMutableArray array];
        
        NSMutableArray <JKCommentListCellVM *>*bottomCellViewModels = [NSMutableArray array];
        for (JKTopicDetailCommentListModelTopicReplayPojoList *list in request.model.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithList:list]];
            
        }
        self.cellVMs = [cellViewModels copy];
        
        
    } failureBlock:^(__kindof JKTopicDetailCommentListApi *request) {
        
        
        
    }];
    
}

- (JKCommentListCellVM *)assembleViewModelWithList:(JKTopicDetailCommentListModelTopicReplayPojoList                                                               *)list{
    
    JKCommentListCellVM *cellVM = [[JKCommentListCellVM alloc]init];
    
    cellVM.name = list.author.nickname;
    
    cellVM.headerUrl = list.author.icon;
    
    cellVM.likeCount = list.likeCount;
    
    cellVM.disgustCount = list.disgustCount;
    
    CGSize nameLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.name, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.nameLabelWeight = nameLabelSize.width;
    
    cellVM.time =  [HHTGetString timeStrwithTimestamp:list.createTime];
      
//    cellVM.quoteFloor = [NSString stringWithFormat:@"引用%@楼 @",list.replyInfo.replyCommentFloor];
    
    
    cellVM.quoteAutor = list.replyInfo.author.nickname;
    
    CGSize quoteAutorLabelSize =  CH_TRANSFORM_TEXTSIZE(cellVM.quoteAutor, [JKStyleConfiguration subcontentFont], CGSizeMake(MAXFLOAT, 18));
    
    cellVM.quoteAutorLabelWidth = quoteAutorLabelSize.width;
    
    cellVM.quoteContent = list.replyInfo.content;
    
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
    
    
//    cellVM.floorCount = [NSString stringWithFormat:@"%d层",list.commentFloor];
    
    cellVM.content = list.content;
    
    CGSize size = CH_TRANSFORM_TEXTSIZE(cellVM.content, [JKStyleConfiguration titleFont], CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT));
    
    cellVM.contentLabelHeight = size.height;
    
    cellVM.cellHeight = 75 + cellVM.contentLabelHeight + cellVM.quoteViewHeight + 45;
    
    return cellVM;
  
    
}

- (void)refresh{
    
    self.offset = 0;
    
    [self requestData];
    
    [self.delegate scrollsToTop];
}

- (void)upWithOffset:(NSInteger)offset{
    
    self.offset = offset;
    
}

- (void)downWithOffset:(NSInteger)offset{
    
    self.offset = offset;
    
}

- (void)reply{
    
    
    if ([[JKUserManager sharedData] isUserEffective]) {
        
        [CHProgressHUD showPlainText:@"评论功能沈亮还未设计"];
        
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



@end

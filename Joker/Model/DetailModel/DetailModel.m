//
//  DetailModel.m
//  joker
//
//  Created by 肖松 on 15-8-17.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#import "DetailModel.h"
@implementation CommentListStatus
- (instancetype )initWithTest{
    NSError *error ;
    NSDictionary *commentDic = @{@"name":@"AngleBaby",@"icon":@"http://img.qqbody.com/uploads/allimg/201501/29-150345_380.jpg",@"comtentId":@"89",@"content":@"我感觉这电影真的非常非常震撼，谢谢这么好的一个推荐",@"favourNumber":@"1234",@"unFavourNumber":@"12",@"score":@"7"};
    CommentModel *Comment1 = [[CommentModel alloc]initWithDictionary:commentDic error:nil];
    NSDictionary *commentDic1 = @{@"name":@"郑凯",@"icon":@"http://img.piaoliang.com/uploads/allimg/140207/095z64922-1.jpg",@"comtentId":@"89",@"content":@"谢谢这么好的一个推荐",@"favourNumber":@"42222",@"unFavourNumber":@"12",@"score":@"8"};
    CommentModel *Comment2 = [[CommentModel alloc]initWithDictionary:commentDic1 error:nil];
    NSDictionary *commentDic2 = @{@"name":@"黄晓明",@"icon":@"http://www.touxiang.cn/uploads/20130201/01-011652_583.jpg",@"comtentId":@"89",@"content":@"推荐!!!",@"favourNumber":@"12",@"unFavourNumber":@"12",@"score":@"8"};
    CommentModel *Comment3 = [[CommentModel alloc]initWithDictionary:commentDic2 error:nil];
    NSDictionary *com = @{@"data":@[Comment1,Comment2,Comment3,Comment3,Comment3,Comment1,Comment2,Comment2,Comment2,Comment2,Comment2,Comment1,Comment1,Comment3]};
    self = [super initWithDictionary:com error:&error];
    NSLog(@"error = %@",error);
    if (self) {
        
        
    }
    return self;
}
@end
@implementation DetailModel

@end
@implementation PersonModel

@end
@implementation CommentModel
- (instancetype )initWithTest{
//    NSError *error ;
//    NSDictionary *commentDic = @{@"name":@"AngleBaby",@"icon":@"http://photo.sohu.com/33/20/Img164352033.jpg",@"comtentId":@"89",@"content":@"我感觉这电影真的非常非常震撼，谢谢这么好的一个推荐",@"favourNumber":@"12",@"unFavourNumber":@"12",@"score":@"7"};
//    CommentModel *Comment1 = [[CommentModel alloc]initWithDictionary:commentDic error:nil];
//    NSDictionary *commentDic1 = @{@"name":@"郑凯",@"icon":@"http://photo.sohu.com/33/20/Img164352033.jpg",@"comtentId":@"89",@"content":@"谢谢这么好的一个推荐",@"favourNumber":@"12",@"unFavourNumber":@"12",@"score":@"8"};
//    CommentModel *Comment2 = [[CommentModel alloc]initWithDictionary:commentDic error:nil];
//    NSDictionary *commentDic2 = @{@"name":@"黄晓明",@"icon":@"http://photo.sohu.com/33/20/Img164352033.jpg",@"comtentId":@"89",@"content":@"推荐!!!",@"favourNumber":@"12",@"unFavourNumber":@"12",@"score":@"8"};
//    CommentModel *Comment3 = [[CommentModel alloc]initWithDictionary:commentDic error:nil];
//    NSDictionary *com = @{ @"date":@[Comment1,Comment2,Comment3]};
//    self = [super initWithDictionary:com error:&error];
    if (self) {
        
        
    }
    return self;
}
@end
@implementation PersonInfo

@end
@implementation DetailContent
- (instancetype )initWithTest{
    NSError *error ;


     NSDictionary *infoD1 = @{@"personName":@"温子仁",@"personIcon":@"http://imgbdb2.bendibao.com/xiuxian/20136/27/2013627141950198.jpg",@"personId":@"1290"};
    NSDictionary *infoD2 = @{@"personName":@"布拉德皮特",@"personIcon":@"http://www.116.com.cn/movie/upload/2009/03/19/BEF7577D6FA66E4C9E0BFF869E08581F.jpg",@"personId":@"1291"};
        NSDictionary *infoD3 = @{@"personName":@"保罗",@"personIcon":@"http://i3.hoopchina.com.cn/user/364/389364/1352185360_043512.jpg",@"personId":@"1292"};
    PersonInfo *info = [[PersonInfo alloc]initWithDictionary:infoD1 error:nil];
    PersonInfo *info2 = [[PersonInfo alloc]initWithDictionary:infoD2 error:nil];
    PersonInfo *info3 = [[PersonInfo alloc]initWithDictionary:infoD3 error:nil];
    NSDictionary *personDic2 = @{@"personInfo":@[info2,info,info2,info2,info],@"personPosition":@"演员"};
    NSDictionary *personDic1 = @{@"personInfo":@[info,info2],@"personPosition":@"导演"};

    PersonModel *person = [[PersonModel alloc]initWithDictionary:personDic1 error:nil];
    PersonModel *person2 = [[PersonModel alloc]initWithDictionary:personDic2 error:nil];
    NSDictionary *dic = @{@"classify":@"动作/科幻/惊悚"
                          ,@"language":@"英语/142分钟"
                          ,@"number":@"19,300"
                          ,@"personArray":@[person]
                          ,@"scores":@[@"8.1",@"7.8",@"7.1",@"82%",@"7.9"],
        @"posterImages":@[@"http://i1.sinaimg.cn/gm/2014/0415/U10229P115DT20140415134404.jpg",@"http://i2.sinaimg.cn/ent/m/c/2011-12-02/U2190P28T3D3497405F328DT20111202111645.jpg",@"http://image227.poco.cn/mypoco/myphoto/20140802/04/6439164920140802043056044.jpg",@"http://staticfile.tujia.com/upload/info/day_141209/201412090949109621.jpg",@"http://f.hiphotos.baidu.com/baike/c0%3Dbaike60%2C5%2C5%2C60%2C20/sign=5c4e4b5bb019ebc4d4757ecbe34fa499/b17eca8065380cd7b45cd6d3a244ad3459828149.jpg"]};

    self = [super initWithDictionary:dic error:&error];
//    NSLog(@"Comment = \n dic = %@",dic);
    if (self) {

    
    }
    return self;
}

@end

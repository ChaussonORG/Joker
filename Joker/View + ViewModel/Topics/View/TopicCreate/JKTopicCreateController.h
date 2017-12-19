//
//  JKTopicCreateController.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/5.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKTopicCreateVM.h"

typedef NS_ENUM(NSInteger, JKTopicCreateType){
    JKTopicCreateNormal,
    JKTopicCreateDraft,
};

@interface JKTopicCreateController : UIViewController

@property (nonatomic ,strong) JKTopicCreateVM *viewModel;


@property (nonatomic , assign) JKTopicCreateType type;

@end

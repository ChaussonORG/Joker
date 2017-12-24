//
//  JKPersonPickGenderView.h
//  Joker
//
//  Created by 朱彦君 on 2017/12/24.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^PickCallback)(NSDate *date);

@protocol genderPickerDelegete <NSObject>

- (void)transferSelectedGender:(NSString*)gender;

@end

@interface JKPersonPickGenderView : UIView

@property (nonatomic , weak) id<genderPickerDelegete>delegete;

- (void)show;
 
@end

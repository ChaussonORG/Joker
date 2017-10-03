//
//  TOYDatePickerView.h
//  ToyMan
//
//  Created by 朱彦君 on 16/8/18.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TOYDateStyle){
    TOYPickUpDate,
    TOYPickUpTime,
    TOYSendDate,
    TOYRentDate,
    TOYBabyAge,
    TOYBoughtTime,
};

typedef void (^PickCallback)(NSDate *date);

@protocol datePickerDelegete <NSObject>

- (void)transferSelectedDate:(NSString*)date;

@end

@interface TOYDatePickerView : UIView

@property (nonatomic , weak) id<datePickerDelegete>delegete;

+ (instancetype) new __unavailable;
- (instancetype) init __unavailable;

- (instancetype)initWithDateStyle:(TOYDateStyle)style tempDate:(NSString*)tempDate;

- (void)show;
@end

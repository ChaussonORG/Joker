//
//  STUser.h
//  SurfingTV
//
//  Created by terry_ash on 2/9/16.
//  Copyright © 2016 baifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

typedef enum : NSUInteger {
    kSTUserGenderMale = 0,
    kSTUserGenderFemale
} STUserGender_t;

@interface JKUser : JSONModel<NSCoding ,NSCopying>

@property (nonatomic ,strong) NSString <Optional>* userId;
@property (nonatomic ,strong) NSString <Optional>* age;
@property (nonatomic ,strong) NSString <Optional>*username;
@property (nonatomic ,strong) NSString <Optional>*nickname;
@property (nonatomic ,strong) NSString <Optional>*name;
@property (nonatomic ,strong) NSString <Optional>*photo;
@property (assign) NSInteger gender;
@property (nonatomic ,strong) NSString <Optional>*cellphone;
@property (assign) NSInteger hidden;
@property (assign) BOOL vipMember;
@property (nonatomic ,strong) NSString <Optional>*birthday;

//
@property (nonatomic ,strong) NSString <Optional>*token;

@end

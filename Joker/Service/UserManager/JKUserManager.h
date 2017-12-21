//
//  STResidentData.h
//  SurfingTV
//
//  Created by terry_ash on 2/9/16.
//  Copyright © 2016 baifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKUser.h"

@interface JKUserManager : NSObject

@property (nonatomic ,strong) JKUser *currentUser;

+ (instancetype)sharedData;

- (BOOL)isUserEffective;

- (BOOL)eraseData;

- (void)disableCurrentUser;

- (void)saveUser;
- (void)saveUserWithInfo:(NSDictionary *)info;
- (void)saveUserWithJKUser:(JKUser *)user;
@end

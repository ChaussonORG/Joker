//
//  SDRegisterAPI.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <CHNetworking/CHNetworking.h>
#import "SDBaseResponse.h"

@interface SDRegisterAPI : CHNetRequest
+ (instancetype)new __unavailable;
- (instancetype)init  __unavailable;
- (instancetype)initWithAccount:(NSString *)account
                       password:(NSString *)password
                      phoneCode:(NSString *)code;

- (instancetype)initWithAccount:(NSString *)account
                       password:(NSString *)password
                      phoneCode:(NSString *)phoneCode
                     inviteCode:(NSString *)inviteCode;

@property (nonatomic ,readonly ) SDBaseResponse *baseResponse;

@property (nonatomic ,readonly ) NSString *token;

@property (nonatomic ,readonly ) NSString *account;

@property (nonatomic ,readonly ) NSString *password;

@property (nonatomic ,readonly ) NSString *code;

@property (nonatomic ,readonly ) NSString *inviteCode;

@end

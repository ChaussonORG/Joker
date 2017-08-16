//
//  STResidentData.m
//  SurfingTV
//
//  Created by terry_ash on 2/9/16.
//  Copyright © 2016 baifu. All rights reserved.
//

#import "JKUserManager.h"
#import <CHNetworking/CHNetworking.h>



@interface JKUserManager()

@property (nonatomic ,strong) NSString *userSavePath;



@end

@implementation JKUserManager
@synthesize currentUser = _currentUser;

+ (instancetype)sharedData{
    static dispatch_once_t onceToken;
    static JKUserManager *sharedData = nil;
    dispatch_once(&onceToken, ^{
        
        sharedData = [[self class] new];
    });
    return sharedData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"user: %p", self.currentUser);
    }
    return self;
}

- (NSString *)userSavePath{
    if (nil == _userSavePath) {
//        NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *librarysPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
        NSString *documentsPath = [librarysPath stringByAppendingString:@"/Caches"];
        _userSavePath  = [documentsPath stringByAppendingPathComponent:@"userinfo.data"];//添加储存的文件名
    }
    return _userSavePath;
}

- (JKUser *)currentUser{
    if (nil == _currentUser) {
        JKUser *user =  [NSKeyedUnarchiver unarchiveObjectWithFile:self.userSavePath];
        if (!user) {
             user = [JKUser new];
        }
        _currentUser = user;
    }
    return _currentUser;
}

- (void)setCurrentUser:(JKUser *)currentUser{
    _currentUser = currentUser;
    if (_currentUser) {
        [self saveUser];
    }
}

- (BOOL)isUserEffective{
    return self.currentUser && self.currentUser.token.length > 0;
}

- (void)disableCurrentUser{
    self.currentUser = nil;
    [self eraseData];
}

- (BOOL)eraseData{
    self.currentUser.token = nil;
    return   [[NSFileManager defaultManager] removeItemAtPath:self.userSavePath
                                                        error:nil];
}

#pragma mark private
- (void)saveUser{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.currentUser];
    BOOL isSaveOk = [data writeToFile:self.userSavePath atomically:YES];
    NSLog(@"%d,%s",isSaveOk,__func__);
}
- (void)saveUserWithInfo:(NSDictionary *)info
{
    if (info) {
        NSError *error;
        NSLog(@"%@", [info objectForKey:@"profile"]);
        self.currentUser = [[JKUser alloc] initWithDictionary:[info objectForKey:@"profile"] error:&error];
        NSLog(@"%@", error);
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *token = [NSString stringWithFormat:@"%@", [info objectForKey:@"token"]];
        NSString *userId = [NSString stringWithFormat:@"%@", [[info objectForKey:@"profile"] objectForKey:@"userId"]];
        [dic setObject:token forKey:@"token"];
        self.currentUser.token = token;
        self.currentUser.userId = userId;
        [[CHNetworkConfig sharedInstance] addheaderFieldParameter:dic];
        NSLog(@"%@", error);
        [self saveUser];
    }
}
- (void)saveUserWithJKUser:(JKUser *)user
{
    if (user) {
        self.currentUser = user;
        [self saveUser];
    }
}
@end

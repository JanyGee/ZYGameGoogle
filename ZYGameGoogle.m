//
//  ZYGameGoogle.m
//  ZYWebGameKitSample
//
//  Created by admin on 2020/5/12.
//  Copyright © 2020 Octopus. All rights reserved.
//

#import "ZYGameGoogle.h"
#import <GoogleSignIn/GoogleSignIn.h>
@import ZYWebGameKit;
@interface ZYGameGoogle ()<GIDSignInDelegate>

@end
@implementation ZYGameGoogle
+ (instancetype)shareGoogle{
    
    static ZYGameGoogle *googleLogin = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        googleLogin = [[ZYGameGoogle alloc] init];
    });
    
    return googleLogin;
}

- (void)initWithClientID:(NSString *)clientID{
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = self;
    signIn.clientID = clientID;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(googleLoginSuccess) name:@"ZYSDKNotificationGoogleLogin" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)googleLoginSuccess{
    [GIDSignIn sharedInstance].presentingViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [[GIDSignIn sharedInstance] signIn];
}

#pragma mark - GIDSignInDelegate
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
    if (!user) {
           return;
       }
       // Perform any operations on signed in user here.
       NSString *userId = user.userID?user.userID:@"";
       NSString *idToken = user.authentication.idToken;
       //NSString *clientID = user.authentication.clientID;
       NSString *fullName = user.profile.name?user.profile.name:@"";
       NSString *email = user.profile.email?user.profile.email:@"";
       
       if (!fullName ||!idToken ||!userId ||!email) {
           return;
       }
    
    [[GIDSignIn sharedInstance] disconnect];
    
    [ZYWebGameKit otherLoginWithOtherId:userId email:email name:fullName loginType:@"google"];
}
@end

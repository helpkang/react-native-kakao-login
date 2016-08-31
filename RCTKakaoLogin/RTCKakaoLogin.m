//
//  RTCKakaoLogin.m
//  RTCKakaoLogin
//
//  Created by 강성일 on 2016. 8. 24..
//  Copyright © 2016년 강성일. All rights reserved.
//

#import "RTCKakaoLogin.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>


@implementation RTCKakaoLogin

RCT_EXPORT_MODULE();

RCT_REMAP_METHOD(login,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{

    [[KOSession sharedSession] close];
    [[KOSession sharedSession] openWithCompletionHandler:^(NSError *error) {
        //        if(error) {
        //            reject(@"kakao login error", @"not login", error);
        //            return;
        //        }
        
        
        if ([[KOSession sharedSession] isOpen]) {
            [self loginProcessResolve:resolve
                 rejecter:reject];
        } else {
            // failed
            NSLog(@"login cancel.");
            //NSError *error = [NSError errorWithDomain:@"kakaologin" code:1 userInfo:nil];
            reject(@"KAKAO_LOGIN_CANCEL", @"CANCEL", nil);
        }
    }];
    
}

- (void)loginProcessResolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject
{
    // login success
    NSLog(@"access toeken %@",[KOSession sharedSession].accessToken);
    NSLog(@"login succeeded.");
    
    
    [KOSessionTask  meTaskWithCompletionHandler :^(KOUser* result, NSError *error) {
        
        if (result) {
            // success
            NSLog(@"userId=%@", result.ID);
            NSLog(@"nickName=%@", [result propertyForKey:@"nickname"]);
            NSLog(@"profileImage=%@", [result propertyForKey:@"profile_image"]);
            
            NSDictionary *userSession = @{
                                          @"accessToken": [KOSession sharedSession].accessToken,
                                          @"id": result.ID,
                                          @"nickname": [result propertyForKey:@"nickname"],
                                          // water0126
                                          @"profile_image": [result propertyForKey:@"profile_image"] != nil ? [result propertyForKey:@"profile_image"] : @""
                                          };
            //resolve(userSession);
            NSLog(@"successs.................");
            resolve(userSession);
            return;
            
        } else {
            NSLog(@"login failed.");
            //                    NSError *error = [NSError errorWithDomain:@"kakaologin" code:2 userInfo:nil];
            reject(@"KAKAO_LOGIN_FAIL", @"FAIL", nil);
        }
        
    }];
}

RCT_REMAP_METHOD(logout,
                 resolver1:(RCTPromiseResolveBlock)resolve
                 rejecter1:(RCTPromiseRejectBlock)reject)
{
    [[KOSession sharedSession] close];
    NSDictionary *status = @{ @"success": @"true"};
    resolve(status);
}
@end

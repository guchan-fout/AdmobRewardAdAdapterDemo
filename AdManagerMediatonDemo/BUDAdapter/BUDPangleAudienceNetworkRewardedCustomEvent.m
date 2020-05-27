//
//  AdMobAdxRewardedCustomEvent.m
//  AdMobTest
//
//  Created by Liao Kang on 2019/5/31.
//  Copyright © 2019 Jo. All rights reserved.
//

#import "BUDPangleAudienceNetworkRewardedCustomEvent.h"
#import <BUAdSDK/BUAdSDKManager.h>
#import <BUAdSDK/BURewardedVideoAd.h>
#import <BUAdSDK/BURewardedVideoModel.h>
@interface BUDPangleAudienceNetworkRewardedCustomEvent () <GADMediationRewardedAd, GADRewardedAdDelegate,BURewardedVideoAdDelegate> {
    GADRewardedAd *_rewardAd;
}

@property(nonatomic, weak, nullable) id<GADMediationRewardedAdEventDelegate> delegate;
@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;
@property (nonatomic, copy)GADMediationRewardedLoadCompletionHandler  rewardAdLoadCompletionHandler;
@end

@implementation BUDPangleAudienceNetworkRewardedCustomEvent

+(nullable Class<GADAdNetworkExtras>)networkExtrasClass {
    return Nil;
}

+(GADVersionNumber)adSDKVersion {
    NSString *versionString = @"1.0.0";
    NSArray *versionComponents = [versionString componentsSeparatedByString:@"."];
    GADVersionNumber version = {0};
    if (versionComponents.count == 3) {
        version.majorVersion = [versionComponents[0] integerValue];
        version.minorVersion = [versionComponents[1] integerValue];
        version.patchVersion = [versionComponents[2] integerValue];
    }
    return version;
}


+ (GADVersionNumber)version {
    NSString *versionString = @"1.0.0.0";
    NSArray *versionComponents = [versionString componentsSeparatedByString:@"."];
    GADVersionNumber version = {0};
    if (versionComponents.count == 4) {
        version.majorVersion = [versionComponents[0] integerValue];
        version.minorVersion = [versionComponents[1] integerValue];
        
        // Adapter versions have 2 patch versions. Multiply the first patch by 100.
        version.patchVersion = [versionComponents[2] integerValue] * 100
        + [versionComponents[3] integerValue];
    }
    return version;
}

//As we test, this method won't be called
+ (void)setUpWithConfiguration:(GADMediationServerConfiguration *)configuration completionHandler:(GADMediationAdapterSetUpCompletionBlock)completionHandler {
    
    NSLog(@"===Sunboy=== Custom Event setUp");
    
    NSMutableArray<NSString *> *adUnitIDs = [[NSMutableArray alloc] init];
    for (GADMediationCredentials *credential in configuration.credentials) {
        if (credential.format == GADAdFormatRewarded) {
            [adUnitIDs addObject:credential.settings[@"parameter"]];
        }
    }
    if ([adUnitIDs count] == 0) {
        NSError *error =
        [NSError errorWithDomain:@"GADMediationAdapterSampleAdNetwork"
                            code:0
                        userInfo:@{NSLocalizedDescriptionKey : @"No adUnitIDs specified."}];
        completionHandler(error);
        return;
    }
}

//Request Ad
- (void)loadRewardedAdForAdConfiguration:(GADMediationRewardedAdConfiguration *)adConfiguration                                                       completionHandler:(GADMediationRewardedLoadCompletionHandler)completionHandler {
    
    NSLog(@"===Sunboy=== Custom Event loadReward AdConfiguration");
    // init TikTok SDK，we recommend you do sdk initialization in the AppDelegate
    [BUAdSDKManager setAppID:@"5021821"]; // this is our test app id
    
    //get ad placement id from admob server parameter
    NSString *adUnit = adConfiguration.credentials.settings[@"parameter"];
    NSLog(@"===Sunboy=== adUnitId:%@", adUnit);
    
    //Request TikTok Rewarded Ad
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"123";
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:adUnit rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    
    _rewardAdLoadCompletionHandler = completionHandler;
    [self.rewardedVideoAd loadAdData];
  
}

//show
- (void)presentFromViewController:(nonnull UIViewController *)viewController {

     [self.rewardedVideoAd showAdFromRootViewController:viewController ritScene:BURitSceneType_home_get_bonus ritSceneDescribe:nil];
    
}

#pragma mark BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"===Sunboy=== Custom Event on ad loaded");
   
    //Get Admob Delegate
    self.delegate = _rewardAdLoadCompletionHandler(self, nil);
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSLog(@"===Sunboy=== Custom Event fail to load:%@", error);
    GADRequestError * requestError =(GADRequestError * )error;
    _rewardAdLoadCompletionHandler(nil,requestError);
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"===Sunboy=== Custom Event cached");

}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"===Sunboy=== Custom Event will visible");
    [self.delegate willPresentFullScreenView];
    [self.delegate reportImpression];
    [self.delegate didStartVideo];
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
     NSLog(@"===Sunboy=== Custom Event ad did close");
    
    [self.delegate willDismissFullScreenView];
    
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"===Sunboy=== Custom Event ad click");
     [self.delegate reportClick];
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error{
    
    if (error) {
        NSLog(@"===Sunboy=== Custom Event fail to play video");
        [self.delegate didEndVideo];
        
    } else {
        NSLog(@"===Sunboy=== Custom Event video play successfully");
        
    }
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    NSLog(@"===Sunboy=== Custom Event on Reward");
    GADAdReward *aReward =
    [[GADAdReward alloc] initWithRewardType:rewardedVideoAd.rewardedVideoModel.rewardName
                               rewardAmount:[NSDecimalNumber numberWithUnsignedInt:rewardedVideoAd.rewardedVideoModel.rewardAmount]];
    [self.delegate didRewardUserWithReward:aReward];
    
    NSLog(@"Demo RewardName == %@", rewardedVideoAd.rewardedVideoModel.rewardName);
    NSLog(@"Demo RewardAmount == %ld", (long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
}

-(BOOL)shouldAutorotate{
    return YES;
}
@end

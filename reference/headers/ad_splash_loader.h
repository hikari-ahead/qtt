//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

#import "AdsNativeAdDelegate-Protocol.h"

@class NSString;

@interface ad_splash_loader : NSObject <AdsNativeAdDelegate>
{
    int _status;
    NSString *_slotId;
}

+ (id)instance;
@property(nonatomic) int status; // @synthesize status=_status;
@property(retain, nonatomic) NSString *slotId; // @synthesize slotId=_slotId;
- (void).cxx_destruct;
- (void)adsNativeAdLoaded:(id)arg1;
- (void)adsNativeAdFailed:(id)arg1;
- (void)deleteCachedAdObject_Splash;
- (void)saveAdObject_SplashToDisk:(id)arg1;
- (id)cachedAdObject_Splash;
- (void)load:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


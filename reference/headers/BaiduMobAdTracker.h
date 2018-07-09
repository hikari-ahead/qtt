//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

#import "BaiduMobAdActionComposerDelegate-Protocol.h"

@class BaiduMobAdInstance, BaiduMobAdNativeAdObject, BaiduMobAdRendererHelper, BaiduMobAdSpamViewValidator, NSString, UIView, UIViewController;
@protocol BaiduMobAdNativeAdDelegate;

@interface BaiduMobAdTracker : NSObject <BaiduMobAdActionComposerDelegate>
{
    _Bool _needSendImpressLog;
    int _lastVisibility;
    int _checkVisibleCount;
    UIViewController *_presentAdViewController;
    id <BaiduMobAdNativeAdDelegate> _delegate;
    BaiduMobAdInstance *_adInstance;
    BaiduMobAdSpamViewValidator *_validater;
    BaiduMobAdRendererHelper *_renderHelper;
    BaiduMobAdNativeAdObject *_object;
    UIView *_view;
    NSString *_uniqueId;
    NSString *_showRecord;
    NSString *_forcecurl;
    NSString *_appName;
    NSString *_adType;
}

@property(copy, nonatomic) NSString *adType; // @synthesize adType=_adType;
@property(copy, nonatomic) NSString *appName; // @synthesize appName=_appName;
@property(copy, nonatomic) NSString *forcecurl; // @synthesize forcecurl=_forcecurl;
@property(copy, nonatomic) NSString *showRecord; // @synthesize showRecord=_showRecord;
@property(copy, nonatomic) NSString *uniqueId; // @synthesize uniqueId=_uniqueId;
@property _Bool needSendImpressLog; // @synthesize needSendImpressLog=_needSendImpressLog;
@property int checkVisibleCount; // @synthesize checkVisibleCount=_checkVisibleCount;
@property int lastVisibility; // @synthesize lastVisibility=_lastVisibility;
@property(retain, nonatomic) UIView *view; // @synthesize view=_view;
@property(retain, nonatomic) BaiduMobAdNativeAdObject *object; // @synthesize object=_object;
@property(retain, nonatomic) BaiduMobAdRendererHelper *renderHelper; // @synthesize renderHelper=_renderHelper;
@property(retain, nonatomic) BaiduMobAdSpamViewValidator *validater; // @synthesize validater=_validater;
@property(retain, nonatomic) BaiduMobAdInstance *adInstance; // @synthesize adInstance=_adInstance;
@property(nonatomic) __weak id <BaiduMobAdNativeAdDelegate> delegate; // @synthesize delegate=_delegate;
@property(nonatomic) UIViewController *presentAdViewController; // @synthesize presentAdViewController=_presentAdViewController;
- (void).cxx_destruct;
- (void)didFinishWithResult:(id)arg1;
- (void)dealloc;
- (void)sendLog:(int)arg1 withtype:(long long)arg2;
- (id)generateUniqueId;
- (void)checkVisible;
- (void)trackImpression:(id)arg1;
- (void)handleClick:(id)arg1;
- (void)clickAdDownload;
- (void)clickAd;
- (void)trackVideoEvent:(int)arg1 withCurrentTime:(double)arg2;
- (id)initWithObject:(id)arg1;
- (id)initWithObject:(id)arg1 andView:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "BaiduMobAdRenderer.h"

#import "BaiduMobAdActionComposerDelegate-Protocol.h"

@class NSString, UIButton;

@interface BaiduMobAdImageRenderer : BaiduMobAdRenderer <BaiduMobAdActionComposerDelegate>
{
    _Bool _supportTimeLabel;
    _Bool _supportPause;
    _Bool _supportActImage;
    UIButton *_imageButton;
    double _backgroundTimeStamp;
}

@property(nonatomic) _Bool supportActImage; // @synthesize supportActImage=_supportActImage;
@property(nonatomic) _Bool supportPause; // @synthesize supportPause=_supportPause;
@property(nonatomic) _Bool supportTimeLabel; // @synthesize supportTimeLabel=_supportTimeLabel;
@property double backgroundTimeStamp; // @synthesize backgroundTimeStamp=_backgroundTimeStamp;
@property(retain, nonatomic) UIButton *imageButton; // @synthesize imageButton=_imageButton;
- (void)stop;
- (void)timeAnimation;
- (void)resume;
- (void)pause;
- (void)showTimerAnimation;
- (void)setRemainTime;
- (void)didFinishWithResult:(id)arg1;
- (void)adClick;
- (void)showImage:(id)arg1;
- (void)showResource:(id)arg1 withMimeType:(id)arg2;
- (void)showPureImage:(id)arg1;
- (void)load;
- (void)willEnterForeground;
- (void)didEnterBackground;
- (void)dealloc;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

#import "JPUSHHttpRequestDelegate-Protocol.h"

@class CLLocation, CLLocationManager, JPUSHFileCacheController, JPUSHLocationInfoController, JPUSHReportCacheController, NSMutableArray, NSString, NSTimer;

@interface JPUSHHttpSessionController : NSObject <JPUSHHttpRequestDelegate>
{
    JPUSHReportCacheController *_reportCache;
    JPUSHFileCacheController *_fileCache;
    NSMutableArray *_httpBlockedQueue;
    _Bool _isSetup;
    double _closeTime;
    double _startTime;
    NSTimer *_deviceCheckTimer;
    double _lastDeviceTimestamp;
    NSTimer *_crashCheckTimer;
    double _lastCrashTimestamp;
    NSTimer *_locationCheckTimer;
    double _lastLocationTimestamp;
    NSTimer *_collectLocationCheckTimer;
    double _lastCollectLocationTimestamp;
    JPUSHLocationInfoController *_locationInfo;
    unsigned long long _collectLocationFlag;
    int _locationAuthorizationStatus;
    _Bool _locationDisable;
    double _collectLocationFrequency;
    double _reportLocationFrequency;
    NSTimer *_locationUpdateTimer;
    CLLocation *_latestLocation;
    _Bool _needReportLocation;
    _Bool _alreadyCollect;
    NSString *_reportFlag;
    CLLocationManager *_locationManager;
}

@property(retain, nonatomic) CLLocationManager *locationManager; // @synthesize locationManager=_locationManager;
@property(readonly, nonatomic) double startTime; // @synthesize startTime=_startTime;
@property(readonly, nonatomic) double closeTime; // @synthesize closeTime=_closeTime;
@property(readonly, nonatomic) _Bool isSetup; // @synthesize isSetup=_isSetup;
@property(readonly, nonatomic) JPUSHLocationInfoController *locationInfo; // @synthesize locationInfo=_locationInfo;
@property(retain, nonatomic) JPUSHFileCacheController *fileCache; // @synthesize fileCache=_fileCache;
@property(retain, nonatomic) JPUSHReportCacheController *reportCache; // @synthesize reportCache=_reportCache;
- (void).cxx_destruct;
- (void)onCtrlCmdRespond:(id)arg1;
- (void)p_stopcollectLocationCheck;
- (void)p_startcollectLocationCheck;
- (void)p_checkcollectLocation;
- (void)p_stoplocationCheck;
- (void)p_startlocationCheck;
- (void)p_checklocation;
- (void)p_stopcrashCheck;
- (void)p_startcrashCheck;
- (void)p_checkcrash;
- (void)p_stopdeviceCheck;
- (void)p_startdeviceCheck;
- (void)p_checkdevice;
- (void)locationInfoChangeViaNetworkState:(int)arg1;
- (id)getHttpNetworkErrorStringWith:(long long)arg1;
- (void)didNotReceivedFromRequest:(id)arg1 withReportFlag:(id)arg2 WithError:(id)arg3;
- (void)didReceivedHttpFeedback:(id)arg1;
- (id)getDefaultAddress:(int)arg1;
- (id)getBackUpAddress:(int)arg1;
- (id)setRequestManager:(id)arg1;
- (void)doSendHttpReport:(id)arg1;
- (void)sendHttpReport:(id)arg1;
- (void)sendAllBlockedHttpReports;
- (void)collectLocation;
- (void)reportLocation;
- (void)sendReportLocationRequest;
- (void)reportCrashLog;
- (void)reportDeviceInfo;
- (void)reportLaunch;
- (void)reportActiveWithActive:(id)arg1 withSessionStartTime:(double)arg2 withSessionCloseTime:(double)arg3;
- (void)resumeTimer;
- (void)startCollectLocationTimer;
- (void)p_startTimer;
- (void)p_closeTimer;
- (void)serialize;
- (void)reportInactive:(id)arg1;
- (void)prepareActive:(double)arg1;
- (void)saveCheckTimer;
- (void)saveSessionWithTime:(id)arg1;
- (void)resumeSession;
- (void)closeSession;
- (void)setupSession:(double)arg1;
- (void)trySetupSession;
- (void)reportLatestLocation;
- (void)locationManager:(id)arg1 didFailWithError:(id)arg2;
- (void)locationManager:(id)arg1 didUpdateLocations:(id)arg2;
- (void)locationManager:(id)arg1 didChangeAuthorizationStatus:(int)arg2;
- (void)setupLocationManager;
- (void)setLBSReportOrCollectFrequency;
- (void)dealloc;
- (id)init;

@end


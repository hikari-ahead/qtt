//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "LCSystemFunction.h"

@interface OLSystemTouchID : LCSystemFunction
{
    CDUnknownBlockType _enabledHolder;
    CDUnknownBlockType _disabledHolder;
    CDUnknownBlockType _verifySuccessHolder;
    CDUnknownBlockType _verifyFailedHolder;
    CDUnknownBlockType _systemCancelHolder;
    CDUnknownBlockType _userCancelHolder;
    CDUnknownBlockType _authFailedHolder;
    CDUnknownBlockType _passcodeNotSetHolder;
    CDUnknownBlockType _unavailableHolder;
    CDUnknownBlockType _notEnrolledHolder;
    CDUnknownBlockType _userFallbackHolder;
    CDUnknownBlockType _otherErrorHolder;
}

@property(copy, nonatomic) CDUnknownBlockType otherErrorHolder; // @synthesize otherErrorHolder=_otherErrorHolder;
@property(copy, nonatomic) CDUnknownBlockType userFallbackHolder; // @synthesize userFallbackHolder=_userFallbackHolder;
@property(copy, nonatomic) CDUnknownBlockType notEnrolledHolder; // @synthesize notEnrolledHolder=_notEnrolledHolder;
@property(copy, nonatomic) CDUnknownBlockType unavailableHolder; // @synthesize unavailableHolder=_unavailableHolder;
@property(copy, nonatomic) CDUnknownBlockType passcodeNotSetHolder; // @synthesize passcodeNotSetHolder=_passcodeNotSetHolder;
@property(copy, nonatomic) CDUnknownBlockType authFailedHolder; // @synthesize authFailedHolder=_authFailedHolder;
@property(copy, nonatomic) CDUnknownBlockType userCancelHolder; // @synthesize userCancelHolder=_userCancelHolder;
@property(copy, nonatomic) CDUnknownBlockType systemCancelHolder; // @synthesize systemCancelHolder=_systemCancelHolder;
@property(copy, nonatomic) CDUnknownBlockType verifyFailedHolder; // @synthesize verifyFailedHolder=_verifyFailedHolder;
@property(copy, nonatomic) CDUnknownBlockType verifySuccessHolder; // @synthesize verifySuccessHolder=_verifySuccessHolder;
@property(copy, nonatomic) CDUnknownBlockType disabledHolder; // @synthesize disabledHolder=_disabledHolder;
@property(copy, nonatomic) CDUnknownBlockType enabledHolder; // @synthesize enabledHolder=_enabledHolder;
- (void).cxx_destruct;
@property(readonly, copy, nonatomic) CDUnknownBlockType otherError;
@property(readonly, copy, nonatomic) CDUnknownBlockType userFallback;
@property(readonly, copy, nonatomic) CDUnknownBlockType notEnrolled;
@property(readonly, copy, nonatomic) CDUnknownBlockType unavailable;
@property(readonly, copy, nonatomic) CDUnknownBlockType passcodeNotSet;
@property(readonly, copy, nonatomic) CDUnknownBlockType authFailed;
@property(readonly, copy, nonatomic) CDUnknownBlockType userCancel;
@property(readonly, copy, nonatomic) CDUnknownBlockType systemCancel;
@property(readonly, copy, nonatomic) CDUnknownBlockType verifyFailed;
@property(readonly, copy, nonatomic) CDUnknownBlockType verifySuccess;
@property(readonly, copy, nonatomic) CDUnknownBlockType disabled;
@property(readonly, copy, nonatomic) CDUnknownBlockType enabled;
- (void)authenticationWithTitle:(id)arg1 fallBackTitle:(id)arg2;
@property(readonly, copy, nonatomic) CDUnknownBlockType authentication;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

@class UIActivityIndicatorView;

@interface AFActivityIndicatorViewNotificationObserver : NSObject
{
    UIActivityIndicatorView *_activityIndicatorView;
}

@property(readonly, nonatomic) __weak UIActivityIndicatorView *activityIndicatorView; // @synthesize activityIndicatorView=_activityIndicatorView;
- (void).cxx_destruct;
- (void)dealloc;
- (void)af_stopAnimating;
- (void)af_startAnimating;
- (void)setAnimatingWithStateOfTask:(id)arg1;
- (id)initWithActivityIndicatorView:(id)arg1;

@end


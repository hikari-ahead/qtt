//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

@class NSString, UIViewController;

@interface LCSystemicService : NSObject
{
    UIViewController *_presentingViewController;
}

@property(nonatomic) __weak UIViewController *presentingViewController; // @synthesize presentingViewController=_presentingViewController;
- (void).cxx_destruct;
- (void)showServiceController;
- (void)requestAuthorization:(CDUnknownBlockType)arg1;
@property(readonly, nonatomic) NSString *serviceIdentifier;
- (id)init;

@end


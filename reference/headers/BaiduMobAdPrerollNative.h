//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

@class BaiduMobAdPrerollSlot, NSNumber, NSString;
@protocol BaiduMobAdPrerollNativeDelegate;

@interface BaiduMobAdPrerollNative : NSObject
{
    NSString *_publisherId;
    NSString *_adId;
    id <BaiduMobAdPrerollNativeDelegate> _delegate;
    NSNumber *_height;
    NSNumber *_width;
    BaiduMobAdPrerollSlot *_slot;
}

@property(retain, nonatomic) BaiduMobAdPrerollSlot *slot; // @synthesize slot=_slot;
@property(retain, nonatomic) NSNumber *width; // @synthesize width=_width;
@property(retain, nonatomic) NSNumber *height; // @synthesize height=_height;
@property(nonatomic) id <BaiduMobAdPrerollNativeDelegate> delegate; // @synthesize delegate=_delegate;
@property(copy, nonatomic) NSString *adId; // @synthesize adId=_adId;
@property(copy, nonatomic) NSString *publisherId; // @synthesize publisherId=_publisherId;
- (void).cxx_destruct;
- (_Bool)enableLocation;
- (id)channelId;
- (id)buildSlotInfo:(id)arg1;
- (id)AdWithCustomEventInfo:(id)arg1;
- (void)buildCallbackBlock;
- (void)request;
- (void)dealloc;
- (id)init;

@end


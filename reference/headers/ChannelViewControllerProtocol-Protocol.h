//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class NSDate, QKChannel, QKTrackPoint, UIScrollView, UISearchBar;

@protocol ChannelViewControllerProtocol <NSObject>

@optional
@property(nonatomic) double padding;
@property(retain, nonatomic) NSDate *channelStart;
@property(retain, nonatomic) QKTrackPoint *track_point;
@property(nonatomic) _Bool isShowHomeItemBadgeNum;
@property(nonatomic) _Bool isNeedAPNSAlertView;
@property(nonatomic) int src;
@property(retain, nonatomic) UISearchBar *searchBar;
@property(nonatomic) _Bool is_loading;
@property(retain, nonatomic) QKChannel *model;
@property(nonatomic) double refresh_num;
@property(nonatomic) double status;
@property(nonatomic) double op;
@property(nonatomic) double oldPanOffsetY;
- (_Bool)is_channel_expired;
- (void)loadData:(_Bool)arg1 reset:(_Bool)arg2;
- (void)doEndDisplay:(id)arg1;
- (void)doUpdateDisplay;
- (_Bool)isRecommend;
- (UIScrollView *)displayView;
- (id)initWithModel:(id)arg1 src:(int)arg2;
@end


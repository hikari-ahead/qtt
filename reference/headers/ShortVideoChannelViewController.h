//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "QKBaseViewController.h"

#import "ChannelViewControllerProtocol-Protocol.h"
#import "ShortVideoPlayViewControllerDelegate-Protocol.h"
#import "TableViewEmptyViewDelegate-Protocol.h"
#import "UICollectionViewDataSource-Protocol.h"
#import "UICollectionViewDelegate-Protocol.h"
#import "UICollectionViewDelegateFlowLayout-Protocol.h"

@class NSDate, NSMutableDictionary, NSString, NSTimer, QKChannel, QKCollectionView, QKTrackPoint, UIImageView, UILabel, UISearchBar;

@interface ShortVideoChannelViewController : QKBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TableViewEmptyViewDelegate, ShortVideoPlayViewControllerDelegate, ChannelViewControllerProtocol>
{
    _Bool _bReload;
    double _historyY;
    _Bool _isScrollUp;
    _Bool _isFristLoad;
    long long _lastRefreshTime;
    _Bool _bCached;
    _Bool _needRefresh;
    _Bool _is_loading;
    _Bool _isNeedAPNSAlertView;
    _Bool _isShowHomeItemBadgeNum;
    int _src;
    double _oldPanOffsetY;
    double _op;
    double _status;
    double _refresh_num;
    QKChannel *_model;
    UISearchBar *_searchBar;
    QKTrackPoint *_track_point;
    NSDate *_channelStart;
    double _padding;
    QKCollectionView *_collectionView;
    NSTimer *_updateTipsTimer;
    UIImageView *_dotView;
    UILabel *_dotCountLabel;
    NSMutableDictionary *_storageLoadMoreData;
}

@property(retain, nonatomic) NSMutableDictionary *storageLoadMoreData; // @synthesize storageLoadMoreData=_storageLoadMoreData;
@property(retain, nonatomic) UILabel *dotCountLabel; // @synthesize dotCountLabel=_dotCountLabel;
@property(retain, nonatomic) UIImageView *dotView; // @synthesize dotView=_dotView;
@property(retain, nonatomic) NSTimer *updateTipsTimer; // @synthesize updateTipsTimer=_updateTipsTimer;
@property(retain, nonatomic) QKCollectionView *collectionView; // @synthesize collectionView=_collectionView;
@property(nonatomic) long long lastRefreshTime; // @synthesize lastRefreshTime=_lastRefreshTime;
@property(nonatomic) double padding; // @synthesize padding=_padding;
@property(retain, nonatomic) NSDate *channelStart; // @synthesize channelStart=_channelStart;
@property(retain, nonatomic) QKTrackPoint *track_point; // @synthesize track_point=_track_point;
@property(nonatomic) _Bool isShowHomeItemBadgeNum; // @synthesize isShowHomeItemBadgeNum=_isShowHomeItemBadgeNum;
@property(nonatomic) _Bool isNeedAPNSAlertView; // @synthesize isNeedAPNSAlertView=_isNeedAPNSAlertView;
@property(nonatomic) int src; // @synthesize src=_src;
@property(retain, nonatomic) UISearchBar *searchBar; // @synthesize searchBar=_searchBar;
@property(nonatomic) _Bool is_loading; // @synthesize is_loading=_is_loading;
@property(retain, nonatomic) QKChannel *model; // @synthesize model=_model;
@property(nonatomic) double refresh_num; // @synthesize refresh_num=_refresh_num;
@property(nonatomic) double status; // @synthesize status=_status;
@property(nonatomic) double op; // @synthesize op=_op;
@property(nonatomic) double oldPanOffsetY; // @synthesize oldPanOffsetY=_oldPanOffsetY;
- (void).cxx_destruct;
- (_Bool)checkIfExpired;
- (_Bool)is_channel_expired;
- (void)didDeleteDislikeContents:(id)arg1;
- (void)playVCWillPop;
- (void)playVCLastPageScrollToNext;
- (void)playVCDidChangePage:(id)arg1;
- (void)tableViewEmptyScreenTouchAction:(long long)arg1;
- (void)scrollViewDidScroll:(id)arg1;
- (void)scrollViewWillBeginDragging:(id)arg1;
- (void)collectionView:(id)arg1 didSelectItemAtIndexPath:(id)arg2;
- (id)collectionView:(id)arg1 cellForItemAtIndexPath:(id)arg2;
- (double)collectionView:(id)arg1 layout:(id)arg2 minimumLineSpacingForSectionAtIndex:(long long)arg3;
- (double)collectionView:(id)arg1 layout:(id)arg2 minimumInteritemSpacingForSectionAtIndex:(long long)arg3;
- (struct CGSize)collectionView:(id)arg1 layout:(id)arg2 sizeForItemAtIndexPath:(id)arg3;
- (long long)collectionView:(id)arg1 numberOfItemsInSection:(long long)arg2;
- (void)shareAction:(id)arg1;
- (void)tableView_reloadData;
- (void)filterDuplicates:(id)arg1 isReload:(_Bool)arg2;
- (void)timerAction;
- (void)stopTimer;
- (id)contentType;
- (_Bool)isRecommend;
- (void)finish_load:(id)arg1;
- (_Bool)loadFromLocal;
- (void)loadFromRemote:(long long)arg1;
- (void)loadMore;
- (void)loadNew;
- (void)loadData:(_Bool)arg1 reset:(_Bool)arg2;
- (id)displayView;
- (id)initWithModel:(id)arg1 src:(int)arg2;
- (void)shortVideoChangePageNotification:(id)arg1;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)dealloc;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


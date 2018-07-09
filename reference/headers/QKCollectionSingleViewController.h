//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "QKBaseViewController.h"

#import "LCTableViewConfigure-Protocol.h"

@class LCTableViewManager, NSMutableArray, NSString, QKContentTableModel;

@interface QKCollectionSingleViewController : QKBaseViewController <LCTableViewConfigure>
{
    _Bool _refresh_num;
    id _dataSource;
    LCTableViewManager *_tableManager;
    NSString *_collectionType;
    NSMutableArray *_collects;
    QKContentTableModel *_model;
}

@property(retain, nonatomic) QKContentTableModel *model; // @synthesize model=_model;
@property(retain, nonatomic) NSMutableArray *collects; // @synthesize collects=_collects;
@property(copy, nonatomic) NSString *collectionType; // @synthesize collectionType=_collectionType;
@property(retain, nonatomic) LCTableViewManager *tableManager; // @synthesize tableManager=_tableManager;
@property(retain, nonatomic) id dataSource; // @synthesize dataSource=_dataSource;
- (void).cxx_destruct;
- (void)tableViewManager:(id)arg1 tableViewEmptyButtonTouchAction:(long long)arg2;
- (void)tableViewManager:(id)arg1 cellForRowAtIndexPath:(id)arg2 tableViewCell:(id)arg3;
- (void)tableViewManager:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (void)tableViewManager:(id)arg1 withPullType:(long long)arg2;
- (void)_setupTableViewData;
- (void)_loadFavoriteList:(id)arg1 direction:(long long)arg2;
- (void)updateTableViewData;
- (void)removeObjectWithAnimation:(id)arg1;
- (void)removeContent:(id)arg1;
- (void)removeArticle:(id)arg1;
- (void)removeVideo:(id)arg1;
- (void)_addNotification;
- (void)dealloc;
- (void)didReceiveMemoryWarning;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableView.h>

#import "EmptyViewDelegate-Protocol.h"

@class LCBaseEmptyView, NSString, UILabel;
@protocol TableViewEmptyViewDelegate;

@interface LCBaseTableView : UITableView <EmptyViewDelegate>
{
    int _var;
    LCBaseEmptyView *_emptyView;
    id <TableViewEmptyViewDelegate> _emptyDelegate;
    double _scrollHeight;
    double _scrollOffsetY;
    UILabel *_textLabel;
}

@property(retain, nonatomic) UILabel *textLabel; // @synthesize textLabel=_textLabel;
@property(nonatomic) double scrollOffsetY; // @synthesize scrollOffsetY=_scrollOffsetY;
@property(nonatomic) double scrollHeight; // @synthesize scrollHeight=_scrollHeight;
@property(nonatomic) int var; // @synthesize var=_var;
@property(nonatomic) id <TableViewEmptyViewDelegate> emptyDelegate; // @synthesize emptyDelegate=_emptyDelegate;
@property(retain, nonatomic) LCBaseEmptyView *emptyView; // @synthesize emptyView=_emptyView;
- (void).cxx_destruct;
- (void)sucessShowText:(id)arg1 sucess:(CDUnknownBlockType)arg2;
- (void)errorShowText:(id)arg1 sucess:(CDUnknownBlockType)arg2;
- (void)showText:(id)arg1 sucess:(CDUnknownBlockType)arg2;
- (void)hideText;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithFrame:(struct CGRect)arg1 style:(long long)arg2;
- (void)hideEmpty;
- (void)showEmpty;
- (void)reloadData;
- (void)buttonTouchAction:(long long)arg1;
- (void)screenTouchAction:(long long)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


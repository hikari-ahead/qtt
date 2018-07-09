//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "QKBaseViewController.h"

#import "TYSlidePageScrollViewDataSource-Protocol.h"
#import "TYSlidePageScrollViewDelegate-Protocol.h"

@class NSArray, NSString, TYSlidePageScrollView;

@interface TYSlidePageScrollViewController : QKBaseViewController <TYSlidePageScrollViewDelegate, TYSlidePageScrollViewDataSource>
{
    TYSlidePageScrollView *_slidePageScrollView;
    NSArray *_viewControllers;
}

@property(retain, nonatomic) NSArray *viewControllers; // @synthesize viewControllers=_viewControllers;
@property(nonatomic) __weak TYSlidePageScrollView *slidePageScrollView; // @synthesize slidePageScrollView=_slidePageScrollView;
- (void).cxx_destruct;
- (void)didReceiveMemoryWarning;
- (id)slidePageScrollView:(id)arg1 pageVerticalScrollViewForIndex:(long long)arg2;
- (long long)numberOfPageViewOnSlidePageScrollView;
- (void)addSlidePageScrollView;
- (void)viewDidLoad;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


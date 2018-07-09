//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

#import "UICollectionViewDataSource-Protocol.h"
#import "UICollectionViewDelegate-Protocol.h"
#import "UICollectionViewDelegateFlowLayout-Protocol.h"

@class NSString, QKButton, QKPreSignModel, UICollectionView, UIImageView, UILabel;

@interface QKPreSignHintView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    QKPreSignModel *_signModel;
    UIView *_overlay;
    UIView *_contentView;
    UIImageView *_headerImageView;
    UIView *_mainView;
    UILabel *_titleLabel;
    UILabel *_msgLabel;
    UICollectionView *_signCollectionView;
    QKButton *_closeBtn;
}

@property(retain, nonatomic) QKButton *closeBtn; // @synthesize closeBtn=_closeBtn;
@property(retain, nonatomic) UICollectionView *signCollectionView; // @synthesize signCollectionView=_signCollectionView;
@property(retain, nonatomic) UILabel *msgLabel; // @synthesize msgLabel=_msgLabel;
@property(retain, nonatomic) UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
@property(retain, nonatomic) UIView *mainView; // @synthesize mainView=_mainView;
@property(retain, nonatomic) UIImageView *headerImageView; // @synthesize headerImageView=_headerImageView;
@property(retain, nonatomic) UIView *contentView; // @synthesize contentView=_contentView;
@property(retain, nonatomic) UIView *overlay; // @synthesize overlay=_overlay;
@property(retain, nonatomic) QKPreSignModel *signModel; // @synthesize signModel=_signModel;
- (void).cxx_destruct;
- (double)deltaXFromMissionToCenter;
- (void)dismiss;
- (void)showWithCompletion:(CDUnknownBlockType)arg1;
- (struct CGSize)collectionView:(id)arg1 layout:(id)arg2 sizeForItemAtIndexPath:(id)arg3;
- (id)collectionView:(id)arg1 cellForItemAtIndexPath:(id)arg2;
- (long long)collectionView:(id)arg1 numberOfItemsInSection:(long long)arg2;
- (void)closeBtnClicked:(id)arg1;
- (void)overlayTapped:(id)arg1;
- (void)initSubviews;
- (id)initWithFrame:(struct CGRect)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

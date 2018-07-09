//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class NSString, QKReadAntiCheatingModel, UIImageView, UILabel;

@interface QKReadAntiCheatingView : UIView
{
    _Bool _isShowingTypeTimes;
    unsigned long long _type;
    QKReadAntiCheatingModel *_model;
    CDUnknownBlockType _waitedAntiCheating;
    NSString *_source;
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UIImageView *_closeImageView;
    UIView *_tapView;
}

@property(retain, nonatomic) UIView *tapView; // @synthesize tapView=_tapView;
@property(retain, nonatomic) UIImageView *closeImageView; // @synthesize closeImageView=_closeImageView;
@property(retain, nonatomic) UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
@property(retain, nonatomic) UIImageView *iconImageView; // @synthesize iconImageView=_iconImageView;
@property(nonatomic) NSString *source; // @synthesize source=_source;
@property(copy, nonatomic) CDUnknownBlockType waitedAntiCheating; // @synthesize waitedAntiCheating=_waitedAntiCheating;
@property(nonatomic) _Bool isShowingTypeTimes; // @synthesize isShowingTypeTimes=_isShowingTypeTimes;
@property(retain, nonatomic) QKReadAntiCheatingModel *model; // @synthesize model=_model;
@property(nonatomic) unsigned long long type; // @synthesize type=_type;
- (void).cxx_destruct;
- (void)tap:(id)arg1;
- (void)setHidden:(_Bool)arg1;
- (void)showWithType:(unsigned long long)arg1 waitedAntiCheating:(CDUnknownBlockType)arg2;
- (void)showWithType:(unsigned long long)arg1;
- (void)initSubviews;
- (id)initWithFrame:(struct CGRect)arg1;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

#import "LCFloatViewDelegate-Protocol.h"

@class CAShapeLayer, LCFloatView, NSString, UIImageView, UILabel, UIView, YYAnimatedImageView;

@interface QKRedPacketsFailing : NSObject <LCFloatViewDelegate>
{
    CDUnknownBlockType _moveEndBlock;
    LCFloatView *_floatView;
    double _progress;
    CAShapeLayer *_progressLayer;
    CAShapeLayer *_progressBackgroundLayer;
    UILabel *_titleLabel;
    YYAnimatedImageView *_gif;
    UIImageView *_imageView;
    UIView *_highLightView;
    UIView *_progressView;
    CDUnknownBlockType _tapActionBlock;
}

+ (id)showOnRect:(struct CGRect)arg1;
@property(copy, nonatomic) CDUnknownBlockType tapActionBlock; // @synthesize tapActionBlock=_tapActionBlock;
@property(retain, nonatomic) UIView *progressView; // @synthesize progressView=_progressView;
@property(retain, nonatomic) UIView *highLightView; // @synthesize highLightView=_highLightView;
@property(retain, nonatomic) UIImageView *imageView; // @synthesize imageView=_imageView;
@property(retain, nonatomic) YYAnimatedImageView *gif; // @synthesize gif=_gif;
@property(retain, nonatomic) UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
@property(retain, nonatomic) CAShapeLayer *progressBackgroundLayer; // @synthesize progressBackgroundLayer=_progressBackgroundLayer;
@property(retain, nonatomic) CAShapeLayer *progressLayer; // @synthesize progressLayer=_progressLayer;
@property(nonatomic) double progress; // @synthesize progress=_progress;
@property(retain, nonatomic) LCFloatView *floatView; // @synthesize floatView=_floatView;
@property(copy, nonatomic) CDUnknownBlockType moveEndBlock; // @synthesize moveEndBlock=_moveEndBlock;
- (void).cxx_destruct;
- (void)setImage:(id)arg1;
- (void)setImageGifData:(id)arg1;
- (void)setTitle:(id)arg1;
- (void)avoidRedpacketButtonOnRoot;
- (void)floatViewDidEndMove:(id)arg1;
- (void)floatViewDidMove:(id)arg1;
- (void)floatViewWillBeginMove:(id)arg1;
- (void)__handleActionForTapGesture:(id)arg1;
- (void)setTapActionWithBlock:(CDUnknownBlockType)arg1;
- (void)setupUI;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


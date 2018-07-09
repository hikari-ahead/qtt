//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "QKView.h"

@class UIButton, UIImageView, UILabel, UIView;

@interface ShortVideoPlayNavigationView : QKView
{
    UIButton *_backButton;
    UIImageView *_avatarImgv;
    UILabel *_nicknameLabel;
    UIButton *_followButton;
    UIButton *_moreButton;
    UILabel *_fansLabel;
    UIView *_infoView;
}

@property(retain, nonatomic) UIView *infoView; // @synthesize infoView=_infoView;
@property(retain, nonatomic) UILabel *fansLabel; // @synthesize fansLabel=_fansLabel;
@property(retain, nonatomic) UIButton *moreButton; // @synthesize moreButton=_moreButton;
@property(retain, nonatomic) UIButton *followButton; // @synthesize followButton=_followButton;
@property(retain, nonatomic) UILabel *nicknameLabel; // @synthesize nicknameLabel=_nicknameLabel;
@property(retain, nonatomic) UIImageView *avatarImgv; // @synthesize avatarImgv=_avatarImgv;
@property(retain, nonatomic) UIButton *backButton; // @synthesize backButton=_backButton;
- (void).cxx_destruct;
- (void)configUI:(id)arg1;
- (void)layoutUI;
- (void)createUI;
- (id)initWithFrame:(struct CGRect)arg1;

@end

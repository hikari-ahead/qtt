//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableViewCell.h>

@class CRAVAudioPlayer, CRMessageContentButton, CRMessageFrame, CRMultiArticleView, CRSingleArticleView, CRStatusView, CRVideoPlayerController, NSDictionary, UIImageView, UILabel;
@protocol CRMessageCellDelegate;

@interface CRMessageCell : UITableViewCell
{
    CRAVAudioPlayer *audio;
    _Bool contentVoiceIsPlaying;
    NSDictionary *selectedLinkDic;
    UIImageView *_avatarImage;
    UILabel *_labelTime;
    CRStatusView *_statusView;
    CRMessageContentButton *_btnContent;
    CRSingleArticleView *_singleArticle;
    CRMultiArticleView *_multiArticles;
    CRMessageFrame *_messageFrame;
    id <CRMessageCellDelegate> _delegate;
    CRVideoPlayerController *_videoController;
}

@property(retain, nonatomic) CRVideoPlayerController *videoController; // @synthesize videoController=_videoController;
@property(nonatomic) __weak id <CRMessageCellDelegate> delegate; // @synthesize delegate=_delegate;
@property(retain, nonatomic) CRMessageFrame *messageFrame; // @synthesize messageFrame=_messageFrame;
@property(retain, nonatomic) CRMultiArticleView *multiArticles; // @synthesize multiArticles=_multiArticles;
@property(retain, nonatomic) CRSingleArticleView *singleArticle; // @synthesize singleArticle=_singleArticle;
@property(retain, nonatomic) CRMessageContentButton *btnContent; // @synthesize btnContent=_btnContent;
@property(retain, nonatomic) CRStatusView *statusView; // @synthesize statusView=_statusView;
@property(retain, nonatomic) UILabel *labelTime; // @synthesize labelTime=_labelTime;
@property(retain, nonatomic) UIImageView *avatarImage; // @synthesize avatarImage=_avatarImage;
- (void).cxx_destruct;
- (void)sensorStateChange:(id)arg1;
- (void)makeMaskView:(id)arg1 withImage:(id)arg2;
- (void)clearView;
- (void)loadMultiArticles;
- (void)loadSingleArticle;
- (void)loadBubbleContent;
- (void)loadAvatarImage;
- (void)loadLabelTime;
- (void)showToast:(id)arg1;
- (void)image:(id)arg1 didFinishSavingWithError:(id)arg2 contextInfo:(void *)arg3;
- (void)menuSave:(id)arg1;
- (void)menuCopy:(id)arg1;
- (_Bool)canPerformAction:(SEL)arg1 withSender:(id)arg2;
- (_Bool)canBecomeFirstResponder;
- (void)btnContentLongClick:(id)arg1;
- (void)btnContentClick;
- (void)playVideoWithURL:(id)arg1;
- (void)dealloc;
- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2;

@end


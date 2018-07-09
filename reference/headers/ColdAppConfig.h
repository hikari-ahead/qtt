//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "LCBaseModel.h"

@class BoxLocationModel, InvitePageModel, NSArray, NSDictionary, NSMutableArray, NSString, PushBoxBannerModel, QKReadTime, QKShareInvite, QKVideoHoverAdsModel, QKgloablConfig, RegUnbindMasterModel;

@interface ColdAppConfig : LCBaseModel
{
    QKgloablConfig *_gloablConfig;
    NSArray *_member_tags;
    NSArray *_loaction_member_tags;
    NSArray *_local_member_tags;
    NSArray *_h5_url_cache;
    QKShareInvite *_share_invite;
    NSString *_need_active_notice_img;
    long long _is_first;
    long long _login_index;
    NSDictionary *_little_video_share;
    NSDictionary *_little_video_likeBtn;
    long long _ad_expire;
    NSArray *_ad_no_cache_ids;
    PushBoxBannerModel *_pbBanner;
    NSMutableArray *_unlike_article_list;
    NSMutableArray *_unlike_article_detail;
    NSMutableArray *_unlike_video_list;
    NSMutableArray *_unlike_video_detail;
    InvitePageModel *_invitePageConfig;
    QKVideoHoverAdsModel *_videoHoverads;
    QKReadTime *_readTime;
    BoxLocationModel *_box_location;
    RegUnbindMasterModel *_reg_unbind_master;
}

@property(retain, nonatomic) RegUnbindMasterModel *reg_unbind_master; // @synthesize reg_unbind_master=_reg_unbind_master;
@property(retain, nonatomic) BoxLocationModel *box_location; // @synthesize box_location=_box_location;
@property(retain, nonatomic) QKReadTime *readTime; // @synthesize readTime=_readTime;
@property(retain, nonatomic) QKVideoHoverAdsModel *videoHoverads; // @synthesize videoHoverads=_videoHoverads;
@property(retain, nonatomic) InvitePageModel *invitePageConfig; // @synthesize invitePageConfig=_invitePageConfig;
@property(retain, nonatomic) NSMutableArray *unlike_video_detail; // @synthesize unlike_video_detail=_unlike_video_detail;
@property(retain, nonatomic) NSMutableArray *unlike_video_list; // @synthesize unlike_video_list=_unlike_video_list;
@property(retain, nonatomic) NSMutableArray *unlike_article_detail; // @synthesize unlike_article_detail=_unlike_article_detail;
@property(retain, nonatomic) NSMutableArray *unlike_article_list; // @synthesize unlike_article_list=_unlike_article_list;
@property(retain, nonatomic) PushBoxBannerModel *pbBanner; // @synthesize pbBanner=_pbBanner;
@property(retain, nonatomic) NSArray *ad_no_cache_ids; // @synthesize ad_no_cache_ids=_ad_no_cache_ids;
@property(nonatomic) long long ad_expire; // @synthesize ad_expire=_ad_expire;
@property(retain, nonatomic) NSDictionary *little_video_likeBtn; // @synthesize little_video_likeBtn=_little_video_likeBtn;
@property(retain, nonatomic) NSDictionary *little_video_share; // @synthesize little_video_share=_little_video_share;
@property(nonatomic) long long login_index; // @synthesize login_index=_login_index;
@property(nonatomic) long long is_first; // @synthesize is_first=_is_first;
@property(copy, nonatomic) NSString *need_active_notice_img; // @synthesize need_active_notice_img=_need_active_notice_img;
@property(retain, nonatomic) QKShareInvite *share_invite; // @synthesize share_invite=_share_invite;
@property(retain, nonatomic) NSArray *h5_url_cache; // @synthesize h5_url_cache=_h5_url_cache;
@property(retain, nonatomic) NSArray *local_member_tags; // @synthesize local_member_tags=_local_member_tags;
@property(retain, nonatomic) NSArray *loaction_member_tags; // @synthesize loaction_member_tags=_loaction_member_tags;
@property(retain, nonatomic) NSArray *member_tags; // @synthesize member_tags=_member_tags;
@property(retain, nonatomic) QKgloablConfig *gloablConfig; // @synthesize gloablConfig=_gloablConfig;
- (void).cxx_destruct;
- (id)lcoal_member_tags;
- (id)initWithAttribute:(id)arg1;

@end


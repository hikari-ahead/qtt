//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "LCBaseModel.h"

@class NSString, QuCodeConfig;

@interface ShareConfig : LCBaseModel
{
    _Bool _enabled;
    _Bool _show_point;
    NSString *_background;
    QuCodeConfig *_qupwd_config;
    NSString *_share_invalid_ico;
    NSString *_share_invalid_title;
    NSString *_share_invalid_desc;
    NSString *_share_invalid_button;
    NSString *_qupwd_prompt;
}

@property(copy, nonatomic) NSString *qupwd_prompt; // @synthesize qupwd_prompt=_qupwd_prompt;
@property(copy, nonatomic) NSString *share_invalid_button; // @synthesize share_invalid_button=_share_invalid_button;
@property(copy, nonatomic) NSString *share_invalid_desc; // @synthesize share_invalid_desc=_share_invalid_desc;
@property(copy, nonatomic) NSString *share_invalid_title; // @synthesize share_invalid_title=_share_invalid_title;
@property(copy, nonatomic) NSString *share_invalid_ico; // @synthesize share_invalid_ico=_share_invalid_ico;
@property(nonatomic) _Bool show_point; // @synthesize show_point=_show_point;
@property(nonatomic) _Bool enabled; // @synthesize enabled=_enabled;
@property(retain, nonatomic) QuCodeConfig *qupwd_config; // @synthesize qupwd_config=_qupwd_config;
@property(copy, nonatomic) NSString *background; // @synthesize background=_background;
- (void).cxx_destruct;
- (id)initWithAttribute:(id)arg1;

@end


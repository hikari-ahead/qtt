//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "QKBaseViewController.h"

#import "IMYWebViewDelegate-Protocol.h"

@class IMYWebView, NJKWebViewProgressView, NSData, NSString, UIView;

@interface QKHttpStatusCheckController : QKBaseViewController <IMYWebViewDelegate>
{
    NJKWebViewProgressView *_progressView;
    NSString *_from_url;
    IMYWebView *_webView;
    NSString *_checkUrl;
    NSData *_html;
    UIView *_toolBar;
}

@property(retain, nonatomic) UIView *toolBar; // @synthesize toolBar=_toolBar;
@property(retain, nonatomic) NSData *html; // @synthesize html=_html;
@property(retain, nonatomic) NSString *checkUrl; // @synthesize checkUrl=_checkUrl;
@property(retain, nonatomic) IMYWebView *webView; // @synthesize webView=_webView;
@property(copy, nonatomic) NSString *from_url; // @synthesize from_url=_from_url;
- (void).cxx_destruct;
- (void)commitCheckStatus:(id)arg1;
- (void)handleCheckStatus:(id)arg1;
- (void)webView:(id)arg1 didFailLoadWithError:(id)arg2;
- (void)webViewDidFinishLoad:(id)arg1;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (void)dealloc;
- (id)initWithCheckUrl:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


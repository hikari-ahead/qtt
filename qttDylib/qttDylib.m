//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  qttDylib.m
//  qttDylib
//
//  Created by kuangjeon on 2018/7/9.
//  Copyright (c) 2018 kuangjeon. All rights reserved.
//

#import "qttDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>
#import "HYMManager.h"

CHConstructor{
    NSLog(INSERT_SUCCESS_WELCOME);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
#ifndef __OPTIMIZE__
        CYListenServer(6666);

        MDCycriptManager* manager = [MDCycriptManager sharedInstance];
        [manager loadCycript:NO];

        NSError* error;
        NSString* result = [manager evaluateCycript:@"UIApp" error:&error];
        NSLog(@"result: %@", result);
        if(error.code != 0){
            NSLog(@"error: %@", error.localizedDescription);
        }
#endif
        
    }];
}


CHDeclareClass(ChannelViewController);
CHDeclareClass(ChannelsViewController);
CHDeclareClass(QKContentViewController);
CHDeclareClass(Native_ContentViewController);

CHMethod0(void, ChannelsViewController, viewDidLoad) {
    CHSuper0(ChannelsViewController, viewDidLoad);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HYMManager.shared simUserReadOneArticle];
    });
}

CHMethod0(void, QKContentViewController, viewDidLoad) {
    CHSuper0(QKContentViewController, viewDidLoad);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HYMManager.shared simUserScrollInOneArticle:self];
    });
}

CHMethod0(void, Native_ContentViewController, viewDidLoad) {
    CHSuper0(Native_ContentViewController, viewDidLoad);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HYMManager.shared simUserScrollInOneArticle:self];
    });
}


CHConstructor{
    CHLoadLateClass(ChannelsViewController);
    CHClassHook0(ChannelsViewController, viewDidLoad);
    
    CHLoadLateClass(ChannelViewController);
    
    CHLoadLateClass(QKContentViewController);
    CHClassHook0(QKContentViewController, viewDidLoad);
    
    // 原生阅读页面
    CHLoadLateClass(Native_ContentViewController);
    CHClassHook0(Native_ContentViewController, viewDidLoad);

}


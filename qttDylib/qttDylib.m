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


CHDeclareClass(ChannelViewController); //> 具体频道页面
CHDeclareClass(ChannelsViewController);  //> 频道容器
CHDeclareClass(QKContentViewController); //> 原生图文文章
CHDeclareClass(Native_ContentViewController);
CHDeclareClass(QKIncomeAlertView);//> 金币弹窗
CHDeclareClass(articlePieChartView);
CHDeclareClass(Interface);//> 上报
//CHDeclareClass(AppDelegate); //> AppDelegate

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

CHMethod2(void, QKContentViewController, showCoinValue, id, arg1, message, id, arg2) {
    CHSuper2(QKContentViewController, showCoinValue, arg1, message, arg2);
}

CHMethod0(void, Native_ContentViewController, viewDidLoad) {
    CHSuper0(Native_ContentViewController, viewDidLoad);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HYMManager.shared simUserScrollInOneArticle:self];
    });
}

CHMethod1(void, QKIncomeAlertView, alertWithIncome, id, arg1) {
    NSLog(@"1");
    CHSuper1(QKIncomeAlertView, alertWithIncome, arg1);
}

CHMethod2(void, QKIncomeAlertView, alertMessage, id, arg1, income, id, arg2) {
    NSLog(@"1");
    CHSuper2(QKIncomeAlertView, alertMessage, arg1, income, arg2);
}

CHMethod1(void, QKIncomeAlertView, showInView, id, arg1) {
    NSLog(@"1");
    CHSuper1(QKIncomeAlertView, showInView, arg1);
}

CHMethod1(void, QKIncomeAlertView, show, id, arg1) {
    NSLog(@"1");
    CHSuper1(QKIncomeAlertView, show, arg1);
}

CHMethod1(void, articlePieChartView, setTotalTime, float, arg1) {
    NSLog(@"1");
    CHSuper1(articlePieChartView, setTotalTime, arg1);
}
CHMethod1(void, articlePieChartView, setDurationTime, float, arg1) {
    NSLog(@"1");
    CHSuper1(articlePieChartView, setDurationTime, arg1);
}

CHMethod1(void, articlePieChartView, setNodeCount, float, arg1) {
    NSLog(@"1");
    CHSuper1(articlePieChartView, setNodeCount, arg1);
}

CHMethod2(void, Interface, report, id, arg1, handler, id, arg2) {
    NSLog(@"1");
    CHSuper2(Interface, report, arg1, handler, arg2);
}

CHMethod2(void, Interface, report_readTime, id, arg1, handler, id, arg2) {
    NSLog(@"1");
    CHSuper2(Interface, report_readTime, arg1, handler, arg2);
}

CHMethod2(void, Interface, report_share, id, arg1, handler, id, arg2) {
    NSLog(@"1");
    CHSuper2(Interface, report_share, arg1, handler, arg2);
}

CHMethod2(void, Interface, report_read, id, arg1, handler, id, arg2) {
    NSLog(@"1");
    CHSuper2(Interface, report_read, arg1, handler, arg2);
}

CHMethod2(void, Interface, report_view, id, arg1, handler, id, arg2) {
    NSLog(@"1");
    CHSuper2(Interface, report_view, arg1, handler, arg2);
}

//CHMethod2(void, AppDelegate, application, id, arg1, didFinishLaunchingWithOptions, id, arg2) {
//    CHSuper2(AppDelegate, application, arg1, didFinishLaunchingWithOptions, arg2);
//}

CHConstructor{
    CHLoadLateClass(ChannelsViewController);
    CHClassHook0(ChannelsViewController, viewDidLoad);
    
    CHLoadLateClass(ChannelViewController);
    
    CHLoadLateClass(QKContentViewController);
    CHClassHook0(QKContentViewController, viewDidLoad);
    CHClassHook2(QKContentViewController, showCoinValue, message);

    // 原生阅读页面
    CHLoadLateClass(Native_ContentViewController);
    CHClassHook0(Native_ContentViewController, viewDidLoad);

    //金币
    CHLoadLateClass(QKIncomeAlertView);
    CHClassHook1(QKIncomeAlertView, alertWithIncome);
    CHClassHook2(QKIncomeAlertView, alertMessage, income);
    CHClassHook1(QKIncomeAlertView, showInView);
    CHClassHook1(QKIncomeAlertView, show);
    
    //金币进度师徒
    CHLoadLateClass(articlePieChartView);
    CHClassHook1(articlePieChartView, setTotalTime);
    CHClassHook1(articlePieChartView, setDurationTime);
    CHClassHook1(articlePieChartView, setNodeCount);

    // 上报
    CHLoadLateClass(Interface);
    CHClassHook2(Interface, report, handler);
    CHClassHook2(Interface, report_readTime, handler);
    CHClassHook2(Interface, report_share, handler);
    CHClassHook2(Interface, report_read, handler);
    CHClassHook2(Interface, report_view, handler);
    
    //AppDelegate
//    CHLoadLateClass(AppDelegate);
//    CHClassHook2(AppDelegate, application, didFinishLaunchingWithOptions);
}


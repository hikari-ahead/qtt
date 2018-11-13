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
#import "HYMBgTaskManager.h"
#import "UserModel.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

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
        [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
        
    }];
}


CHDeclareClass(ChannelViewController); //> 具体频道页面
CHDeclareClass(ChannelsViewController);  //> 频道容器
CHDeclareClass(QKContentViewController); //> 原生图文文章
CHDeclareClass(Native_ContentViewController);
CHDeclareClass(QKIncomeAlertView);//> 金币弹窗
CHDeclareClass(articlePieChartView);
CHDeclareClass(Interface);//> 上报
CHDeclareClass(NSString);
CHDeclareClass(Schemes);
CHDeclareClass(AFHTTPSessionManager);
//CHDeclareClass(AppDelegate); //> AppDelegate

CHMethod0(void, ChannelsViewController, viewDidLoad) {
    CHSuper0(ChannelsViewController, viewDidLoad);
    HYMBgTaskManager.shared.targetVC = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HYMBgTaskManager.shared addSettingButtonToWindow];
    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [HYMManager.shared simUserReadOneArticle];
//    });
}

CHMethod0(void, QKContentViewController, viewDidLoad) {
    CHSuper0(QKContentViewController, viewDidLoad);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [HYMManager.shared simUserScrollInOneArticle:self];
//    });
}

CHMethod2(void, QKContentViewController, showCoinValue, id, arg1, message, id, arg2) {
    CHSuper2(QKContentViewController, showCoinValue, arg1, message, arg2);
}

CHMethod0(void, Native_ContentViewController, viewDidLoad) {
    CHSuper0(Native_ContentViewController, viewDidLoad);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [HYMManager.shared simUserScrollInOneArticle:self];
//    });
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

CHClassMethod2(void, Interface, nextReadtimer, id, arg1, handler, id, arg2) {
    NSLog(@"1");
    CHSuper2(Interface, nextReadtimer, arg1, handler, arg2);
}

//CHMethod2(void, AppDelegate, application, id, arg1, didFinishLaunchingWithOptions, id, arg2) {
//    CHSuper2(AppDelegate, application, arg1, didFinishLaunchingWithOptions, arg2);
//}

CHMethod1(id, NSString, stringByAppendingPathComponent, id, arg1) {
    id ori = CHSuper1(NSString, stringByAppendingPathComponent, arg1);
    NSLog(@"1");
    return ori;
}

CHMethod1(id, Schemes, initWithLink, id, arg1) {
    id ori = CHSuper1(Schemes, initWithLink, arg1);
    NSLog(@"1");
    return ori;
}
//AFHTTPSessionManager POST:parameters:progress:success:failure:
CHMethod5(id, AFHTTPSessionManager, POST, id, arg1, parameters, id, arg2, progress, id, arg3, success, id, arg4, failure, id, arg5) {
    NSLog(@"1");
    if (!HYMBgTaskManager.shared.shouldInterceptAllDeviceCode) {
        id ori = CHSuper5(AFHTTPSessionManager, POST, arg1, parameters, arg2, progress, arg3, success, arg4, failure, arg5);
        return ori;
    }
    id parms = arg2;
    if (HYMBgTaskManager.shared.shouldInterceptAllDeviceCode && [arg2 isKindOfClass:NSClassFromString(@"BundleModel")]) {
        [arg2 performSelector:@selector(params)][@"deviceCode"] = HYMBgTaskManager.shared.currentRegisterDeviceUUID;
    }
    if (HYMBgTaskManager.shared.shouldInterceptAllDeviceCode && [arg1 containsString:@"/member/quickLoginV2"]) {
        NSLog(@"拦截注册快捷登录"); // 以来getList返回的key
        NSMutableDictionary *dic = [HYMBgTaskManager.shared.lastSMSRegisterQuickLoginBundle performSelector:@selector(params)];
        dic[@"deviceCode"] = HYMBgTaskManager.shared.currentRegisterDeviceUUID;
        Class cls = objc_getClass("LCHttpEngine");
        NSString *qdata = [cls performSelector:@selector(apiSecure:) withObject:dic][@"qdata"];
        NSLog(@"当前生成qdata:%@", qdata);
        parms = @{@"qdata": qdata};
    }
    
    if (HYMBgTaskManager.shared.shouldInterceptAllDeviceCode && [arg1 containsString:@"modifyPwdBySMS"]) {
        arg2[@"deviceCode"] = HYMBgTaskManager.shared.currentRegisterDeviceUUID;
        [arg2 removeObjectForKey:@"sign"];
        Class cls = objc_getClass("LCHttpEngine");
        id sign = [cls performSelector:@selector(getSign:) withObject:arg2];
        arg2[@"sign"] = sign;
    }
    
    if ([arg1 containsString:@"/mission/intPointReward"] && HYMBgTaskManager.shared.isProcessing) {
        // 拦截每小时金币奖励获取
        NSMutableDictionary *newParams = [HYMBgTaskManager.shared baseDicForCurrentIndex];
        Class cls = objc_getClass("LCHttpEngine");
        id sign = [cls performSelector:@selector(getSign:) withObject:newParams];
        newParams[@"sign"] = sign;
        parms = newParams;
    }
    
    id ori1 = CHSuper5(AFHTTPSessionManager, POST, arg1, parameters, parms, progress, arg3, success, arg4, failure, arg5);
    return ori1;
}


CHMethod5(id, AFHTTPSessionManager, GET, id, arg1, parameters, id, arg2, progress, id, arg3, success, id, arg4, failure, id, arg5) {
    id ori1;
    if ([arg1 containsString:@"readtimer/report"]) {
        // 替换model中的param
        id readtimerBundle = HYMBgTaskManager.shared.lastReadtimerBunlde;
        NSDictionary *dic = [readtimerBundle performSelector:@selector(params)];
        NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
        NSUUID *uuid = [NSUUID UUID];
        NSString *uuidStr = [uuid UUIDString];
        [mdic setValue:uuidStr forKey:@"uuid"];
        // 文章
        long contentId = 134062081 + (arc4random() % 100);
        [mdic setValue:@(contentId).stringValue forKey:@"contentID"];
        // 任务类型
        [mdic setValue:@"article" forKey:@"taskType"];
        // key
        [mdic setValue:@"" forKey:@"key"];
        NSString *timeStr = @([[NSDate new] timeIntervalSince1970]).stringValue;
        [mdic setValue:[timeStr componentsSeparatedByString:@"."].firstObject forKey:@"time"];
        [readtimerBundle performSelector:@selector(setParams:) withObject:mdic];
        // 生成新的qdata
        Class cls = objc_getClass("LCHttpEngine");
        NSDictionary *qdataDic = [cls performSelector:@selector(apiSecure:) withObject:mdic];
        NSLog(@"当前生成qdata:%@", [qdataDic valueForKey:@"qdata"]);
        ori1 = CHSuper5(AFHTTPSessionManager, GET, arg1, parameters, qdataDic, progress, arg3, success, arg4, failure, arg5);
    } else {
        ori1 = CHSuper5(AFHTTPSessionManager, GET, arg1, parameters, arg2, progress, arg3, success, arg4, failure, arg5);
    }
    return ori1;
}

//AFHTTPSessionManager GET:parameters:progress:success:failure:
//CHMethod5(id, AFHTTPSessionManager, GET, id, arg1, parameters, id, arg2, progress, id, arg3, success, id, arg4, failure, id, arg5) {
//    NSLog(@"1");
//    if (!HYMBgTaskManager.shared.shouldInterceptAllDeviceCode) {
//        id ori = CHSuper5(AFHTTPSessionManager, GET, arg1, parameters, arg2, progress, arg3, success, arg4, failure, arg5);
//        return ori;
//    }
//
//    id parms = arg2;
//    id rs = [((NSObject *)self) performSelector:@selector(requestSerializer)];
//    id headers = [rs performSelector:@selector(mutableHTTPRequestHeaders)];
//    if (HYMBgTaskManager.shared.isProcessing) {
//        headers[@"User-Agent"] = [HYMBgTaskManager.shared userAgentForCurrnetIndex];
//    }
//    if (HYMBgTaskManager.shared.shouldInterceptAllDeviceCode && [arg2 isKindOfClass:NSClassFromString(@"BundleModel")]) {
//        [arg2 performSelector:@selector(params)][@"deviceCode"] = HYMBgTaskManager.shared.currentRegisterDeviceUUID;
//    }
//
//    if (HYMBgTaskManager.shared.shouldInterceptAllDeviceCode && [arg1 containsString:@"/member/loginV2"]) {
//        NSLog(@"拦截登录，突破设备限制"); // 以来getList返回的key
//        NSMutableDictionary *dic = [HYMBgTaskManager.shared.lastCommonLoginBundle performSelector:@selector(params)];
//        dic[@"deviceCode"] = HYMBgTaskManager.shared.currentRegisterDeviceUUID;
//        Class cls = objc_getClass("LCHttpEngine");
//        NSString *qdata = [cls performSelector:@selector(apiSecure:) withObject:dic][@"qdata"];
//        NSLog(@"当前生成qdata:%@", qdata);
//        parms = @{@"qdata": qdata};
//    }
//
//    if ([arg1 isEqualToString:@"https://api.1sapp.com/app/getGuide"] && HYMBgTaskManager.shared.isProcessing) {
//        // 获取GUID，替换params
//        NSMutableDictionary *newParams = [HYMBgTaskManager.shared paramsForGetGuide];
//        Class cls = objc_getClass("LCHttpEngine");
//
//        id sign = [cls performSelector:@selector(getSign:) withObject:newParams];
//        newParams[@"sign"] = sign;
//        parms = newParams;
//    }
//    if ([arg1 containsString:@"https://api.1sapp.com/member/loginV2"] && HYMBgTaskManager.shared.isProcessing) {
//        NSLog(@"拦截登录");
//        parms = @{@"qdata": [HYMBgTaskManager.shared loginQdataForCurrentIndex]};
//    }
//    if ([arg1 containsString:@"/readtimer/report"] && HYMBgTaskManager.shared.isProcessing) {
//        NSLog(@"拦截金币");
//        parms = @{@"qdata": [HYMBgTaskManager.shared readTimerQdataForCurrentIndex]};
//    }
//
//    if ([arg1 containsString:@"/content/readV2"] && HYMBgTaskManager.shared.isProcessing) {
//        NSString *qdata = [HYMBgTaskManager.shared readV2QdataForCurrentIndex];
//        parms = @{@"qdata": qdata};
//    }
//
//    if ([arg1 containsString:@"/content/getListV2"] && HYMBgTaskManager.shared.isProcessing) {
//        NSLog(@"拦截获取列表"); // 以来getList返回的key
//        parms = @{@"qdata": [HYMBgTaskManager.shared getListQdataForCurrentIndex]};
//    }
//
//    if ([arg1 containsString:@"/member/getMemberInfo"] && HYMBgTaskManager.shared.isProcessing) {
//        NSLog(@"拦截用户信息");
//        NSMutableDictionary *newParams = [HYMBgTaskManager.shared baseDicForCurrentIndex];
//        Class cls = objc_getClass("LCHttpEngine");
//        id sign = [cls performSelector:@selector(getSign:) withObject:newParams];
//        newParams[@"sign"] = sign;
//        parms = newParams;
//    }
//
//    if ([arg1 isEqualToString:@"https://api.1sapp.com/captcha/getSmsCaptcha"] || [arg1 isEqualToString:@"https://api.1sapp.com/captcha/getImgCaptcha2"]) {
//        // 拦截用户注册验证码，图形请求码
//        [parms removeObjectForKey:@"sign"];
//        parms[@"deviceCode"] = HYMBgTaskManager.shared.currentRegisterDeviceUUID;
//        Class cls = objc_getClass("LCHttpEngine");
//        id sign = [cls performSelector:@selector(getSign:) withObject:parms];
//        parms[@"sign"] = sign;
//        UserModel *u = [UserModel new];
//        u.phone = parms[@"telephone"];
//        u.device_code = parms[@"deviceCode"];
//        __block BOOL exist = NO;
//        [HYMBgTaskManager.shared.registerdUserModels enumerateObjectsUsingBlock:^(UserModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj.device_code isEqualToString:u.device_code]) {
//                exist = YES;
//            }
//        }];
//        if (!exist) {
//            [HYMBgTaskManager.shared.registerdUserModels addObject:u];
//        }
//    }
//    id ori1 = CHSuper5(AFHTTPSessionManager, GET, arg1, parameters, parms, progress, arg3, success, arg4, failure, arg5);
//    return ori1;
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
    CHClassHook2(Interface, nextReadtimer, handler);
    //AppDelegate
//    CHLoadLateClass(AppDelegate);
//    CHClassHook2(AppDelegate, application, didFinishLaunchingWithOptions);
    
    CHLoadLateClass(NSString);
    CHClassHook1(NSString, stringByAppendingPathComponent);
    
    CHLoadLateClass(Schemes);
    CHClassHook1(Schemes, initWithLink);
    
    //AFHTTPSessionManager GET:parameters:progress:success:failure:
    CHLoadLateClass(AFHTTPSessionManager);
    CHClassHook5(AFHTTPSessionManager, GET, parameters, progress, success, failure);
    CHClassHook5(AFHTTPSessionManager, POST, parameters, progress, success, failure);

}

#pragma clang diagnostic pop

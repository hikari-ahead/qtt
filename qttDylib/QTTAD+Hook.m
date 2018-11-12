//
//  QTTAD+Hook.m
//  qttDylib
//
//  Created by resober on 2018/11/12.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "QTTAD+Hook.h"
#import <objc/runtime.h>
#import "Interface+Hook.h"

@implementation NSObject(ADHook)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            Class cls = objc_getClass("AdeazLoader");
            SEL oriSEL1 = @selector(adeaz_GETWithUrl:Success:Failed:);
            SEL newSEL1 = @selector(mtcpClass_adeaz_GETWithUrl:Success:Failed:);
            NSString *oriStr1 = NSStringFromSelector(oriSEL1);
            NSString *newStr1 = NSStringFromSelector(newSEL1);
            MTCrashProtectorClassMethodSwizzling(cls, oriStr1, newStr1);
        }

        {
            Class cls = objc_getClass("AdsNativeAd");
            SEL oriSEL1 = @selector(loadAdisTest:slotid:reqcount:);
            SEL newSEL1 = @selector(mtcpClass_loadAdisTest:slotid:reqcount:);
            NSString *oriStr1 = NSStringFromSelector(oriSEL1);
            NSString *newStr1 = NSStringFromSelector(newSEL1);
            MTCrashProtectorClassMethodSwizzling(cls, oriStr1, newStr1);
        }

        {
            Class cls = objc_getClass("Interface");
            SEL oriSEL = @selector(getChannelList:handler:);
            SEL newSEL = @selector(mtcpClass_getChannelList:handler:);
            NSString *oriStr = NSStringFromSelector(oriSEL);
            NSString *newStr = NSStringFromSelector(newSEL);
            MTCrashProtectorClassMethodSwizzling(cls, oriStr, newStr);
        }

        {
            Class cls = objc_getClass("Interface");
            SEL oriSEL = @selector(getDefaultChannelList:handler:);
            SEL newSEL = @selector(mtcpClass_getDefaultChannelList:handler:);
            NSString *oriStr = NSStringFromSelector(oriSEL);
            NSString *newStr = NSStringFromSelector(newSEL);
            MTCrashProtectorClassMethodSwizzling(cls, oriStr, newStr);
        }

    });
}

+ (void)mtcpClass_adeaz_GETWithUrl:(id)arg1 Success:(id)arg2 Failed:(id)arg3 {
    [self mtcpClass_adeaz_GETWithUrl:arg1 Success:arg2 Failed:arg3];
    NSLog(@"1");
}

+ (void)mtcpClass_getChannelList:(id)arg1 handler:(id)arg2 {
    [self mtcpClass_getChannelList:arg1 handler:arg2];
    NSLog(@"1");
}

+ (void)mtcpClass_getDefaultChannelList:(id)arg1 handler:(id)arg2 {
    [self mtcpClass_getDefaultChannelList:arg1 handler:arg2];
    NSLog(@"1");
}
@end

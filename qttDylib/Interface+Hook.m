//
//  Interface+Hook.m
//  qttDylib
//
//  Created by kuangjeon on 2018/7/11.
//  Copyright © 2018年 kuangjeon. All rights reserved.
//

#import "Interface+Hook.h"
#import <objc/runtime.h>
#import "HYMBgTaskManager.h"

#define MTCrashProtectorInstanceMethodSwizzling(cls, oriStr, newStr) {\
SEL originalSEL = NSSelectorFromString(oriStr);\
SEL newSEL = NSSelectorFromString(newStr);\
Method originalMethod = class_getInstanceMethod(cls, originalSEL);\
Method newMethod = class_getInstanceMethod(cls, newSEL);\
BOOL didAddMethod = class_addMethod(cls, originalSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));\
if (didAddMethod) {\
class_replaceMethod(cls, originalSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));\
}else {\
method_exchangeImplementations(originalMethod, newMethod);\
}\
NSLog(@"MTCrashProtector Instance Method Swizzling\n-> cls:%@, ori:%@, new:%@ didAddMethod:%@", cls, NSStringFromSelector(originalSEL), NSStringFromSelector(newSEL), didAddMethod ? @"YES" : @"NO");\
}

#define MTCrashProtectorClassMethodSwizzling(cls, oriStr, newStr) {\
SEL originalSEL = NSSelectorFromString(oriStr);\
SEL newSEL = NSSelectorFromString(newStr);\
Method originalMethod = class_getClassMethod(cls, originalSEL);\
Method newMethod = class_getClassMethod(cls, newSEL);\
Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);\
BOOL didAddMethod = class_addMethod(metacls, originalSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));\
if (didAddMethod) {\
class_replaceMethod(metacls, originalSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));\
}else {\
method_exchangeImplementations(originalMethod, newMethod);\
}\
NSLog(@"MTCrashProtector Class Method Swizzling\n-> metacls:%@, ori:%@, new:%@ didAddMethod:%@", metacls, NSStringFromSelector(originalSEL), NSStringFromSelector(newSEL), didAddMethod ? @"YES" : @"NO");\
}

@implementation NSObject(Hook)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = objc_getClass("Interface");
        SEL oriSEL4 = @selector(nextReadtimer:handler:);
        SEL newSEL4 = @selector(mtcpClass_nextReadtimer:handler:);
        NSString *oriStr4 = NSStringFromSelector(oriSEL4);
        NSString *newStr4 = NSStringFromSelector(newSEL4);
        MTCrashProtectorClassMethodSwizzling(cls, oriStr4, newStr4);
        
        SEL oriSEL1 = @selector(bundleWithParams:);
        SEL newSEL1 = @selector(mtcpClass_bundleWithParams:);
        NSString *oriStr1 = NSStringFromSelector(oriSEL1);
        NSString *newStr1 = NSStringFromSelector(newSEL1);
        MTCrashProtectorClassMethodSwizzling(cls, oriStr1, newStr1);
        
        SEL oriSEL6 = @selector(logout:handler:);
        SEL newSEL6 = @selector(mtcpClass_logout:handler:);
        NSString *oriStr6 = NSStringFromSelector(oriSEL6);
        NSString *newStr6 = NSStringFromSelector(newSEL6);
        MTCrashProtectorClassMethodSwizzling(cls, oriStr6, newStr6);
        
        SEL oriSEL12 = @selector(getMemberInfo:handler:);
        SEL newSEL12 = @selector(mtcpClass_getMemberInfo:handler:);
        NSString *oriStr12 = NSStringFromSelector(oriSEL12);
        NSString *newStr12 = NSStringFromSelector(newSEL12);
        MTCrashProtectorClassMethodSwizzling(cls, oriStr12, newStr12);

        SEL oriSEL14 = @selector(getList:handler:);
        SEL newSEL14 = @selector(mtcpClass_getList:handler:);
        NSString *oriStr14 = NSStringFromSelector(oriSEL14);
        NSString *newStr14 = NSStringFromSelector(newSEL14);
        MTCrashProtectorClassMethodSwizzling(cls, oriStr14, newStr14);
        
        SEL oriSEL13 = @selector(report_read:handler:);
        SEL newSEL13 = @selector(mtcpClass_report_read:handler:);
        NSString *oriStr13 = NSStringFromSelector(oriSEL13);
        NSString *newStr13 = NSStringFromSelector(newSEL13);
        MTCrashProtectorClassMethodSwizzling(cls, oriStr13, newStr13);
        
        SEL oriSEL15 = @selector(getVerifyCode:handler:);
        SEL newSEL15 = @selector(mtcpClass_getVerifyCode:handler:);
        NSString *oriStr15 = NSStringFromSelector(oriSEL15);
        NSString *newStr15 = NSStringFromSelector(newSEL15);
        MTCrashProtectorClassMethodSwizzling(cls, oriStr15, newStr15);
        
        SEL oriSEL16 = @selector(getVerifyPicture:handler:);
        SEL newSEL16 = @selector(mtcpClass_getVerifyPicture:handler:);
        NSString *oriStr16 = NSStringFromSelector(oriSEL16);
        NSString *newStr16 = NSStringFromSelector(newSEL16);
        MTCrashProtectorClassMethodSwizzling(cls, oriStr16, newStr16);
        
        Class cls1 = objc_getClass("LCHttpEngine");
        SEL oriSEL2 = @selector(apiSecure:);
        SEL newSEL2 = @selector(mtcpClass_apiSecure:);
        NSString *oriStr2 = NSStringFromSelector(oriSEL2);
        NSString *newStr2 = NSStringFromSelector(newSEL2);
        MTCrashProtectorClassMethodSwizzling(cls1, oriStr2, newStr2);

        SEL oriSEL8 = @selector(request:method:bundle:handler:);
        SEL newSEL8 = @selector(mtcpClass_request:method:bundle:handler:);
        NSString *oriStr8 = NSStringFromSelector(oriSEL8);
        NSString *newStr8 = NSStringFromSelector(newSEL8);
        MTCrashProtectorClassMethodSwizzling(cls1, oriStr8, newStr8);
        
        SEL oriSEL10 = @selector(getSign:);
        SEL newSEL10 = @selector(mtcpClass_getSign:);
        NSString *oriStr10 = NSStringFromSelector(oriSEL10);
        NSString *newStr10 = NSStringFromSelector(newSEL10);
        MTCrashProtectorClassMethodSwizzling(cls1, oriStr10, newStr10);
        
        Class cls2 = objc_getClass("InnoSecureMain");
        SEL oriSEL3 = @selector(innoSecureEncode:);
        SEL newSEL3 = @selector(mtcpClass_innoSecureEncode:);
        NSString *oriStr3 = NSStringFromSelector(oriSEL3);
        NSString *newStr3 = NSStringFromSelector(newSEL3);
        MTCrashProtectorClassMethodSwizzling(cls2, oriStr3, newStr3);
        
        Class cls3 = objc_getClass("Schemes");
        SEL oriSEL5 = @selector(schemes:);
        SEL newSEL5 = @selector(mtcpClass_schemes:);
        NSString *oriStr5 = NSStringFromSelector(oriSEL5);
        NSString *newStr5 = NSStringFromSelector(newSEL5);
        MTCrashProtectorClassMethodSwizzling(cls3, oriStr5, newStr5);
        
        Class cls4 = objc_getClass("LCHNetworking");
        SEL oriSEL7 = @selector(GET:response:);
        SEL newSEL7 = @selector(mtcpClass_GET:response:);
        NSString *oriStr7 = NSStringFromSelector(oriSEL7);
        NSString *newStr7 = NSStringFromSelector(newSEL7);
        MTCrashProtectorClassMethodSwizzling(cls4, oriStr7, newStr7);
        
        SEL oriSEL11 = @selector(POST:response:);
        SEL newSEL11 = @selector(mtcpClass_POST:response:);
        NSString *oriStr11 = NSStringFromSelector(oriSEL11);
        NSString *newStr11 = NSStringFromSelector(newSEL11);
        MTCrashProtectorClassMethodSwizzling(cls4, oriStr11, newStr11);
        
        Class cls5 = objc_getClass("LCUtility");
        SEL oriSEL9 = @selector(objectForKey:);
        SEL newSEL9 = @selector(mtcpClass_objectForKey:);
        NSString *oriStr9 = NSStringFromSelector(oriSEL9);
        NSString *newStr9 = NSStringFromSelector(newSEL9);
        MTCrashProtectorClassMethodSwizzling(cls5, oriStr9, newStr9);
    });
}

+ (void)mtcpClass_getVerifyCode:(id)arg1 handler:(id)arg2 {
    NSLog(@"1");
    [self mtcpClass_getVerifyCode:arg1 handler:arg2];
}

+ (void)mtcpClass_getVerifyPicture:(id)arg1 handler:(id)arg2 {
    NSLog(@"1");
    [self mtcpClass_getVerifyPicture:arg1 handler:arg2];
}

+ (void)mtcpClass_getList:(id)arg1 handler:(id)arg2 {
    NSLog(@"1");
    [self mtcpClass_getList:arg1 handler:arg2];
}

+ (void)mtcpClass_report_read:(id)arg1 handler:(id)arg2 {
    NSLog(@"1");
    [self mtcpClass_report_read:arg1 handler:arg2];
}

+ (void)mtcpClass_getMemberInfo:(id)arg1 handler:(id)arg2 {
    NSLog(@"1");
    [self mtcpClass_getMemberInfo:arg1 handler:arg2];
}

+ (id)mtcpClass_getSign:(id) arg1 {
    NSLog(@"1");
    id ori = [self mtcpClass_getSign:arg1];
    return ori;
}

+ (id)mtcpClass_objectForKey:(id) key {
    id ori = [self mtcpClass_objectForKey:key];
    if ([key isEqualToString:@"QTT_GUIDE_"]) {
        return nil;
    }
    return ori;
}

+ (id)mtcpClass_request:(NSString *)arg1 method:(unsigned long long)arg2 bundle:(id)arg3 handler:(id)arg4 {
    NSLog(@"1");
    id ori = [self mtcpClass_request:arg1 method:arg2 bundle:arg3 handler:arg4];
    return ori;
}

+ (void)mtcpClass_GET:(id) arg1 response:(id) arg2 {
    if ([[arg1 performSelector:@selector(url)] isEqualToString:@"https://api.1sapp.com/member/logout"]) {
        // 拦截登出
        return;
    }
    [self mtcpClass_GET:arg1 response:arg2];
}

+ (void)mtcpClass_POST:(id) arg1 response:(id) arg2 {
    NSLog(@"1");
    [self mtcpClass_POST:arg1 response:arg2];
}

+ (void)mtcpClass_logout:(id)arg1 handler:(id)arg2 {
    [self mtcpClass_logout:nil handler:arg2];
}

+ (void)mtcpClass_nextReadtimer:(id) arg1 handler:(id) arg2 {
    NSLog(@"1");
    [self mtcpClass_nextReadtimer:arg1 handler:arg2];
    NSLog(@"1");
}

+ (id)mtcpClass_bundleWithParams:(id)arg1 {
    NSLog(@"1");
    id ori = [self mtcpClass_bundleWithParams:arg1];
    NSLog(@"1");
    return ori;
}


+ (id)mtcpClass_apiSecure:(id)arg1 {
    NSLog(@"1");
    id ori = [self mtcpClass_apiSecure:arg1];
    NSLog(@"1");
    return ori;
}

+ (id)mtcpClass_innoSecureEncode:(id)arg1 {
    NSLog(@"1");
    id ori = [self mtcpClass_innoSecureEncode:arg1];
    NSLog(@"1");
    return ori;
}


+ (id)mtcpClass_schemes:(id)arg1 {
    NSLog(@"1");
    id ori = [self mtcpClass_schemes:arg1];
    return ori;
}
@end

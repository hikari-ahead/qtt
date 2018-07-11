//
//  Interface+Hook.m
//  qttDylib
//
//  Created by kuangjeon on 2018/7/11.
//  Copyright © 2018年 kuangjeon. All rights reserved.
//

#import "Interface+Hook.h"
#import <objc/runtime.h>

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
        
        Class cls1 = objc_getClass("LCHttpEngine");
        SEL oriSEL2 = @selector(apiSecure:);
        SEL newSEL2 = @selector(mtcpClass_apiSecure:);
        NSString *oriStr2 = NSStringFromSelector(oriSEL2);
        NSString *newStr2 = NSStringFromSelector(newSEL2);
        MTCrashProtectorClassMethodSwizzling(cls1, oriStr2, newStr2);

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
    });
}

+ (void)mtcpClass_GET:(id) arg1 response:(id) arg2 {
    if ([[arg1 performSelector:@selector(url)] isEqualToString:@"https://api.1sapp.com/member/logout"]) {
        // 拦截登出
        return;
    }
    [self mtcpClass_GET:arg1 response:arg2];
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
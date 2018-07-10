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
        // - Dealloc
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
        
        
        Class cls1 = objc_getClass("LCHttpEngine");
        SEL oriSEL2 = @selector(apiSecure:);
        SEL newSEL2 = @selector(mtcpClass_apiSecure:);
        NSString *oriStr2 = NSStringFromSelector(oriSEL2);
        NSString *newStr2 = NSStringFromSelector(newSEL2);
        MTCrashProtectorClassMethodSwizzling(cls1, oriStr2, newStr2);

    });
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

/** MUQ4QzJEMjQyRjFBNEU0RjFDNkRFMkQ1RjA4NDY0RDcuY0dGeVlXMGZNVFpHTlVRM04wRXRRa1EzTXkwME1FTXhMVUpHUVVNdFJVRTJRa1U1UXpNd09EQkdIblpsY25OcGIyNGZNaDV3YkdGMFptOXliUjlwYjNNPS41V3yuf4TbzREwmfZKSDWBjqv9DIUXrjD27vceEb2FDBVzR5J48bgShV70DyWgTVG+5+y1EHouDc/6tNU+quvf+kcRIKHq0CjAtQZP2uEI6XvAa2z0Lnoi99X0cYrGEO2YioHBl2do8KkBU5iSjdfOGo5UWcO8eCD0/YeFs37IqQMRvNlsxJN+i9COtabGUIYo+qh1lYT6BSbez66Rt9+chusAkh89QzxxtoTEpoVrtTtJPIqtde3MXZ0gptN8goZVmPvRRUiYbb0hT60D2UdFH5/WkreV/Wh+jVhvYA7lNJIpEcW6YKFR4yBlm+qg+qbVGTeedkzaC0PKH8AXunu8wy2dtxJNmZYtfaO8WT4yC80Nt/waoju8x4fzMIfN5fYHQEdETahkR0qHuQ7etx2hwDIGt6dUPaAxYDfh3CTRSSpcjeVzMjVvxABrtiZWhkelyxEiBi0pQAkOykRPTO4Me0yZihLFUHXq1Y+RUnDspAhZXZeTKz3m4i334wDwhSnJNyZQ+Faz7tMRMf4Bft9zwIQrMFz6aU2xB3oqYxd8JGXtaLRF3Y5DHZVktgyac0ns4XQL4FVvh3FRyyG1cXB6k4sGS3h+pQeWge2l5NPFTWG4KwQ3XKuJ1Rjjhmxor7EtwLlc6vEG5ZNbe8MFMgdL9lAMGdNbmbzkpp2sZ7TG2KIgjjNG1RAF/u9i4wqjKWuq66JU58qygHQgZBuVYqTWDuLpIAukj1lN9QwgzhAhj/g=
*/
+ (id)mtcpClass_apiSecure:(id)arg1 {
    NSLog(@"1");
    id ori = [self mtcpClass_apiSecure:arg1];
    NSLog(@"1");
    return ori;
}
@end

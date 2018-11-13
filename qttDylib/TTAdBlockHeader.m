//
//  TTAdBlockHeader.m
//  qttDylib
//
//  Created by resober on 2018/11/13.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "TTAdBlockHeader.h"
#import <UIKit/UIKit.h>

@implementation TTAdBlockHeader
+ (BOOL)isAlienScreenDevice {
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].keyWindow.safeAreaInsets.top > 1) {
            return YES;
        }
    }
    return NO;
}
@end

//
//  UIWindow+TTAdHook.h
//  qttDylib
//
//  Created by resober on 2018/11/13.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define UIEventSubtypeMotionShakeNotification @"UIEventSubtypeMotionShakeNotification"
@interface UIViewController (TTAdHook)
// @override
- (BOOL)canBecomeFirstResponder;
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
@end

NS_ASSUME_NONNULL_END

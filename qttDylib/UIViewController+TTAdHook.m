//
//  UIWindow+TTAdHook.m
//  qttDylib
//
//  Created by resober on 2018/11/13.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "UIViewController+TTAdHook.h"
#import "TTAdBlockViewController.h"

static UIWindow *hookWnd = nil;
@implementation UIViewController (TTAdHook)
- (BOOL)canBecomeFirstResponder {//默认是NO，所以得重写此方法，设成YES
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (hookWnd && !hookWnd.hidden) {
        return;
    }
    NSLog(@"shake");
    hookWnd = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    TTAdBlockViewController *vc = [TTAdBlockViewController new];
    vc.currWnd = hookWnd;
    vc.oldWnd = [UIApplication sharedApplication].keyWindow;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = NO;
    hookWnd.rootViewController = nav;
    hookWnd.windowLevel = UIWindowLevelAlert;
    hookWnd.hidden = NO;
    [hookWnd makeKeyAndVisible];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
}

@end

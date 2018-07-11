//
//  HYMBgTaskManager.m
//  qttDylib
//
//  Created by kuangjeon on 2018/7/11.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "HYMBgTaskManager.h"

static NSString *kRemoteUserDataURL = @"http://ocm1152jt.bkt.clouddn.com/users.json";
static HYMBgTaskManager *instance = nil;
@implementation HYMBgTaskManager
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [HYMBgTaskManager new];
        }
    });
    return instance;
}

- (void)downloadAndParseModel {
    
}
@end

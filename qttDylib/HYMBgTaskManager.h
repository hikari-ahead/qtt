//
//  HYMBgTaskManager.h
//  qttDylib
//
//  Created by kuangjeon on 2018/7/11.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYMBgTaskManager : NSObject
@property (nonatomic, assign) BOOL isProcessing;
+ (instancetype)shared;
- (void)start;
- (NSMutableDictionary *)paramsForGetGuide;
@end

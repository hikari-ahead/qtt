//
//  HYMBgTaskManager.h
//  qttDylib
//
//  Created by kuangjeon on 2018/7/11.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HYMBgTaskManager : NSObject
@property (nonatomic, assign) BOOL isProcessing;
@property (nonatomic, assign, readonly) NSUInteger currentGetGoldIndex;
@property (nonatomic, strong) UIViewController *targetVC;
+ (instancetype)shared;
- (void)start;
- (void)addSettingButtonToWindow;
- (NSMutableDictionary *)paramsForGetGuide;
- (NSString *)loginQdataForCurrentIndex;
- (NSString *)readTimerQdataForCurrentIndex;
- (NSDictionary *)readV2QdataForCurrentIndex;
- (NSString *)getListQdataForCurrentIndex;
- (NSString *)userAgentForCurrnetIndex;
@end

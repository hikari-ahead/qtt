//
//  HYMBgTaskManager.h
//  qttDylib
//
//  Created by kuangjeon on 2018/7/11.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UserModel;
@interface HYMBgTaskManager : NSObject
@property (nonatomic, assign) BOOL isProcessing;
@property (nonatomic, strong) UIViewController *targetVC;
@property (nonatomic, strong, readonly) NSMutableArray<UserModel *> *userModels;
+ (instancetype)shared;
- (void)start;
- (void)stop;
- (void)addSettingButtonToWindow;
- (NSMutableDictionary *)paramsForGetGuide;
- (NSString *)loginQdataForCurrentIndex;
- (NSString *)readTimerQdataForCurrentIndex;
- (NSDictionary *)readV2QdataForCurrentIndex;
- (NSString *)getListQdataForCurrentIndex;
- (NSString *)userAgentForCurrnetIndex;
- (NSMutableDictionary *)baseDicForCurrentIndex;
@end

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
@class HYMRegisterViewController;
@interface HYMBgTaskManager : NSObject
@property(nonatomic, assign) BOOL isProcessing;
@property(nonatomic, strong) UIViewController *targetVC;
@property(nonatomic, strong, readonly) NSMutableArray<UserModel *> *userModels;
@property(nonatomic, strong) NSMutableArray<UserModel *> *registerdUserModels;
@property(nonatomic, strong, readonly) NSString *currentRegisterDeviceUUID;
@property(nonatomic, strong, readonly) HYMRegisterViewController *hymRegisterVC;
@property(nonatomic, assign) BOOL shouldInterceptAllDeviceCode;
@property(nonatomic, strong) id lastSMSRegisterQuickLoginBundle;
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
- (void)generateNewRegisterDeviceUUID;
@end

//
//  TTAdBlockHTTPManager.h
//  qttDylib
//
//  Created by resober on 2018/11/14.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTAdBlockManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTAdBlockHTTPManager : NSObject
+ (instancetype)shared;
- (void)reportAd:(QTTFeedAdModel *)ad
         profile:(QTTUserProfile *)profile
         handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
@end

NS_ASSUME_NONNULL_END

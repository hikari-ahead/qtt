//
//  TTAdBlockManager.h
//  qttDylib
//
//  Created by resober on 2018/11/12.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTAdBlockManager : NSObject
+ (instancetype)shared;
/**
 *  开始自动获取趣头条可见频道feed流中的所有广告
 */
- (void)startFetchingAd;
@end

NS_ASSUME_NONNULL_END

//
//  TTAdBlockHeader.h
//  qttDylib
//
//  Created by resober on 2018/11/13.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface TTAdBlockHeader : NSObject
+ (BOOL)isAlienScreenDevice;
@end

NS_ASSUME_NONNULL_END

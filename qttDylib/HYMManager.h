//
//  HYMManager.h
//  qttDylib
//
//  Created by kuangjeon on 2018/7/9.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ChannelsViewController;
@class ChannelViewController;
@interface HYMManager : NSObject
+ (instancetype)shared;
- (ChannelsViewController *)channelsViewController;
- (void)simUserReadOneArticle;
- (void)simUserScrollInOneArticle:(UIViewController *)contentVC;
- (void)requestLocation;
@end

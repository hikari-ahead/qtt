//
//  TTAdBlockManager.h
//  qttDylib
//
//  Created by resober on 2018/11/12.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTTChannelModel:NSObject
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger isLocalChannel;
@property (nonatomic, strong) NSString *name;
// 关联的数据
/** 当前请求的页数 */
@property (nonatomic, assign) NSInteger page;
/** 重试的次数 */
@property (nonatomic, assign) NSInteger retryTimes;
@end


@interface QTTFeedAdSourceModel:NSObject
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger slotId;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) NSString *tips;
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger ad_source;
@property (nonatomic, assign) NSInteger op;
@property (nonatomic, assign) NSInteger imageType;
// 相关联的请求模型
@property (nonatomic, strong) QTTChannelModel *channelModel;
@end

@interface QTTFeedAdModel:NSObject
/** 显示 */
@property (nonatomic, strong) NSArray *imp;
/** 点击 */
@property (nonatomic, strong) NSArray *clk;
/** 落地页 */
@property (nonatomic, strong) NSString *c_url;
@property (nonatomic, strong) NSString *title;
/** 封面图等等 */
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSArray *ext_urls;
@property (nonatomic, strong) NSString *icon_url;
@property (nonatomic, strong) NSString *desc;
@end


@interface TTAdBlockManager : NSObject
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, QTTChannelModel *> *channels;
@property (nonatomic, strong, readonly) NSMutableArray <QTTFeedAdSourceModel *> *feedAdSourceModels;
@property (nonatomic, strong, readonly) NSMutableArray <QTTFeedAdModel *> *adModels;
@property (nonatomic, strong, readonly) NSNumber *finishedChannelCnt;
@property (nonatomic, strong, readonly) NSNumber *processedAdCnt;
@property (nonatomic, strong, readonly) NSNumber *failedAdCnt;
+ (instancetype)shared;
- (void)startFetchingAd;
@end

NS_ASSUME_NONNULL_END

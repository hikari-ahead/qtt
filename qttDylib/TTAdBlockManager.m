//
//  TTAdBlockManager.m
//  qttDylib
//
//  Created by resober on 2018/11/12.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "TTAdBlockManager.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

static const NSString *kQTTFeedAdModelRelatedChannelModelKey = @"kQTTFeedAdModelRelatedChannelModelKey";
/** 最多重试三次 */
#define kTTAdBlockManagerRetryMaxTimes 3

typedef void(^TTAdListParseBlock)(id bundle, id error);
typedef void(^TTAdretryBlock)(id bundle);

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
@implementation QTTChannelModel
@end

@interface QTTFeedAdModel:NSObject
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
@implementation QTTFeedAdModel
@end


@interface TTAdBlockManager()
@property (nonatomic, strong) NSMutableDictionary<NSString *, QTTChannelModel *> *channels;
@property (nonatomic, strong) NSMutableArray <QTTFeedAdModel *> *feedAdModels;
@property (nonatomic, copy) TTAdListParseBlock block;
@property (nonatomic, copy) TTAdretryBlock retryBlock;
@property (nonatomic, strong) NSNumber *finishCnt;
@end

@implementation TTAdBlockManager

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"finishCnt"];
}

+ (instancetype)shared {
    static TTAdBlockManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[TTAdBlockManager alloc] init];
        }
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup {
    _channels = [NSMutableDictionary new];
    _feedAdModels = [NSMutableArray new];
    _finishCnt = [NSNumber numberWithInt:0];
}

#pragma mark - Ad

- (void)startFetchingAd {
    [self fetchAllChannels];

}

- (void)fetchAllChannels {
    [_channels removeAllObjects];
    // 调用content/getDefaultChannelList?
    // getDefaultChannelList
    // getChannelList
    Class cls = objc_getClass("Interface");
    Class bdcls = objc_getClass("BundleModel");
    NSLock *channelLock = [[NSLock alloc] init];
    id defaultChannelModel = [bdcls performSelector:NSSelectorFromString(@"new")];
    // 解析的次数
    __block NSInteger parserCnt = 0;
    void(^channelParseBlock)(id bundle, id error) = ^(id bundle, id error) {
        NSDictionary *responseObject = [bundle performSelector:@selector(responseObject)];
        if (!error && responseObject) {
            [[responseObject valueForKey:@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                QTTChannelModel *model = [QTTChannelModel new];
                model.cid = [[obj valueForKey:@"id"] integerValue];
                model.name = [obj valueForKey:@"name"];
                [channelLock lock];
                if (![self.channels valueForKey:model.name]) {
                    model.isLocalChannel = [[obj valueForKey:@"is_local_channel"] integerValue];
                    [self.channels setValue:model forKey:model.name];
                }
                [channelLock unlock];
            }];
            NSLog(@"==== getDefaultChannelList:handler:");
        }else {
            NSLog(@"==== fetchAllChannels error: %@", error);
        }
        ++parserCnt;
        if (parserCnt == 2) {
            // 两次请求都处理完了，使用cid去请求页面内容
            [self fetchSlotIds];
        }
    };
    [cls performSelector:@selector(getDefaultChannelList:handler:) withObject:defaultChannelModel withObject:channelParseBlock];

    id channelModel = [bdcls performSelector:NSSelectorFromString(@"new")];
    [cls performSelector:@selector(getChannelList:handler:) withObject:channelModel withObject:channelParseBlock];
}

/**
 *  使用获取的cid，去请求各个频道的页面page = (0,max) 将获取到的 slotId记录下来
 *
 *      cid = 110000;
 *      "content_type" = "1,2,4,3,12";
 *      "max_time" = 0;
 *      op = 2;
 *      page = 1;
 */
- (void)fetchSlotIds {
    // 监听finishCnt
    [self addObserver:self forKeyPath:@"finishCnt" options:NSKeyValueObservingOptionNew context:nil];

    NSLock *finishCntLock = [[NSLock alloc] init];
    NSLock *feedAdModelsLock = [[NSLock alloc] init];
    __weak typeof(self) weakSelf = self;
    // 重试block
    self.retryBlock = ^(id bundle) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        QTTChannelModel *channelModel = [bundle performSelector:@selector(paramTmpForKey:) withObject:kQTTFeedAdModelRelatedChannelModelKey];
        if (channelModel.retryTimes == kTTAdBlockManagerRetryMaxTimes) {
            [finishCntLock lock];
            strongSelf.finishCnt = [NSNumber numberWithUnsignedInteger:(strongSelf.finishCnt.unsignedIntegerValue + 1)];
            [finishCntLock unlock];
        } else {
            ++channelModel.retryTimes;
            [strongSelf fetchSlotIdsWithChannelModel:channelModel parseBlock:strongSelf.block];
        }
    };

    // 解析block
    self.block = ^(id bundle, id error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!error && bundle) {
            NSDictionary *outerData = [[bundle performSelector:@selector(responseObject)] valueForKey:@"data"];
            NSArray *data = [outerData valueForKey:@"data"];
            if (outerData && [outerData valueForKey:@"count"] == 0) {
                // 说明这个频道已经请求到了最后一页
                [finishCntLock lock];
                strongSelf.finishCnt = [NSNumber numberWithUnsignedInteger:(strongSelf.finishCnt.unsignedIntegerValue + 1)];
                [finishCntLock unlock];
            } else if (outerData && data) {
                // 紧接着并发去请求下一个页面
                QTTChannelModel *channelModel = [bundle performSelector:@selector(paramTmpForKey:) withObject:kQTTFeedAdModelRelatedChannelModelKey];
                // 重置新的页面的重试次数
                channelModel.retryTimes = 0;
                ++channelModel.page;
                [strongSelf fetchSlotIdsWithChannelModel:channelModel parseBlock:strongSelf.block];
                // 并发解析数据
                [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSInteger slotId = [[((NSDictionary *)obj) valueForKey:@"slotId"] integerValue];
                    if ([obj isKindOfClass:[NSDictionary class]] && slotId != 0) {
                        QTTFeedAdModel *ad = [QTTFeedAdModel new];
                        ad.index = [[((NSDictionary *)obj) valueForKey:@"slotId"] integerValue];
                        ad.appId = [((NSDictionary *)obj) valueForKey:@"appId"];
                        ad.type = [((NSDictionary *)obj) valueForKey:@"type"];
                        ad.slotId = slotId;
                        ad.cid = [[((NSDictionary *)obj) valueForKey:@"cid"] integerValue];
                        ad.flag = [[((NSDictionary *)obj) valueForKey:@"flag"] integerValue];
                        ad.tips = [((NSDictionary *)obj) valueForKey:@"tips"];
                        ad.times = [[((NSDictionary *)obj) valueForKey:@"times"] integerValue];
                        ad.page = [[((NSDictionary *)obj) valueForKey:@"page"] integerValue];
                        ad.ad_source = [[((NSDictionary *)obj) valueForKey:@"ad_source"] integerValue];
                        ad.op = [[((NSDictionary *)obj) valueForKey:@"op"] integerValue];
                        ad.imageType = [[((NSDictionary *)obj) valueForKey:@"imageType"] integerValue];
                        ad.channelModel = channelModel;
                        [feedAdModelsLock lock];
                        [strongSelf.feedAdModels addObject:ad];
                        [feedAdModelsLock unlock];
                    }
                }];
            }else {
                strongSelf.retryBlock(bundle);
            }

            NSLog(@"==== getList:handler:");
        } else {
            NSLog(@"==== fetchSlotIds error: %@", error);
            strongSelf.retryBlock(bundle);
        }
    };
    [self.channels.allValues enumerateObjectsUsingBlock:^(QTTChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 所有频道并发的去请求，每个频道从页数1开始一直请求到最后一页（没有数据返回了）
        obj.page = 1;
        [self fetchSlotIdsWithChannelModel:obj parseBlock:self.block];
    }];
}


- (void)fetchSlotIdsWithChannelModel:(QTTChannelModel *)channelModel
                          parseBlock:(id)parseBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        Class cls = objc_getClass("Interface");
        Class bdcls = objc_getClass("BundleModel");
        id model = [bdcls performSelector:NSSelectorFromString(@"new")];
        [model performSelector:@selector(addParam:forKey:) withObject:@"1,2,4,3,12" withObject:@"content_type"];
        [model performSelector:@selector(addParam:forKey:) withObject:@(channelModel.page) withObject:@"page"];
        [model performSelector:@selector(addParam:forKey:) withObject:@(2) withObject:@"op"];
        [model performSelector:@selector(addParam:forKey:) withObject:@(0) withObject:@"max_time"];
        [model performSelector:@selector(addParam:forKey:) withObject:@(channelModel.cid) withObject:@"cid"];
        [model performSelector:@selector(addParamTmp:forKey:) withObject:channelModel withObject:kQTTFeedAdModelRelatedChannelModelKey];
        [cls performSelector:@selector(getList:handler:) withObject:model withObject:parseBlock];
    });
}


/**
 *  遍历slotId获取广告内容
 *
 *  https://api.aiclk.com/ga?slotid=1026480&url=http://ad.qutoutiao.net/param?v={"network":"1","channel":"视频","age":"0","lon":"116.3233409035943","keyword":"","lat":"39.97071049170498","sex":"0","firstpage":"0","isp":"46001"}
 */
- (void)fetchAdContents {
    Class cls = objc_getClass("AdeazLoader");
    void(^successBlock)(id bundle, id error) = ^(id bundle, id error) {
        NSLog(@"==== successBlock");
    };

    void(^failedBlock)(id error) = ^(id error) {
        NSLog(@"==== failedBlock");

    };
    [self.feedAdModels enumerateObjectsUsingBlock:^(QTTFeedAdModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *paramUrl = [NSString stringWithFormat:@"http://ad.qutoutiao.net/param?v={\"network\":\"1\",\"channel\":\"%@\",\"age\":\"0\",\"lon\":\"116.3233409035943\",\"keyword\":\"\",\"lat\":\"39.97071049170498\",\"sex\":\"0\",\"firstpage\":\"0\",\"isp\":\"46001\"}", obj.channelModel.name];
        paramUrl = [objc_getClass("NSString") performSelector:@selector(encodeString:) withObject:paramUrl];
        NSString *baseUrl = [NSString stringWithFormat:@"https://api.aiclk.com/ga?slotid=%@&url=%@", @(obj.slotId).stringValue, paramUrl];
        SEL sel = @selector(adeaz_GETWithUrl:Success:Failed:);
        NSMethodSignature *signature = [cls methodSignatureForSelector:sel];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        //self,_cmd...
        [invocation setTarget:cls];
        [invocation setSelector:@selector(adeaz_GETWithUrl:Success:Failed:)];
        [invocation setArgument:&baseUrl atIndex:2];
        [invocation setArgument:&successBlock atIndex:3];
        [invocation setArgument:&failedBlock atIndex:4];
        [invocation invoke];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"finishCnt"] && [change[NSKeyValueChangeNewKey] unsignedIntegerValue] == self.channels.count) {
        NSLog(@"==== 获取广告列表中广告完成");
        [self fetchAdContents];
    }
}

@end

#pragma clang diagnostic pop

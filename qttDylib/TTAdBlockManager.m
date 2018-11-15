//
//  TTAdBlockManager.m
//  qttDylib
//
//  Created by resober on 2018/11/12.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "TTAdBlockManager.h"
#import <objc/runtime.h>
#import "HYMBgTaskManager.h"
#import "TTAdBlockHTTPManager.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

static const NSString *kQTTFeedAdModelRelatedChannelModelKey = @"kQTTFeedAdModelRelatedChannelModelKey";
static const NSString *kQTTFeedAdModelRelatedAdSourceModelKey = @"kQTTFeedAdModelRelatedAdSourceModelKey";

/** 最多重试三次 */
#define kTTAdBlockManagerRetryMaxTimes 3

typedef void(^TTAdListParseBlock)(id bundle, id error);
typedef void(^TTAdretryBlock)(id bundle);
typedef void(^TTAdSuccessBlock)(id bundle, id error);
typedef void(^TTAdFailedBlock)(id bundle);

@implementation QTTChannelModel
@end

@implementation QTTFeedAdSourceModel
@end

@implementation QTTUserProfile
@end

@implementation QTTFeedAdModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    QTTFeedAdModel *ad = [QTTFeedAdModel new];
    ad.imp = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(imp))];
    ad.clk = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(clk))];
    ad.c_url = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(c_url))] stringValue];
    ad.title = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(title))] stringValue];
    ad.url = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(url))] stringValue];
    ad.ext_urls = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(ext_urls))];
    ad.icon_url = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(icon_url))] stringValue];
    ad.desc = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(desc))] stringValue];
    return ad;

}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.imp forKey:NSStringFromSelector(@selector(imp))];
    [aCoder encodeObject:self.clk forKey:NSStringFromSelector(@selector(clk))];
    [aCoder encodeObject:self.c_url forKey:NSStringFromSelector(@selector(c_url))];
    [aCoder encodeObject:self.title forKey:NSStringFromSelector(@selector(title))];
    [aCoder encodeObject:self.url forKey:NSStringFromSelector(@selector(url))];
    [aCoder encodeObject:self.ext_urls forKey:NSStringFromSelector(@selector(ext_urls))];
    [aCoder encodeObject:self.icon_url forKey:NSStringFromSelector(@selector(icon_url))];
    [aCoder encodeObject:self.desc forKey:NSStringFromSelector(@selector(desc))];
}
@end

@interface TTAdBlockManager()
@property (nonatomic, strong) NSMutableDictionary<NSString *, QTTChannelModel *> *channels;
@property (nonatomic, strong) NSMutableArray <QTTFeedAdSourceModel *> *feedAdSourceModels;
@property (nonatomic, strong) NSMutableArray <QTTFeedAdModel *> *adModels;
@property (nonatomic, copy) TTAdListParseBlock block;
@property (nonatomic, copy) TTAdretryBlock retryBlock;
@property (nonatomic, copy) TTAdSuccessBlock successBlock;
@property (nonatomic, copy) TTAdFailedBlock failedBlock;
@property (nonatomic, strong) NSNumber *finishedChannelCnt;
@property (nonatomic, strong) NSNumber *processedAdCnt;
@property (nonatomic, strong) NSNumber *failedAdCnt;
@property (nonatomic, strong) NSLock *adModelsLock;
@property (nonatomic, strong) NSLock *finishCntLock;
@property (nonatomic, strong) NSLock *feedAdSourceModelsLock;

@end

@implementation TTAdBlockManager

- (void)dealloc {
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(finishedChannelCnt))];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(processedAdCnt))];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(feedAdSourceModels))];
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
    _feedAdSourceModels = [NSMutableArray new];
    _adModels = [NSMutableArray new];
    _finishedChannelCnt = [NSNumber numberWithInt:0];
    _processedAdCnt = [NSNumber numberWithInt:0];
    _failedAdCnt = [NSNumber numberWithInt:0];
    _adModelsLock = [NSLock new];
    _finishCntLock = [[NSLock alloc] init];
    _feedAdSourceModelsLock = [[NSLock alloc] init];

}

#pragma mark - Ad

- (void)startFetchingAd {
    [[HYMBgTaskManager shared] startRequestLocation];
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
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(finishedChannelCnt)) options:NSKeyValueObservingOptionNew context:nil];


    __weak typeof(self) weakSelf = self;
    // 重试block
    self.retryBlock = ^(id bundle) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        QTTChannelModel *channelModel = [bundle performSelector:@selector(paramTmpForKey:) withObject:kQTTFeedAdModelRelatedChannelModelKey];
        if (channelModel.retryTimes == kTTAdBlockManagerRetryMaxTimes) {
            [strongSelf.finishCntLock lock];
            strongSelf.finishedChannelCnt = [NSNumber numberWithUnsignedInteger:(strongSelf.finishedChannelCnt.unsignedIntegerValue + 1)];
            [strongSelf.finishCntLock unlock];
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
                [strongSelf.finishCntLock lock];
                strongSelf.finishedChannelCnt = [NSNumber numberWithUnsignedInteger:(strongSelf.finishedChannelCnt.unsignedIntegerValue + 1)];
                [strongSelf.finishCntLock unlock];
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
                        QTTFeedAdSourceModel *adSource = [QTTFeedAdSourceModel new];
                        adSource.index = [[((NSDictionary *)obj) valueForKey:@"slotId"] integerValue];
                        adSource.appId = [((NSDictionary *)obj) valueForKey:@"appId"];
                        adSource.type = [((NSDictionary *)obj) valueForKey:@"type"];
                        adSource.slotId = slotId;
                        adSource.cid = [[((NSDictionary *)obj) valueForKey:@"cid"] integerValue];
                        adSource.flag = [[((NSDictionary *)obj) valueForKey:@"flag"] integerValue];
                        adSource.tips = [((NSDictionary *)obj) valueForKey:@"tips"];
                        adSource.times = [[((NSDictionary *)obj) valueForKey:@"times"] integerValue];
                        adSource.page = [[((NSDictionary *)obj) valueForKey:@"page"] integerValue];
                        adSource.ad_source = [[((NSDictionary *)obj) valueForKey:@"ad_source"] integerValue];
                        adSource.op = [[((NSDictionary *)obj) valueForKey:@"op"] integerValue];
                        adSource.imageType = [[((NSDictionary *)obj) valueForKey:@"imageType"] integerValue];
                        adSource.channelModel = channelModel;
                        [strongSelf.feedAdSourceModelsLock lock];
                        [strongSelf.feedAdSourceModels addObject:adSource];
                        [strongSelf.feedAdSourceModelsLock unlock];
                        // 去请求广告数据并上报
                        [strongSelf fetchAdContents:adSource];
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

    // 监听processedAdCnt
    [self addObserver:self forKeyPath:@"processedAdCnt" options:NSKeyValueObservingOptionNew context:nil];
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
- (void)fetchAdContents:(QTTFeedAdSourceModel *)adSourceModel {
    NSLock *finishedAdCntLock = [[NSLock alloc] init];
    Class cls = objc_getClass("AdeazLoader");
    __weak typeof(self) weakSelf = self;
    self.successBlock = ^(id bundle, id error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"==== successBlock");
        __block QTTFeedAdModel *ad = [QTTFeedAdModel new];
        NSDictionary *data = [bundle valueForKey:@"content"];
        ad.imp = [data valueForKey:@"imp"];
        ad.clk = [data valueForKey:@"clk"];
        ad.title = [data valueForKey:@"title"];
        ad.desc = [data valueForKey:@"desc"];
        ad.ext_urls = [data valueForKey:@"ext_urls"];
        ad.icon_url = [data valueForKey:@"icon_url"];
        ad.c_url = [data valueForKey:@"c_url"];
        ad.url = [data valueForKey:@"url"];
        [self->_adModelsLock lock];
        [strongSelf.adModels addObject:ad];
        [self->_adModelsLock unlock];
        [finishedAdCntLock lock];
        strongSelf.processedAdCnt = [NSNumber numberWithUnsignedInteger:(strongSelf.processedAdCnt.unsignedIntegerValue + 1)];
        [finishedAdCntLock unlock];
        QTTUserProfile *profile = [QTTUserProfile new];
        profile.account = [objc_getClass("LCUserManager") performSelector:@selector(userId)];
        profile.city = @"北京";
        profile.systemPlatform = @"iOS";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [strongSelf.feedAdSourceModelsLock lock];
            [strongSelf.feedAdSourceModels removeObject:adSourceModel];
            [strongSelf.feedAdSourceModelsLock unlock];
        });

        [[TTAdBlockHTTPManager shared] reportAd:ad profile:profile handler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self->_adModelsLock lock];
                    [strongSelf.adModels removeObject:ad];
                    ad = nil;
                    [self->_adModelsLock unlock];
                });
            } else {
                // 错误发生的话0.5秒后重试
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    strongSelf.successBlock(bundle, error);
                });
            }
        }];
    };

    self.failedBlock = ^(id error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"==== failedBlock");
        [finishedAdCntLock lock];
        strongSelf.processedAdCnt = [NSNumber numberWithUnsignedInteger:(strongSelf.processedAdCnt.unsignedIntegerValue + 1)];
        strongSelf.failedAdCnt = [NSNumber numberWithUnsignedInteger:(strongSelf.failedAdCnt.unsignedIntegerValue + 1)];
        [finishedAdCntLock unlock];
    };

    QTTFeedAdSourceModel *obj = adSourceModel;
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
    [invocation setArgument:&self->_successBlock atIndex:3];
    [invocation setArgument:&self->_failedBlock atIndex:4];
    [invocation invoke];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(finishedChannelCnt))] && [change[NSKeyValueChangeNewKey] unsignedIntegerValue] == self.channels.count) {
        NSLog(@"==== 获取广告列表中广告数据源完成");
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(feedAdSourceModels)) options:NSKeyValueObservingOptionNew context:nil];
    }

    if ([keyPath isEqualToString:NSStringFromSelector(@selector(feedAdSourceModels))] && [change[NSKeyValueChangeNewKey] unsignedIntegerValue] == 0) {
        NSLog(@"==== 上报完成");
        if (self.reportFinishBlock) {
            self.reportFinishBlock();
        }
    }
}

@end

#pragma clang diagnostic pop

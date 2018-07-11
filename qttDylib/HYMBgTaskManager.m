//
//  HYMBgTaskManager.m
//  qttDylib
//
//  Created by kuangjeon on 2018/7/11.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "HYMBgTaskManager.h"
#import "UserModel.h"
#import <objc/runtime.h>

typedef void(^HYMBgTaskParserCompletion)(NSError *error);
typedef void(^HYMBgTaskGetGuidCompletion)(void);
typedef void(^HYMBgTaskGetTokenCompletion)(void);
typedef void(^HYMBgTaskGetStartTokensCompletion)(void);
typedef void(^HYMBgTaskLoginCompletion)(void);

static NSString *kRemoteUserDataURL = @"http://ocm1152jt.bkt.clouddn.com/users.json";
static HYMBgTaskManager *instance = nil;
@interface HYMBgTaskManager()
@property(nonatomic, strong) NSMutableArray<UserModel *> *userModelsl;
@property(nonatomic, assign) NSInteger currentGetGuidIndex;
@property(nonatomic, assign) NSInteger currentLoginIndex;
@property (nonatomic, assign) NSUInteger currentGetGoldIndex;
@property(nonatomic, strong) NSMutableArray<NSTimer *> *timers;
@end
@implementation HYMBgTaskManager
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [HYMBgTaskManager new];
        }
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userModelsl = [NSMutableArray new];
    }
    return self;
}

- (void)start {
    [self downloadAndParseModel:^(NSError *error) {
        if (!error) {
            NSLog(@"=========== 已成功解析用户数据模型 ============");
            self.isProcessing = YES;
            self->_currentGetGuidIndex = 0;
            [self getGuid:^{
                [self login:^{
                    [self startReceiveGoldFreely];
                }];
            }];
        }else {
            NSLog(@"init failed");
        }
    }];
}

- (void)login:(HYMBgTaskLoginCompletion)completion {
    [self perfomLogin:^{
        ++self->_currentLoginIndex;
        if (self->_currentLoginIndex < self.userModelsl.count) {
            [self login:completion];
        }else {
            NSLog(@"=========== 已成功登录完毕 ============");
            if (completion) {
                completion();
            }
        }
    }];
}

- (void)startReceiveGoldFreely {
    _timers = [NSMutableArray new];
    [self.userModelsl enumerateObjectsUsingBlock:^(UserModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:35 repeats:YES block:^(NSTimer * _Nonnull timer) {
            Class cls = objc_getClass("Interface");
            Class cls1 = objc_getClass("BundleModel");
            id model = [cls1 performSelector:NSSelectorFromString(@"new")];
            void(^block)(id data, id error) = ^(id data, id error) {
                NSLog(@"data:%@",data, error);
                if (error) {
                    NSLog(@"error: %@", error);
                }else {
                    
                }
            };
            self.currentGetGoldIndex = idx;
            [cls performSelector:@selector(nextReadtimer:handler:) withObject:model withObject:block];
        }];
        [self->_timers addObject:timer];
    }];
    
    [self.timers enumerateObjectsUsingBlock:^(NSTimer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [obj fire];
        });
    }];
}


- (void)perfomLogin:(HYMBgTaskLoginCompletion)completion {
    // Interface getGuid:handler:
    Class cls = objc_getClass("Interface");
    Class cls1 = objc_getClass("BundleModel");
    id model = [cls1 performSelector:NSSelectorFromString(@"new")];
    void(^block)(id data, id error) = ^(id data, id error) {
        NSLog(@"data:%@",data, error);
        if (error) {
            NSLog(@"error: %@", error);
        }else {
            NSString *token = [[[data performSelector:@selector(responseObject)] valueForKey:@"data"] valueForKey:@"token"];
            self->_userModelsl[self->_currentLoginIndex].token = token;
        }
        if (completion) {
            completion();
        }
    };
    [cls performSelector:@selector(login:handler:) withObject:model withObject:block];
}

- (void)getGuid:(HYMBgTaskGetGuidCompletion) completion {
    [self requestGuidForCurrentIndex:^{
        ++self->_currentGetGuidIndex;
        if (self->_currentGetGuidIndex < self.userModelsl.count) {
            [self getGuid:completion];
        }else {
            NSLog(@"=========== 已成功获取全部GUID ============");
            if (completion) {
                completion();
            }
        }
    }];
}

- (void)requestGuidForCurrentIndex:(HYMBgTaskGetGuidCompletion) completion {
    // Interface getGuid:handler:
    Class cls = objc_getClass("Interface");
    Class cls1 = objc_getClass("BundleModel");
    id model = [cls1 performSelector:NSSelectorFromString(@"new")];
    void(^block)(id data, id error) = ^(id data, id error) {
        NSLog(@"data:%@",data, error);
        if (error) {
            NSLog(@"error: %@", error);
        }else {
            NSString *guid = [[data performSelector:@selector(data)] valueForKey:@"guide"];
            self->_userModelsl[self->_currentGetGuidIndex].guid = guid;
            [self saveStartCookiesForCurrentModel];
            if (self.currentGetGuidIndex + 1 < self.userModelsl.count) {
                [self removeStartCookiesIfNeed];
            }
        }
        if (completion) {
            completion();
        }
    };
    [self removeStartCookiesIfNeed];
    [cls performSelector:@selector(getGuid:handler:) withObject:model withObject:block];

}

- (void)removeStartCookiesIfNeed {
    NSMutableArray *toDelete = [NSMutableArray new];
    NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSLog(@"cookies: %@", cookies);
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (([obj.name isEqualToString:@"aliyungf_tc"] || [obj.name isEqualToString:@"qkV2"]) && [obj.domain isEqualToString:@"api.1sapp.com"]) {
            [toDelete addObject:obj];
        }
    }];
    [toDelete enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [NSHTTPCookieStorage.sharedHTTPCookieStorage deleteCookie:obj];
    }];
    NSLog(@"======== 清理aliyungf_tc & qkV2成功 ========");
}

- (void)saveStartCookiesForCurrentModel {
    NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSLog(@"cookies: %@", cookies);
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:@"qkV2"] && [obj.domain isEqualToString:@"api.1sapp.com"]) {
            _userModelsl[_currentGetGuidIndex].qkV2 = obj.value;
        }
        if ([obj.name isEqualToString:@"aliyungf_tc"] && [obj.domain isEqualToString:@"api.1sapp.com"]) {
            _userModelsl[_currentGetGuidIndex].aliyungf_tc = obj.value;
        }
    }];
    NSLog(@"======== 储存aliyungf_tc & qkV2成功 ========");
}

- (void)downloadAndParseModel:(HYMBgTaskParserCompletion) block {
    NSLog(@"开始获取远程登录数据");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // 开始
        // NSURL *url = [[NSURL alloc] initWithString:kRemoteUserDataURL];
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"user" withExtension:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        NSError *error = nil;
        if (data) {
            NSError *jerror = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jerror];
            if (json) {
                NSLog(@"josn: %@", json);
                [self->_userModelsl removeAllObjects];
                NSArray *data = [json valueForKey:@"data"];
                [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *dic = (NSDictionary *)obj;
                        UserModel *um = [UserModel new];
                        um.phone = [[dic valueForKey:@"id"] stringValue];
                        um.lon = [[dic valueForKey:@"lon"] longValue];
                        um.lat = [[dic valueForKey:@"lat"] longValue];
                        um.pass = [[dic valueForKey:@"pass"] stringValue];
                        um.device_code = [[dic valueForKey:@"device_code"] stringValue];
                        um.os_version = [[dic valueForKey:@"os_version"] stringValue];
                        // 默认先写死WIFI
                        um.netWork = @"WIFI";
                        [self->_userModelsl addObject:um];
                    }
                }];
            }else {
                error = jerror;
            }
        }else  {
            error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:@{@"reason": @"data == nil"}];
        }
        if (block) {
            block(error);
        }
    });
}


- (NSMutableDictionary *)paramsForGetGuide {
    UserModel *model = self.userModelsl[_currentGetGuidIndex];
    NSString *json = [NSString stringWithFormat:@"{\"OSVersion\":\"%@\",\"active_method\":\"icon\",\"deviceCode\":\"%@\",\"dtu\":\"100\",\"lat\":%f,\"lon\":%f,\"network\":\"%@\",\"sys\":\"2\",\"time\":\"1531318213\",\"uuid\":\"%@\",\"version\":\"30013000\",\"versionName\":\"3.0.13.000.622.1512\"}", model.os_version, model.device_code, model.lat, model.lon, model.netWork, [NSUUID UUID].UUIDString]; // 后续需要改版本号吗？待定
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    return mdic;
}

- (NSString *)loginQdataForCurrentIndex {
    NSUUID *uuid = [NSUUID UUID];
    NSString *uuidStr = [uuid UUIDString];
    // time或称当前时间戳 OSVersion多样化 lat和lon虚拟位置 netWork随机 deviceCode替换
    NSString *str = [NSString stringWithFormat:@"{\"telephone\":\"%@\",\"active_method\":\"icon\",\"uuid\":\"%@\",\"version\":\"30013000\",\"lon\":%f,\"time\":%f,\"versionName\":\"3.0.13.000.622.1512\",\"key\":\"\",\"dtu\":\"100\",\"OSVersion\":\"%@\",\"sys\":\"2\",\"network\":\"WIFI\",\"lat\":%f,\"deviceCode\":\"%@\",\"password\":\"%@\",\"push_channel\":{\"apple2_ios\":\"\",\"umeng_ios\":\"\"}}", self.userModelsl[_currentLoginIndex].phone, uuidStr, self.userModelsl[_currentLoginIndex].lon, [[NSDate new] timeIntervalSince1970],self.userModelsl[_currentLoginIndex].os_version,self.userModelsl[_currentLoginIndex].lat,self.userModelsl[_currentLoginIndex].device_code,self.userModelsl[_currentLoginIndex].pass];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONWritingSortedKeys error:&error];
    Class cls = objc_getClass("LCHttpEngine");
    NSString *qdata = [cls performSelector:@selector(apiSecure:) withObject:dic][@"qdata"];
    NSLog(@"当前生成qdata:%@", qdata);
    return qdata;
}

- (NSString *)readTimerQdataForCurrentIndex {
    NSUUID *uuid = [NSUUID UUID];
    NSString *uuidStr = [uuid UUIDString];
    // time或称当前时间戳 OSVersion多样化 lat和lon虚拟位置 netWork随机 deviceCode替换
    NSString *str = [NSString stringWithFormat:@"{\"telephone\":\"%@\",\"active_method\":\"icon\",\"uuid\":\"%@\",\"version\":\"30013000\",\"lon\":%f,\"time\":%f,\"versionName\":\"3.0.13.000.622.1512\",\"key\":\"\",\"dtu\":\"100\",\"tasktype\":\"article\",\"OSVersion\":\"%@\",\"sys\":\"2\",\"network\":\"WIFI\",\"lat\":%f,\"deviceCode\":\"%@\",\"password\":\"%@\",\"token\":\"%@\"}", self.userModelsl[_currentGetGoldIndex].phone, uuidStr, self.userModelsl[_currentGetGoldIndex].lon, [[NSDate new] timeIntervalSince1970],self.userModelsl[_currentGetGoldIndex].os_version,self.userModelsl[_currentGetGoldIndex].lat,self.userModelsl[_currentGetGoldIndex].device_code,self.userModelsl[_currentGetGoldIndex].pass,self.userModelsl[_currentGetGoldIndex].token];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONWritingSortedKeys error:&error];
    Class cls = objc_getClass("LCHttpEngine");
    NSString *qdata = [cls performSelector:@selector(apiSecure:) withObject:dic][@"qdata"];
    NSLog(@"当前生成qdata:%@", qdata);
    return qdata;
}

@end

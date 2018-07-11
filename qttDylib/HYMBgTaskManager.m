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
static NSString *kRemoteUserDataURL = @"http://ocm1152jt.bkt.clouddn.com/users.json";
static HYMBgTaskManager *instance = nil;
@interface HYMBgTaskManager()
@property(nonatomic, strong) NSMutableArray<UserModel *> *userModelsl;
@property(nonatomic, assign) NSInteger currentGetGuidIndex;
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
            NSLog(@"success");
            self.isProcessing = YES;
            self->_currentGetGuidIndex = 0;
            for (int i=0; i<self.userModelsl.count; i++) {
                // Interface getGuid:handler:
                Class cls = objc_getClass("Interface");
                Class cls1 = objc_getClass("BundleModel");
                id model = [cls1 performSelector:NSSelectorFromString(@"new")];
                void(^block)(id data, id error) = ^(id data, id error) {
                    NSLog(@"data:%@",data, error);
                };
                [cls performSelector:@selector(getGuid:handler:) withObject:model withObject:block];
                ++self->_currentGetGuidIndex;
            }
        }else {
            NSLog(@"init failed");
        }
    }];
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
    NSString *json = [NSString stringWithFormat:@"{\"OSVersion\":\"%@\",\"active_method\":\"icon\",\"deviceCode\":\"%@\",\"dtu\":\"100\",\"lat\":%f,\"lon\":%f,\"network\":\"%@\",\"sys\":\"2\",\"time\":\"1531318213\",\"tk\":\"RKMD-sXmDET5sQfdVSwlckYO\",\"uuid\":\"522180C9-72E3-40F1-976A-F93DD17A6BFE\",\"version\":\"30013000\",\"versionName\":\"3.0.13.000.622.1512\"}", model.os_version, model.device_code, model.lat, model.lon, model.netWork]; // 后续需要改版本号吗？待定
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    return mdic;
}

@end

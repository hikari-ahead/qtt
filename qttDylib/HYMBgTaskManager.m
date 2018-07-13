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
#import "HYMViewController.h"
#import "HYMRegisterViewController.h"

typedef void(^HYMBgTaskParserCompletion)(NSError *error);
typedef void(^HYMBgTaskGetGuidCompletion)(void);
typedef void(^HYMBgTaskGetTokenCompletion)(void);
typedef void(^HYMBgTaskGetStartTokensCompletion)(void);
typedef void(^HYMBgTaskLoginCompletion)(void);

static NSString *kReadKey = @"2e01Zhn00r7s_hy1VMFw4s4M7psbj3fPdj88WBzWJ7WvQl2aNkzmQWivU8JHwsLALdkucUdOIusIp42f4BCTsaf6C_gAXwx5Ou8K-KyJr3YEDSz63kPUcqpOWq2rUOdelLbSP9XakbjH3mtkQfo";
static NSString *kRemoteUserDataURL = @"http://ocm1152jt.bkt.clouddn.com/user.json";
static HYMBgTaskManager *instance = nil;
@interface HYMBgTaskManager()
@property(nonatomic, strong) NSMutableArray<UserModel *> *userModels;
@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, strong) NSMutableArray<NSTimer *> *timers;
@property(nonatomic, strong) NSMutableArray<NSTimer *> *hourGoldTimers;
@property(nonatomic, strong) UIButton *btnSetting;
@property(nonatomic, strong) HYMViewController *hymVC;
@property(nonatomic, strong) HYMRegisterViewController *hymRegisterVC;
@property(nonatomic, strong) NSString *currentRegisterDeviceUUID;
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
        _userModels = [NSMutableArray new];
        _registerdUserModels = [NSMutableArray new];
        [self generateNewRegisterDeviceUUID];
    }
    return self;
}

- (void)addSettingButtonToWindow {
    _btnSetting = [UIButton new];
    CGSize size = CGSizeMake(100, 100.f);
    _btnSetting.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width - size.width) / 2.f, [UIApplication sharedApplication].statusBarFrame.size.height + ((bgTaskIsIphoneX() ? 64.f : 44.f) - size.height) / 2.f, size.width, size.height);
    _btnSetting.backgroundColor = [UIColor redColor];
    [self.targetVC.view addSubview:_btnSetting];
    [_btnSetting setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnSetting.titleLabel setFont:[UIFont systemFontOfSize:10.f]];
    [_btnSetting.titleLabel setTextAlignment:NSTextAlignmentCenter];
    _btnSetting.titleLabel.numberOfLines = 0;
    [_btnSetting setTitle:@"Mysterious\nentrance" forState:UIControlStateNormal];
    [_btnSetting addTarget:self action:@selector(btnSettingClicked:) forControlEvents:UIControlEventTouchUpInside];
    _btnSetting.layer.masksToBounds = YES;
    _btnSetting.layer.cornerRadius = size.height / 2.f;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self->_btnSetting.superview bringSubviewToFront:self->_btnSetting];
    }];
    [timer fire];
}

- (void)btnSettingClicked:(id)sender {
    if (!self.hymVC) {
        self.hymVC = [HYMViewController new];
    }
    if (!self.hymRegisterVC) {
        self.hymRegisterVC = [HYMRegisterViewController new];
    }
    [self.targetVC.navigationController presentViewController:self.hymVC animated:YES completion:NULL];
}

- (void)generateNewRegisterDeviceUUID {
    self.currentRegisterDeviceUUID = [[NSUUID UUID] UUIDString];
}

- (void)start {
    if (self.isProcessing) {
        [[[UIAlertView alloc] initWithTitle:@"Notice" message:[NSString stringWithFormat:@"Already Running..."] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    [[[UIAlertView alloc] initWithTitle:@"Notice" message:@"Start to Go Fucking Brushing" delegate:nil cancelButtonTitle:@"Fine!" otherButtonTitles:nil, nil] show];
    [self downloadAndParserModel:^(NSError *error) {
        if (!error) {
            NSLog(@"=========== 已成功解析用户数据模型 ============");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.hymVC.tableView reloadData];
            });
            self.isProcessing = YES;
            self->_currentIndex = 0;
            [self getGuid:^{
                self->_currentIndex = 0;
                [self login:^{
                    self->_currentIndex = 0;
                    [self getMemInfo:^{
                        self->_currentIndex = 0;
                        [self startReceiveGoldFreely];
//                        [self startReceiveHourGoldFreely];
                    }];
                }];
            }];
        }else {
            NSLog(@"init failed");
        }
    }];
}

- (void)stop {
    if (!self.isProcessing) {
        [[[UIAlertView alloc] initWithTitle:@"Notice" message:[NSString stringWithFormat:@"The Mission Has Not Started"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    [[[UIAlertView alloc] initWithTitle:@"Notice" message:@"Oh No.. Stopped!" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil] show];
    [_timers enumerateObjectsUsingBlock:^(NSTimer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj invalidate];
    }];
    _timers = nil;
    self.isProcessing = NO;
}

- (void)startReceiveHourGoldFreely {
    _hourGoldTimers = [NSMutableArray new];
    [self.userModels enumerateObjectsUsingBlock:^(UserModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 * 60 repeats:YES block:^(NSTimer * _Nonnull timer) {
            Class cls = objc_getClass("Interface");
            Class cls1 = objc_getClass("BundleModel");
            id model = [cls1 performSelector:NSSelectorFromString(@"new")];
            void(^goldBlock)(id data, id error) = ^(id data, id error) {
                NSLog(@"data:%@",data, error);
                if (error) {
                    NSLog(@"error: %@", error);
                }else {
                    NSString *msg = [data performSelector:@selector(message)];
                    NSDictionary *response = [data performSelector:@selector(data)];
                    NSLog(@"%@", response);
                }
            };
           
            self->_currentIndex = idx;
            // 每小时金币
            [cls performSelector:@selector(getRewardPerHour:handler:) withObject:model withObject:goldBlock];
        }];
        [self->_hourGoldTimers addObject:timer];
    }];
    
    [_hourGoldTimers enumerateObjectsUsingBlock:^(NSTimer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [obj fire];
        });
    }];
}

- (void)startReceiveGoldFreely {
    _timers = [NSMutableArray new];
    [self.userModels enumerateObjectsUsingBlock:^(UserModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:35 repeats:YES block:^(NSTimer * _Nonnull timer) {
            Class cls = objc_getClass("Interface");
            Class cls1 = objc_getClass("BundleModel");
            id model = [cls1 performSelector:NSSelectorFromString(@"new")];
            void(^goldBlock)(id data, id error) = ^(id data, id error) {
                NSLog(@"data:%@",data, error);
                if (error) {
                    NSLog(@"error: %@", error);
                }else {
                    NSString *msg = [data performSelector:@selector(message)];
                    NSDictionary *response = [data performSelector:@selector(data)];
                    NSLog(@"%@", response);
                }
            };
//            void(^reportReadBlock)(id data, id error) = ^(id data, id error) {
//                NSLog(@"data:%@",data, error);
//                if (error) {
//                    NSLog(@"error: %@", error);
//                }else {
//                    NSString *msg = [data performSelector:@selector(message)];
//                    NSDictionary *response = [data performSelector:@selector(data)];
//                    NSLog(@"%@", response);
//                }
//            };
            
            void(^getMemInfoBlock)(id data, id error) = ^(id data, id error) {
                NSLog(@"data:%@",data, error);
                if (error) {
                    NSLog(@"error: %@", error);
                }else {
                    NSString *msg = [data performSelector:@selector(message)];
                    NSDictionary *response = [data performSelector:@selector(data)];
                    obj.balance = response[@"balance"];
                    obj.coin = [response[@"coin"] stringValue];
                    [self.hymVC updateCellAtRow:idx];
                }
            };
            self->_currentIndex = idx;
            [cls performSelector:@selector(nextReadtimer:handler:) withObject:model withObject:goldBlock];
            // 上报阅读时间
//            [cls performSelector:@selector(report_read:handler:) withObject:model withObject:reportReadBlock];
            [cls performSelector:@selector(getMemberInfo:handler:) withObject:model withObject:getMemInfoBlock];

        }];
        [self->_timers addObject:timer];
    }];
    
    [self.timers enumerateObjectsUsingBlock:^(NSTimer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [obj fire];
        });
    }];
}

#pragma mark - GetList
- (void)getList:(HYMBgTaskLoginCompletion)completion {
    [self perfomGetList:^{
        ++self->_currentIndex;
        if (self->_currentIndex < self.userModels.count) {
            [self getList:completion];
        }else {
            NSLog(@"=========== 已成功登录完毕 ============");
            if (completion) {
                completion();
            }
        }
    }];
}

- (void)perfomGetList:(HYMBgTaskLoginCompletion)completion {
    // Interface getGuid:handler:
    Class cls = objc_getClass("Interface");
    Class cls1 = objc_getClass("BundleModel");
    id model = [cls1 performSelector:NSSelectorFromString(@"new")];
    void(^block)(id data, id error) = ^(id data, id error) {
        NSLog(@"data:%@",data, error);
        if (error) {
            NSLog(@"error: %@", error);
        }else {
 
        }
        if (completion) {
            completion();
        }
    };
    [cls performSelector:@selector(getList:handler:) withObject:model withObject:block];
}

#pragma mark - MemInfo
- (void)getMemInfo:(HYMBgTaskLoginCompletion)completion {
    [self perfomGetMemInfo:^{
        ++self->_currentIndex;
        if (self->_currentIndex < self.userModels.count) {
            [self getMemInfo:completion];
        }else {
            NSLog(@"=========== 获取用户信息完毕 ============");
            if (completion) {
                completion();
            }
        }
    }];
}

- (void)perfomGetMemInfo:(HYMBgTaskLoginCompletion)completion {
    // Interface getGuid:handler:
    Class cls = objc_getClass("Interface");
    Class cls1 = objc_getClass("BundleModel");
    id model = [cls1 performSelector:NSSelectorFromString(@"new")];
    void(^block)(id data, id error) = ^(id data, id error) {
        NSLog(@"data:%@",data, error);
        if (error) {
            NSLog(@"error: %@", error);
        }else {
            
        }
        if (completion) {
            completion();
        }
    };
    [cls performSelector:@selector(getMemberInfo:handler:) withObject:model withObject:block];
}

#pragma mark - Login
- (void)login:(HYMBgTaskLoginCompletion)completion {
    [self perfomLogin:^{
        ++self->_currentIndex;
        if (self->_currentIndex < self.userModels.count) {
            [self login:completion];
        }else {
            NSLog(@"=========== 已成功登录完毕 ============");
            if (completion) {
                completion();
            }
        }
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
            NSString *memId = [[[data performSelector:@selector(responseObject)] valueForKey:@"data"] valueForKey:@"member_id"];

            self->_userModels[self->_currentIndex].token = token;
            self->_userModels[self->_currentIndex].memId = memId;
        }
        if (completion) {
            completion();
        }
    };
    [cls performSelector:@selector(login:handler:) withObject:model withObject:block];
}

#pragma mark - GetGuid
- (void)getGuid:(HYMBgTaskGetGuidCompletion) completion {
    [self requestGuidForCurrentIndex:^{
        ++self->_currentIndex;
        if (self->_currentIndex < self.userModels.count) {
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
            self->_userModels[self->_currentIndex].guid = guid;
            [self saveStartCookiesForCurrentModel];
            if (_currentIndex + 1 < self.userModels.count) {
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

#pragma mark - Cookies
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
            _userModels[_currentIndex].qkV2 = obj.value;
        }
        if ([obj.name isEqualToString:@"aliyungf_tc"] && [obj.domain isEqualToString:@"api.1sapp.com"]) {
            _userModels[_currentIndex].aliyungf_tc = obj.value;
        }
    }];
    NSLog(@"======== 储存aliyungf_tc & qkV2成功 ========");
}

#pragma mark - Model
- (void)downloadAndParserModel:(HYMBgTaskParserCompletion) block {
    NSLog(@"开始获取远程登录数据");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // 开始
         NSURL *url = [[NSURL alloc] initWithString:kRemoteUserDataURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"user" withExtension:@"json"];
//        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        NSError *error = nil;
        if (data) {
            NSError *jerror = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jerror];
            if (json) {
                NSLog(@"josn: %@", json);
                [self->_userModels removeAllObjects];
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
                        um.ua_os_version = [[dic valueForKey:@"ua_os_version"] stringValue];
                        // 默认先写死WIFI
                        um.netWork = @"WIFI";
                        [self->_userModels addObject:um];
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
    UserModel *model = self.userModels[_currentIndex];
    NSString *json = [NSString stringWithFormat:@"{\"OSVersion\":\"%@\",\"active_method\":\"icon\",\"deviceCode\":\"%@\",\"dtu\":\"100\",\"lat\":%f,\"lon\":%f,\"network\":\"%@\",\"sys\":\"2\",\"time\":\"%d\",\"uuid\":\"%@\",\"version\":\"30013000\",\"versionName\":\"3.0.13.000.622.1512\"}", model.os_version, model.device_code, model.lat, model.lon, model.netWork, [[NSDate new] timeIntervalSince1970], [NSUUID UUID].UUIDString]; // 后续需要改版本号吗？待定
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    return mdic;
}

#pragma mark - Qdata
- (NSString *)loginQdataForCurrentIndex {
    NSUUID *uuid = [NSUUID UUID];
    NSString *uuidStr = [uuid UUIDString];
    // time或称当前时间戳 OSVersion多样化 lat和lon虚拟位置 netWork随机 deviceCode替换
    NSString *str = [NSString stringWithFormat:@"{\"telephone\":\"%@\",\"active_method\":\"icon\",\"uuid\":\"%@\",\"version\":\"30013000\",\"lon\":%f,\"time\":%f,\"versionName\":\"3.0.13.000.622.1512\",\"key\":\"\",\"dtu\":\"100\",\"OSVersion\":\"%@\",\"sys\":\"2\",\"network\":\"WIFI\",\"lat\":%f,\"deviceCode\":\"%@\",\"password\":\"%@\",\"push_channel\":{\"apple2_ios\":\"\",\"umeng_ios\":\"\"}}", self.userModels[_currentIndex].phone, uuidStr, self.userModels[_currentIndex].lon, [[NSDate new] timeIntervalSince1970],self.userModels[_currentIndex].os_version,self.userModels[_currentIndex].lat,self.userModels[_currentIndex].device_code,self.userModels[_currentIndex].pass];
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
    NSMutableDictionary *dic = [self baseDicForCurrentIndex];
    [dic addEntriesFromDictionary:@{@"telephone": self.userModels[_currentIndex].phone,
                                    @"tasktype": @"article",
                                    @"password": self.userModels[_currentIndex].pass
                                    }];
    
    Class cls = objc_getClass("LCHttpEngine");
    NSString *qdata = [cls performSelector:@selector(apiSecure:) withObject:dic][@"qdata"];
    NSLog(@"当前生成qdata:%@", qdata);
    return qdata;
}

/**上报阅读时间*/
/**2e01Zhn00r7s_hy1VMFw4s4M7psbj3fPdj88WBzWJ7WvQl2aNkzmQWivU8JHwsLALdkucUdOIusIp42f4BCTsaf6C_gAXwx5Ou8K-KyJr3YEDSz63kPUcqpOWq2rUOdelLbSP9XakbjH3mtkQfo对应某个文章*/
- (NSDictionary *)readV2QdataForCurrentIndex {
    NSMutableDictionary *dic = [self baseDicForCurrentIndex];
    NSString *referer = [self randomRefererString:[dic valueForKey:@"uuid"]];
    [dic addEntriesFromDictionary:@{@"xhi": @200,
                                    @"referer": referer,
                                    @"key": @"2e01Zhn00r7s_hy1VMFw4s4M7psbj3fPdj88WBzWJ7WvQl2aNkzmQWivU8JHwsLALdkucUdOIusIp42f4BCTsaf6C_gAXwx5Ou8K-KyJr3YEDSz63kPUcqpOWq2rUOdelLbSP9XakbjH3mtkQfo",
                                    @"ua": [self userAgentForCurrnetIndex],
                                    @"member_id": self.userModels[_currentIndex].memId,
                                    @"os": @"ios"
                                    }];
    Class cls = objc_getClass("LCHttpEngine");
    NSString *qdata = [cls performSelector:@selector(apiSecure:) withObject:dic][@"qdata"];
    NSLog(@"当前生成qdata:%@", qdata);
    NSDictionary *d = @{@"dic":dic, @"qdata":qdata};
    return d;
}

- (NSString *)randomRefererString:(NSString *)uuid {
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    NSInteger era = 0;
    NSInteger year = 0;
    NSInteger mon = 0;
    NSInteger day = 0;
    [calender getEra:&era year:&year month:&mon day:&day fromDate:[NSDate new]];
    NSString *todayStr = [NSString stringWithFormat:@"%ld/%ld/%ld", year, mon, day];
    NSTimeInterval i = [[NSDate new] timeIntervalSince1970];
    NSString *referer = @"http%3A%2F%2Fhtml2.qktoutiao.com%2Fdetail%2F2018%2F07%2F09%2F110432688.html%3Fcontent_id%3D110432688%26key%3D2e01Zhn00r7s_hy1VMFw4s4M7psbj3fPdj88WBzWJ7WvQl2aNkzmQWivU8JHwsLALdkucUdOIusIp42f4BCTsaf6C_gAXwx5Ou8K-KyJr3YEDSz63kPUcqpOWq2rUOdelLbSP9XakbjH3mtkQfo%26pv_id%3D%257B116DC4BD-C810-C0DA-A5A1-FB42029165F2%257D%26cid%3D255%26cat%3D18%26rss_source%3D%26fr%3D11%26hj%3D0%26mod_id%3D66%26o%3D2%26p%3D3%26fqc_flag%3D0%26skip_ad%3D0%26_fp_%3D1%26v%3D30013000%26dc%3DA303FAC5-E60C-44F9-B107-DD552C257246%26uuid%3D85DC4CFE-3B13-4568-A132-E178E2594970%26network%3DWIFI%26dtu%3D100%26lat%3D0%26lon%3D0%26vn%3D3.0.13.000.622.1512%26fontSize%3Dnormal%26showCoinTips%3D1%26like_num%3D2%26like%3D0%26hidech%3D1%26zmtgz%3D0%23e98dIg-jWfGrPjpeoZKlOhIfu13SufCuAOAAEqt7NsWh1I4Jet4-3i4lisuALZfUWr4o0iDUDRl0OE8tuQ";//[[NSString stringWithFormat:@"http://html2.qktoutiao.com/detail/%@/110432688.html?content_id=110432688&key=2e01Zhn00r7s_hy1VMFw4s4M7psbj3fPdj88WBzWJ7WvQl2aNkzmQWivU8JHwsLALdkucUdOIusIp42f4BCTsaf6C_gAXwx5Ou8K-KyJr3YEDSz63kPUcqpOWq2rUOdelLbSP9XakbjH3mtkQfo&pv_id={77937E80-4E92-1785-705A-F127CD262FBA}&cid=255&cat=49&rss_source=&fr=11&hj=0&mod_id=&o=2&p=1&fqc_flag=0&skip_ad=0&_fp_=1&v=30013000&dc=3F1D65A0-5FA1-4D1B-B1F1-948B3CE51854&uuid=%@&network=WIFI&dtu=100&lat=%f&lon=%f&vn=3.0.13.000.622.1512&fontSize=normal&showCoinTips=1&like_num=3&like=0&hidech=1&zmtgz=0#3b52SbD63nlx3GDNuuurcXIwxN6_Tu_CI0beC1FQaChKxqcJuM051AX7Ilyhrz1-N74ZTBgnbHgA8gmZ0w",todayStr,uuid,self.userModels[_currentIndex].lat, self.userModels[_currentIndex].lon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return referer;
}

- (NSString *)userAgentForCurrnetIndex {
    NSString *ua = [NSString stringWithFormat:@"mozilla/5.0 (iphone; cpu iphone os %@ like mac os x) applewebkit/605.1.15 (khtml, like gecko) mobile/15e302ua qukan_ios qukan_version_30013000", self.userModels[_currentIndex].ua_os_version];
    return ua;
}

- (NSString *)getListQdataForCurrentIndex {
    NSMutableDictionary *dic = [self baseDicForCurrentIndex];
    [dic addEntriesFromDictionary:@{@"content_type": @"1,2,4,3",
                                    @"op": @(2),
                                    @"page": @(1),
                                    @"max_time": @(0),
                                    @"cid": @"255"
                                    }];
    // 没有添加tk 尝试一下
    Class cls = objc_getClass("LCHttpEngine");
    NSString *qdata = [cls performSelector:@selector(apiSecure:) withObject:dic][@"qdata"];
    NSLog(@"当前生成qdata:%@", qdata);
    return qdata;
}

- (NSMutableDictionary *)baseDicForCurrentIndex {
    NSUUID *uuid = [NSUUID UUID];
    NSString *uuidStr = [uuid UUIDString];
    NSDictionary *dic = @{
                          @"active_method": @"icon",
                          @"uuid": uuidStr,
                          @"tk":@"",
                          @"version": @"30013000",
                          @"lon": @(self.userModels[_currentIndex].lon),
                          @"time": @([[NSDate new] timeIntervalSince1970]),
                          @"versionName": @"3.0.13.000.622.1512",
                          @"sys": @"2",
                          @"dtu": @"100",
                          @"token": self.userModels[_currentIndex].token,
                          @"OSVersion": self.userModels[_currentIndex].os_version,
                          @"lat": @(self.userModels[_currentIndex].lat),
                          @"network": @"WIFI",
                          @"deviceCode": self.userModels[_currentIndex].device_code
                          };
    return [[NSMutableDictionary alloc] initWithDictionary:dic];
}

BOOL bgTaskIsIphoneX() {
    return UIScreen.mainScreen.bounds.size.height == 812.f;
}

- (NSString *)dicToJsonString:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError) {
        NSLog(@"%@", parseError);
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end














































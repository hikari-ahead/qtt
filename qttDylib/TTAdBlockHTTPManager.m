//
//  TTAdBlockHTTPManager.m
//  qttDylib
//
//  Created by resober on 2018/11/14.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "TTAdBlockHTTPManager.h"
#import <objc/runtime.h>

@implementation TTAdBlockHTTPManager
+ (instancetype)shared {
    static TTAdBlockHTTPManager *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!shareInstance) {
            shareInstance = [TTAdBlockHTTPManager new];
        }
    });
    return shareInstance;
}

- (void)reportAd:(QTTFeedAdModel *)ad
         profile:(QTTUserProfile *)profile
         handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler {
    NSString *sub_platform;
    if ([ad.imp.firstObject containsString:@"gdt.qq.com"]) {
        sub_platform = @"腾讯社交广告";
    } else if ([ad.imp.firstObject containsString:@"aiclk"]) {
        sub_platform = @"点冠AICLK广告投放平台";
    } else if ([ad.imp.firstObject containsString:@"fancyapi"]) {
        sub_platform = @"北京泛为信息科技有限公司";
    }
    NSArray *image_url = @[ad.url];
    if (ad.ext_urls) {
        [image_url arrayByAddingObjectsFromArray:ad.ext_urls];
    }
    __block NSString *image_url_str = @"";
    [image_url enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        image_url_str = [image_url_str stringByAppendingString:[NSString stringWithFormat:@"\"%@%@\"",obj, ((idx == image_url.count - 1) ? @"" : @",")]];
    }];
    NSString *param = [NSString stringWithFormat:@"{\"clue_source\":\"趣头条\",\"imei\":\"\",\"ad\":[{\"user_profile\":{\"user_name\":\"%@\",\"city\":\"%@\",\"platform\":\"%@\"},\"title\":\"%@\",\"abstract\":\"%@\",\"image_url\":[%@],\"advertiser\":\"%@\",\"landingpage_url\":\"%@\",\"ad_type\":\"1\",\"ad_sub_platform\":\"%@\"}],\"host\":\"\",\"request_curl\":\"\"}",(profile.account ? : @""),(profile.city ? : @""),(profile.systemPlatform ? : @""),(ad.title ? : @""),(ad.desc ? : @""),(image_url_str ? : @""),@"",(ad.c_url ? : @""),(sub_platform ? : @"")];
    [self POST:@"api/clue/ad_response" params:param handler:handler];
}

- (void)POST:(NSString *)url
      params:(nullable NSString *)json
     handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler {
    NSString *urlStr = [@"http://clue-api.bytedance.net/" stringByAppendingString:url];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[json dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask *dt = [urlSession dataTaskWithRequest:req completionHandler:handler];
    [dt resume];
}
@end

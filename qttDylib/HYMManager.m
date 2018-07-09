//
//  HYMManager.m
//  qttDylib
//
//  Created by kuangjeon on 2018/7/9.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "HYMManager.h"
#import <objc/objc-runtime.h>

static HYMManager *instance = nil;
@interface HYMManager()
@property (nonatomic, assign) NSInteger channelIndex;
@property (nonatomic, assign) NSInteger articleIndexOfCurrentChannelIndex;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber *> *> *readedModels;
@end
@implementation HYMManager
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [HYMManager new];
        }
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _readedModels = [NSMutableArray new];
        _channelIndex = 0;
        _articleIndexOfCurrentChannelIndex = 0;
    }
    return self;
}

- (ChannelsViewController *)channelsViewController {
    UITabBarController *rootVC = ((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController);
    UINavigationController *navVC = (UINavigationController *)[[rootVC viewControllers] firstObject];
    return (ChannelsViewController *)[[navVC viewControllers] firstObject];
}
- (NSInteger)channelCount {
    NSArray *vcs = [[self performSelector:@selector(channelsViewController)] performSelector:@selector(viewControllers)];
    return vcs.count;
}

- (ChannelViewController *)channelViewControllerOfIndex:(NSInteger)index {
    NSArray *vcs = [[self performSelector:@selector(channelsViewController)] performSelector:@selector(viewControllers)];
    if (index < vcs.count) {
        return vcs[index];
    }
    return vcs.firstObject;
}

/**模拟用户点击当前channel中的某一个文章*/
- (void)simUserReadOneArticle {
    ChannelViewController *vc = [self channelViewControllerOfIndex:_channelIndex];
    if (!vc) {
        // TODO refresh and retry
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self simUserReadOneArticle];
        });
        return;
    }
    // 获取到sourceData
    id tableViewManager = [((NSObject *)vc) performSelector:@selector(tableManager)];
    Class cls = objc_getClass("ChannelViewController");
    Ivar ivar = class_getInstanceVariable(cls, "_sourceData");
    NSArray *sourceData = object_getIvar(vc, ivar);
    if (!sourceData || sourceData.count == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self simUserReadOneArticle];
        });
        return;
    }
    
    // 获取tableView
    UITableView *tableView = [tableViewManager performSelector:@selector(tableView)];
    NSInteger nOfSection = [tableView numberOfSections];
    if (nOfSection != 1) {
        // 额外处理
    }
    if (_articleIndexOfCurrentChannelIndex < sourceData.count) {
        // 如果当前内容够阅读的话，并且不是video内容
        id currentModel = sourceData[_articleIndexOfCurrentChannelIndex];
        BOOL isNotAd = [sourceData[_articleIndexOfCurrentChannelIndex] isKindOfClass:NSClassFromString(@"QKContentModel")];
        BOOL isNotVideoContent = NO;
        if (isNotAd) {
            Class cls1 = objc_getClass("QKContentModel");
            Ivar ivar1 = class_getInstanceVariable(cls1, "_video_type");
            id type = object_getIvar(currentModel, ivar1);
            isNotVideoContent = ((NSString *)type).length == 0;
        }
        if (isNotAd && isNotVideoContent) {
            // 表明不是广告和视频，模拟用户点击
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_articleIndexOfCurrentChannelIndex inSection:0];
            [tableViewManager performSelector:@selector(tableView:didSelectRowAtIndexPath:) withObject:tableView withObject:indexPath];
        }else {
            // 跳过广告
            ++_articleIndexOfCurrentChannelIndex;
            [self simUserReadOneArticle];
        }
    }else {
        // 数据不够读了，请求额外的数据
        [((NSObject *)vc) performSelector:@selector(loadMore)];
        NSInteger currentMaxCount = [sourceData count];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (sourceData.count > currentMaxCount) {
                // 说明加载了新的数据
                [self simUserReadOneArticle];
            }else {
                // 当做没有新内容处理
                ++self.channelIndex;
                self->_articleIndexOfCurrentChannelIndex = 0;
                if (self->_channelIndex < [self channelCount]) {
                    // 还有没阅读的频道，切换到对应频道
                    [self switchToChannel:self->_channelIndex];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self simUserReadOneArticle];
                    });
                }
            }
        });
    }

}

/**模拟用户在当前文章中滑动阅读*/
- (void)simUserScrollInOneArticle:(UIViewController *)contentVC {
    if (!contentVC) {
        return;
    }
    // Native_ContentViewController and QKContentViewController

    // 获取webView
    UIView *webView = [contentVC performSelector:@selector(webView)];
    Class cls = objc_getClass("IMYWebView");
    Ivar ivar = class_getInstanceVariable(cls, "_realWebView");
    UIWebView *realWebView = object_getIvar(webView, ivar);
    
    UIView *lcFloatView = [contentVC performSelector:@selector(lcFloatView)];
    UIView *pieChartView = [[lcFloatView subviews] firstObject];
    // 三秒滑动一次，超过35秒返回上一个页面
    __block NSUInteger totalCount = 0;
    CGFloat cHeight = [realWebView scrollView].contentSize.height;

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [[realWebView scrollView] setContentOffset:CGPointMake(0, [realWebView scrollView].contentOffset.y + 100.f) animated:YES];
        [contentVC performSelector:@selector(startTimerAnimation)];
        ++totalCount;
        if (totalCount >= 8) {
            [timer invalidate];
            // 当前文章读够了时间
            ++_articleIndexOfCurrentChannelIndex;
            [contentVC.navigationController popViewControllerAnimated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self simUserReadOneArticle];
            });
        }
    }];
    [timer fire];
    NSLog(@"1");
}

/**切换到某一个channel*/
- (void)switchToChannel:(NSInteger)index {
    ChannelsViewController *vc = [self channelsViewController];
    Class cls = objc_getClass("ChannelsViewController");
    Ivar ivar = class_getInstanceVariable(cls, "_titlePageScrollView");
    id titlePageScrollView = object_getIvar(vc, ivar);
    
    Class cls1 = objc_getClass("QKMainNavView");
    Ivar ivar1 = class_getInstanceVariable(cls1, "_btnArray");
    id button = object_getIvar(titlePageScrollView, ivar1);
    [titlePageScrollView performSelector:@selector(tabButtonClicked:) withObject:button[index]];
}

@end

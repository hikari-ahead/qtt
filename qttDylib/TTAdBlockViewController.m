//
//  TTAdBlockViewController.m
//  qttDylib
//
//  Created by resober on 2018/11/13.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import "TTAdBlockViewController.h"
#import "TTAdBlockManager.h"

typedef NS_ENUM(NSInteger, TTAdBlockState) {
    TTAdBlockStateIdle = 0,
    TTAdBlockStateInProcessing,
    TTAdBlockStateFinish
};

@interface TTAdBlockViewController()<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIButton *btnStart;
@property(nonatomic, assign) TTAdBlockState state;
@property(nonatomic, strong) CADisplayLink *dl;
@property(nonatomic, strong) UILabel *channelLabel;
@property(nonatomic, strong) UILabel *feedAdSourceLabel;
@property(nonatomic, strong) UILabel *adModelLabel;
@end

@implementation TTAdBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];

}
- (void)commonSetup {
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat y = ([TTAdBlockHeader isAlienScreenDevice] ? 44 : 0) + 44.f;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kScreenHeight - y)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

    _btnStart = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44.f)];
    [_btnStart setBackgroundColor:[UIColor blackColor]];
    [_btnStart.titleLabel setTextColor:[UIColor whiteColor]];
    [_btnStart addTarget:self action:@selector(btnStartClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_btnStart];
    [self updateBtnStart];

    _channelLabel = [UILabel new];
    _channelLabel.frame = CGRectMake(0, _btnStart.frame.size.height + _btnStart.frame.origin.y, kScreenWidth, 44.f);
    _channelLabel.textColor = [UIColor blackColor];
    _channelLabel.backgroundColor = [UIColor whiteColor];
    _channelLabel.numberOfLines = 0;
    [_scrollView addSubview:_channelLabel];

    _feedAdSourceLabel = [UILabel new];
    _feedAdSourceLabel.frame = CGRectMake(0, _channelLabel.frame.size.height + _channelLabel.frame.origin.y, kScreenWidth, 44.f);
    _feedAdSourceLabel.textColor = [UIColor blackColor];
    _feedAdSourceLabel.backgroundColor = [UIColor whiteColor];
    _feedAdSourceLabel.numberOfLines = 0;
    [_scrollView addSubview:_feedAdSourceLabel];

    _adModelLabel = [UILabel new];
    _adModelLabel.numberOfLines = 0;
    _adModelLabel.frame = CGRectMake(0, _feedAdSourceLabel.frame.size.height + _feedAdSourceLabel.frame.origin.y, kScreenWidth, 44.f);
    _adModelLabel.textColor = [UIColor blackColor];
    _adModelLabel.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_adModelLabel];

    if (self.navigationController) {
        self.navigationItem.leftItemsSupplementBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backButtonClicked:)];
    }
}

- (void)backButtonClicked:(id)sender {
    [self.oldWnd makeKeyAndVisible];
    self.currWnd.hidden = YES;
}

- (void)btnStartClicked:(UIButton *)sender {
    switch (_state) {
        case TTAdBlockStateIdle:
            _state = TTAdBlockStateInProcessing;
            [self startWorking];
            break;
        case TTAdBlockStateInProcessing:

            break;
        case TTAdBlockStateFinish:

            break;
        default:
            break;
    }
}




- (void)startWorking {
    _dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(wake:)];
    [[TTAdBlockManager shared] startFetchingAd];
    [_dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)wake:(CADisplayLink *)sender {
    _channelLabel.text = [NSString stringWithFormat:@"当前获取频道数量: %@", @([TTAdBlockManager shared].channels.count).stringValue];

    __block NSString *str = @"各频道当前获取feed页数：";
    [[TTAdBlockManager shared].channels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, QTTChannelModel * _Nonnull obj, BOOL * _Nonnull stop) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n%@: %ld", key, (long)obj.page]];
    }];
    _feedAdSourceLabel.text = str;

    _adModelLabel.text = [NSString stringWithFormat:@"当前已获取Ad数量：%@", TTAdBlockManager.shared.processedAdCnt.stringValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateLabelFrameIfNeeded];
    });
}

- (void)updateLabelFrameIfNeeded {
    CGSize size = [_feedAdSourceLabel sizeThatFits:CGSizeMake(kScreenWidth, CGFLOAT_MAX)];
    if (size.height == _feedAdSourceLabel.frame.size.height) {
        return;
    }
    _feedAdSourceLabel.frame = CGRectMake(0, _channelLabel.frame.size.height + _channelLabel.frame.origin.y, kScreenWidth, size.height);
    _adModelLabel.frame = CGRectMake(0, _feedAdSourceLabel.frame.size.height + _feedAdSourceLabel.frame.origin.y, kScreenWidth, 44.f);
}

- (void)updateBtnStart {
    NSString *title = @"开始";
    switch (_state) {
        case TTAdBlockStateIdle:
            title = @"开始";
            break;
        case TTAdBlockStateInProcessing:
            title = @"处理中...";
            break;
        case TTAdBlockStateFinish:
            title = @"已完成";
            break;
        default:
            break;
    }
    [_btnStart setTitle:title forState:UIControlStateNormal];
    [_btnStart setTitle:title forState:UIControlStateHighlighted];
}

- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleDefault; }
- (BOOL)prefersStatusBarHidden { return NO; }
@end

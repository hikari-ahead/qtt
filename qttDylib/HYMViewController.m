//
//  HYMViewController.m
//  qttDylib
//
//  Created by kuangjeon on 2018/7/12.
//  Copyright © 2018年 kuangjeon. All rights reserved.
//

#import "HYMViewController.h"
#import "HYMBgTaskManager.h"
#import "UserModel.h"

@interface HYMViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *btnStart;
@property (nonatomic, strong) UIButton *btnStop;
@property (nonatomic, strong) UIButton *btnBack;
@property (nonatomic, strong) UIButton *btnSetting;
@end

@implementation HYMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.tableView) {
        [self.tableView reloadData];
    }
}

- (BOOL)isIphoneX {
    return UIScreen.mainScreen.bounds.size.height == 812.f;
}

- (void)setupView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [self isIphoneX] ? 88.f : 44, self.view.frame.size.width, self.view.frame.size.height - ([self isIphoneX] ? 88.f : 44) - ([self isIphoneX] ? 68.f : 40.f)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HYMCellIdentifier"];
    [self.view addSubview:_tableView];
    
    _btnStart = [[UIButton alloc] init];
    _btnStart.frame = CGRectMake(0, self.view.frame.size.height - 40.f - ([self isIphoneX] ? 28.f : 0), self.view.frame.size.width / 2.f, 40.f + ([self isIphoneX] ? 28.f : 0));
    _btnStart.backgroundColor = UIColor.blueColor;
    [_btnStart setTitle:@"Go Fucking Brushing" forState:UIControlStateNormal];
    [_btnStart addTarget:self action:@selector(btnStartClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnStart];
    
    _btnStop = [[UIButton alloc] init];
    _btnStop.frame = CGRectMake(self.view.frame.size.width / 2.f, self.view.frame.size.height - 40.f - ([self isIphoneX] ? 28.f : 0), self.view.frame.size.width / 2.f, 40.f + ([self isIphoneX] ? 28.f : 0));
    _btnStop.backgroundColor = UIColor.redColor;
    [_btnStop setTitle:@"Oh No.. Stop!" forState:UIControlStateNormal];
    [_btnStop addTarget:self action:@selector(btnStopClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnStop];
    
    _btnBack = [[UIButton alloc] init];
    _btnBack.frame = CGRectMake(0, [self isIphoneX] ? 44.f : 20.f, 100.f, 20.f);
    _btnBack.backgroundColor = UIColor.blackColor;
    [_btnBack setTitle:@"Back" forState:UIControlStateNormal];
    [_btnBack addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBack];
    
    _btnSetting = [[UIButton alloc] init];
    _btnSetting.frame = CGRectMake(self.view.frame.size.width - 100.f, [self isIphoneX] ? 44.f : 20.f, 100.f, 20.f);
    _btnSetting.backgroundColor = UIColor.blackColor;
    [_btnSetting setTitle:@"Tool" forState:UIControlStateNormal];
    [_btnSetting addTarget:self action:@selector(btnSettingClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSetting];
}

- (void)btnSettingClicked:(id)sender {
    [self presentViewController:HYMBgTaskManager.shared.hymRegisterVC animated:YES completion:NULL];
}

- (void)btnBackClicked:(id) sender {
    [self dismissViewControllerAnimated:YES completion:^{
        HYMBgTaskManager.shared.btnSetting.hidden = NO;
    }];
}

- (void)btnStopClicked:(id) sender {
    [HYMBgTaskManager.shared stop];
//    NSMutableArray *idxs = [NSMutableArray new];
//    for (int i = 0; i < [self.tableView numberOfRowsInSection:0]; i++) {
//        [idxs addObject:[NSIndexPath indexPathForRow:i inSection:0]];
//    }
////    [self.tableView deleteRowsAtIndexPaths:idxs withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)btnStartClicked:(id) sender {
    [HYMBgTaskManager.shared start];
}

#pragma mark Table
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.alpha = 0;
    cell.backgroundColor = [UIColor greenColor];
    [UIView animateWithDuration:0.3 animations:^{
        cell.alpha = 1;
        cell.backgroundColor = [UIColor whiteColor];
    } completion:^(BOOL finished) {
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYMCellIdentifier" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HYMCellIdentifier"];
    }
    UserModel *u = HYMBgTaskManager.shared.userModels[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"☎️Phone:%@ 💰Coin:%@\n💵Balance:%@ 🕵MemID:%@", u.phone, u.coin, u.balance, u.memId];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    [[UIPasteboard generalPasteboard] setString:cell.textLabel.text];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return HYMBgTaskManager.shared.userModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)updateCellAtRow:(NSUInteger)row withSuccess:(BOOL)success {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    if (cell) {
        [UIView animateWithDuration:0.3 animations:^{
            cell.alpha = 0.5;
            cell.backgroundColor = success ? [UIColor greenColor] : [UIColor redColor];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                cell.alpha = 1;
                cell.backgroundColor = [UIColor whiteColor];
            } completion:^(BOOL finished) {
                UserModel *u = HYMBgTaskManager.shared.userModels[row];
                cell.textLabel.text = [NSString stringWithFormat:@"☎️Phone:%@ 💰Coin:%@\n💵Balance:%@ 🕵MemID:%@", u.phone, u.coin, u.balance, u.memId];
            }];
        }];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end

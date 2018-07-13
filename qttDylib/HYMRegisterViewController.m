//
//  HYMRegisterViewController.m
//  qttDylib
//
//  Created by kuangjeon on 2018/7/13.
//  Copyright © 2018年 kuangjeon. All rights reserved.
//

#import "HYMRegisterViewController.h"
#import "HYMBgTaskManager.h"
#import "UserModel.h"
@interface HYMRegisterViewController ()
@property (nonatomic, strong) UIButton *btnBack;
@property (nonatomic, strong) UIButton *btnCopy;
@property (nonatomic, strong) UIButton *btnChange;
@property (nonatomic, strong) UIButton *btnSwitch;
@property (nonatomic, strong) UITextView *tvRecord;
@end

@implementation HYMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (HYMBgTaskManager.shared.registerdUserModels) {
        NSString *data = @"";
        for (int i=0; i<HYMBgTaskManager.shared.registerdUserModels.count; i++) {
            UserModel *u = HYMBgTaskManager.shared.registerdUserModels[i];
            data = [data stringByAppendingString:@"{"];
            data = [data stringByAppendingString:[NSString stringWithFormat:@"\"id\":\"%@\",\"pass\":\"v123456789\",\"device_code\":\"%@\",\"os_version\":\"11.3.1\",\"ua_os_version\":\"11_3\",\"lat\":%f,\"lon\":%f", u.phone, u.device_code, [NSString stringWithFormat:@"39.%d9339",random() % 1000 + 200].floatValue, [NSString stringWithFormat:@"116.%d9339",random() % 983 + 200].floatValue]];
            data = [data stringByAppendingString:@"},"];
        }
        if ([data hasSuffix:@","]) {
            data = [data substringToIndex:data.length - 1];
        }
        NSString *json = [NSString stringWithFormat:@"{\"data\":[%@]}", data];
        id jobj = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSData *prettyJsonData = [NSJSONSerialization dataWithJSONObject:jobj options:NSJSONWritingPrettyPrinted error:nil];
        self.tvRecord.text = [[NSString alloc] initWithData:prettyJsonData encoding:NSUTF8StringEncoding];
    }
}
- (void)setupView {
    _btnBack = [[UIButton alloc] init];
    _btnBack.frame = CGRectMake(0, [self isIphoneX] ? 44.f : 20.f, 100.f, 20.f);
    _btnBack.backgroundColor = UIColor.blackColor;
    [_btnBack setTitle:@"Back" forState:UIControlStateNormal];
    [_btnBack addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBack];
    
    _tvRecord = [[UITextView alloc] initWithFrame:CGRectMake(0, [self isIphoneX] ? 88.f : 44, self.view.frame.size.width, self.view.frame.size.height - ([self isIphoneX] ? 88.f : 44) - ([self isIphoneX] ? 68.f : 40.f))];
    _tvRecord.backgroundColor = [UIColor blackColor];
    _tvRecord.textColor = [UIColor whiteColor];
    [self.view addSubview:_tvRecord];
    
    _btnSwitch = [[UIButton alloc] init];
    _btnSwitch.frame = CGRectMake(self.view.frame.size.width / 2.0 - 40.f, [self isIphoneX] ? 44.f : 20.f, 80.f, 20.f);
    _btnSwitch.backgroundColor = UIColor.blackColor;
    [_btnSwitch setTitle:@"->ON-<" forState:UIControlStateNormal];
    [_btnSwitch addTarget:self action:@selector(btnSwitchClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSwitch];
    
    _btnChange = [[UIButton alloc] init];
    _btnChange.frame = CGRectMake(self.view.frame.size.width - 150.f, [self isIphoneX] ? 44.f : 20.f, 150.f, 20.f);
    _btnChange.backgroundColor = UIColor.blackColor;
    [_btnChange setTitle:@"Change UUID" forState:UIControlStateNormal];
    [_btnChange addTarget:self action:@selector(btnChangeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnChange];

    _btnCopy = [[UIButton alloc] init];
    _btnCopy.frame = CGRectMake(0, self.view.frame.size.height - 40.f - ([self isIphoneX] ? 28.f : 0), self.view.frame.size.width, 40.f + ([self isIphoneX] ? 28.f : 0));
    _btnCopy.backgroundColor = UIColor.blueColor;
    [_btnCopy setTitle:@"Copy Registered Info" forState:UIControlStateNormal];
    [_btnCopy addTarget:self action:@selector(btnCopyClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnCopy];
}

- (void)btnChangeClicked:(id)sender {
    [HYMBgTaskManager.shared generateNewRegisterDeviceUUID];
    [[UIPasteboard generalPasteboard] setString:HYMBgTaskManager.shared.currentRegisterDeviceUUID];
    [[[UIAlertView alloc] initWithTitle:@"Notice" message:[NSString stringWithFormat:@"Change Device UUID To %@, Check Your Pasteboard", HYMBgTaskManager.shared.currentRegisterDeviceUUID] delegate:nil cancelButtonTitle:@"Emmm.." otherButtonTitles:nil, nil] show];
}

- (void)btnSwitchClicked:(id)sender {
    HYMBgTaskManager.shared.shouldInterceptAllDeviceCode = !HYMBgTaskManager.shared.shouldInterceptAllDeviceCode;
    [_btnSwitch setTitle:HYMBgTaskManager.shared.shouldInterceptAllDeviceCode ? @"->ON<-" : @"->OFF-<" forState:UIControlStateNormal];
}

- (void)btnCopyClicked:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Notice" message:@"Congrats! Paste Anywhere u want..." delegate:nil cancelButtonTitle:@"Sure~" otherButtonTitles:nil, nil] show];
    [[UIPasteboard generalPasteboard] setString:_tvRecord.text];
}

- (void)btnBackClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)isIphoneX {
    return UIScreen.mainScreen.bounds.size.height == 812.f;
}

@end

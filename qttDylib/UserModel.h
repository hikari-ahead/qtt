//
//  UserModel.h
//  qttDylib
//
//  Created by kuangjeon on 2018/7/11.
//  Copyright © 2018 kuangjeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *pass;
@property (nonatomic, strong) NSString *device_code;
@property (nonatomic, strong) NSString *os_version;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@property (nonatomic, strong) NSString *netWork;
@property (nonatomic, strong) NSString *ua_os_version;

@property (nonatomic, strong) NSString *guid; // GUID=xxx
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *aliyungf_tc;
@property (nonatomic, strong) NSString *qkV2;
@property (nonatomic, strong) NSString *memId;
@property (nonatomic, strong) NSString *list_key; // content/getListV2->返回

@property (nonatomic, strong) NSString *coin;
@property (nonatomic, strong) NSString *balance;

@end

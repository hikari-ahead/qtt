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

@property (nonatomic, strong) NSString *guid; // GUID=xxx
@end

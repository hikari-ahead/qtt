//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class WBSDKFMDatabase, WBSDKFMResultSet;

@protocol WBSDKDBObjectAccessDelgate <NSObject>
+ (WBSDKFMResultSet *)selectDB:(WBSDKFMDatabase *)arg1 fromTime:(double)arg2 toTime:(double)arg3;
+ (void)deleteInDB:(WBSDKFMDatabase *)arg1 fromTime:(double)arg2 toTime:(double)arg3;
+ (id)objectFromRS:(WBSDKFMResultSet *)arg1;
+ (void)createTableIfNeeded:(WBSDKFMDatabase *)arg1;
- (void)deleteInDB:(WBSDKFMDatabase *)arg1;
- (void)updateDB:(WBSDKFMDatabase *)arg1;
- (void)insertToDataBase:(WBSDKFMDatabase *)arg1;
@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "LCBaseModel.h"

@class NSString;

@interface QKPreSignStatusModel : LCBaseModel
{
    unsigned long long _status;
    NSString *_coin;
    NSString *_detail;
}

@property(copy, nonatomic) NSString *detail; // @synthesize detail=_detail;
@property(copy, nonatomic) NSString *coin; // @synthesize coin=_coin;
@property(nonatomic) unsigned long long status; // @synthesize status=_status;
- (void).cxx_destruct;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

@class NSString;

@interface LCBaseModel : NSObject
{
    id _ext;
}

+ (_Bool)matching:(id)arg1;
@property(retain, nonatomic) id ext; // @synthesize ext=_ext;
- (void).cxx_destruct;
- (double)cellHeight;
@property(readonly, copy, nonatomic) NSString *cellKey;
@property(readonly, copy, nonatomic) NSString *identifier;
- (void)setWithAttribute:(id)arg1;
- (id)initWithAttribute:(id)arg1;
- (id)initWithAttribute:(id)arg1 info:(id)arg2;

@end


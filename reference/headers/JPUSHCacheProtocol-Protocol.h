//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@protocol JPUSHCacheProtocol <NSObject>

@optional
- (void)removeAllObjects;
- (void)setObject:(id)arg1 forKeyedSubscript:(id)arg2;
- (id)objectForKeyedSubscript:(id)arg1;
- (void)removeObjectForKey:(id)arg1;
- (void)setObject:(id)arg1 forKey:(id)arg2;
- (id)objectForKey:(id)arg1;
- (_Bool)hasObjectForKey:(id)arg1;
- (void)removeObjectsAtIndexes:(struct _NSRange)arg1;
- (void)removeFirstObject;
- (void)removeObject:(id)arg1;
- (void)setObject:(id)arg1;
@end


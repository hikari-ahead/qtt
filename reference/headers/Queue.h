//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

@class NSMutableArray;

@interface Queue : NSObject
{
    NSMutableArray *queue;
}

- (void).cxx_destruct;
- (void)emptyQueue;
- (id)top;
- (_Bool)dequeue;
- (void)enqueue:(id)arg1;
- (id)description;
- (id)init;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

@class NSString;

@interface LocalFile : NSObject
{
    _Bool _isDirectory;
    NSString *_name;
    NSString *_path;
    long long _size;
}

@property(nonatomic) _Bool isDirectory; // @synthesize isDirectory=_isDirectory;
@property(nonatomic) long long size; // @synthesize size=_size;
@property(copy, nonatomic) NSString *path; // @synthesize path=_path;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
- (void).cxx_destruct;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

#import "NSCopying-Protocol.h"

@class NSArray, NSMutableArray, NSMutableDictionary, NSString;

@interface V5AlertController : NSObject <NSCopying>
{
    NSString *_title;
    NSString *_message;
    long long _preferredStyle;
    NSMutableArray *_mutableActions;
    NSMutableArray *_mutableTextFields;
    NSMutableDictionary *_configurationHandlers;
}

+ (id)alertControllerWithTitle:(id)arg1 message:(id)arg2 preferredStyle:(long long)arg3;
@property(retain, nonatomic) NSMutableDictionary *configurationHandlers; // @synthesize configurationHandlers=_configurationHandlers;
@property(retain, nonatomic) NSMutableArray *mutableTextFields; // @synthesize mutableTextFields=_mutableTextFields;
@property(retain, nonatomic) NSMutableArray *mutableActions; // @synthesize mutableActions=_mutableActions;
@property(readonly, nonatomic) long long preferredStyle; // @synthesize preferredStyle=_preferredStyle;
@property(copy, nonatomic) NSString *message; // @synthesize message=_message;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
- (void).cxx_destruct;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (void)addTextFieldWithConfigurationHandler:(CDUnknownBlockType)arg1;
- (void)addAction:(id)arg1;
@property(readonly, nonatomic) NSArray *textFields;
@property(readonly, nonatomic) NSArray *actions;
- (id)initWithTitle:(id)arg1 message:(id)arg2 preferredStyle:(long long)arg3;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

@class NSData, NSMutableArray, NSString;

@interface LCAddressBookContactInfo : NSObject
{
    _Bool _selected;
    NSString *_name;
    NSString *_firstName;
    NSString *_middleName;
    NSString *_lastName;
    NSData *_avatarData;
    NSMutableArray *_phoneArray;
    NSMutableArray *_emailArray;
}

@property(nonatomic) _Bool selected; // @synthesize selected=_selected;
@property(retain, nonatomic) NSMutableArray *emailArray; // @synthesize emailArray=_emailArray;
@property(retain, nonatomic) NSMutableArray *phoneArray; // @synthesize phoneArray=_phoneArray;
@property(retain, nonatomic) NSData *avatarData; // @synthesize avatarData=_avatarData;
@property(copy, nonatomic) NSString *lastName; // @synthesize lastName=_lastName;
@property(copy, nonatomic) NSString *middleName; // @synthesize middleName=_middleName;
@property(copy, nonatomic) NSString *firstName; // @synthesize firstName=_firstName;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
- (void).cxx_destruct;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "LCSystemicService.h"

#import "ABPeoplePickerNavigationControllerDelegate-Protocol.h"
#import "UINavigationControllerDelegate-Protocol.h"

@class ABPeoplePickerNavigationController, NSString;

@interface LCAddressBookService : LCSystemicService <ABPeoplePickerNavigationControllerDelegate, UINavigationControllerDelegate>
{
    CDUnknownBlockType _didSelectContact;
    CDUnknownBlockType _didCancel;
    ABPeoplePickerNavigationController *_contactPicker;
}

@property(retain, nonatomic) ABPeoplePickerNavigationController *contactPicker; // @synthesize contactPicker=_contactPicker;
@property(copy, nonatomic) CDUnknownBlockType didCancel; // @synthesize didCancel=_didCancel;
@property(copy, nonatomic) CDUnknownBlockType didSelectContact; // @synthesize didSelectContact=_didSelectContact;
- (void).cxx_destruct;
- (void)getAllContacts:(CDUnknownBlockType)arg1;
- (void)peoplePickerNavigationControllerDidCancel:(id)arg1;
- (void)peoplePickerNavigationController:(id)arg1 didSelectPerson:(void *)arg2 property:(int)arg3 identifier:(int)arg4;
- (void)showServiceController;
- (void)requestAuthorization:(CDUnknownBlockType)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


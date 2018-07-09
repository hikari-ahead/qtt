//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSFileManager.h>

@interface NSFileManager (Ext)
+ (id)cacheDirectory;
+ (id)documentDirectory;
+ (id)getJSFileDirectory;
+ (id)getCacheFileDirectory;
+ (id)getDBFileDirectory;
+ (id)getTrackFileDirectory;
+ (id)getExceptionFileDirectory;
+ (id)getJSFilePath:(id)arg1;
+ (id)getFolderPath:(id)arg1;
+ (id)getFilePath:(id)arg1;
+ (_Bool)createFolderAtPath:(id)arg1;
+ (void)deleteWithFileName:(id)arg1;
+ (id)readArrayWithFilePath:(id)arg1;
+ (id)readArrayWithFileName:(id)arg1;
+ (id)readDataWithFilePath:(id)arg1;
+ (id)readDataWithFileName:(id)arg1;
+ (id)readStringWithFilePath:(id)arg1;
+ (id)readStringWithFileName:(id)arg1;
+ (id)readStringWithJSFileName:(id)arg1;
+ (id)readWithFilePath:(id)arg1;
+ (id)readWithFileName:(id)arg1;
+ (_Bool)writeWithFilePath:(id)arg1 object:(id)arg2;
+ (_Bool)writeWithJSFileName:(id)arg1 object:(id)arg2;
+ (_Bool)writeWithFileName:(id)arg1 object:(id)arg2;
@end


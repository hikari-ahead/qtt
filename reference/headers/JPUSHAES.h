//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

@interface JPUSHAES : NSObject
{
}

+ (id)encryptKeyWithSeed:(unsigned long long)arg1;
+ (id)aesDecryptData:(id)arg1 withKey:(id)arg2 withLen:(unsigned long long)arg3;
+ (id)aes256EncryptData:(id)arg1 withKey:(id)arg2 withLen:(unsigned long long)arg3;
+ (id)aes256DecryptData:(id)arg1 withKey:(id)arg2;
+ (id)aes256EncryptData:(id)arg1 withKey:(id)arg2;
+ (id)AES256DecryptData:(id)arg1 withKey:(id)arg2;
+ (id)AES256EncryptData:(id)arg1 withKey:(id)arg2;
+ (id)encrypt:(id)arg1 aesKey:(id)arg2;
+ (id)decrypt:(id)arg1 aesKey:(id)arg2;
+ (id)encryptDataTypeToCurrentStringType:(id)arg1;
+ (id)sharedAESUtils;
- (id)doCipher:(id)arg1 key:(id)arg2 context:(unsigned int)arg3 padding:(unsigned int *)arg4;
- (id)decrypt:(id)arg1 key:(id)arg2 padding:(unsigned int *)arg3;
- (id)encrypt:(id)arg1 key:(id)arg2 padding:(unsigned int *)arg3;

@end

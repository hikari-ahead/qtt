//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSObject.h>

@class NSDictionary, NSString;

@interface CocoaClass : NSObject
{
    _Bool _needUpdate;
    _Bool _isMeta;
    NSDictionary *_propertyInfos;
    NSDictionary *_methodInfos;
    NSDictionary *_ivarInfos;
    Class _cls;
    Class _superCls;
    Class _metaCls;
    NSString *_name;
    CocoaClass *_superClassInfo;
}

+ (_Bool)swizzleMethodForClass:(Class)arg1 oldSel:(SEL)arg2 withMethod:(SEL)arg3;
+ (id)resolveWithClassName:(id)arg1;
+ (id)resolve:(Class)arg1;
@property(readonly, nonatomic) CocoaClass *superClassInfo; // @synthesize superClassInfo=_superClassInfo;
@property(readonly, nonatomic) NSString *name; // @synthesize name=_name;
@property(readonly, nonatomic) _Bool isMeta; // @synthesize isMeta=_isMeta;
@property(readonly, nonatomic) Class metaCls; // @synthesize metaCls=_metaCls;
@property(readonly, nonatomic) Class superCls; // @synthesize superCls=_superCls;
@property(readonly, nonatomic) Class cls; // @synthesize cls=_cls;
- (void).cxx_destruct;
@property(readonly, nonatomic) NSDictionary *ivarInfos; // @synthesize ivarInfos=_ivarInfos;
@property(readonly, nonatomic) NSDictionary *methodInfos; // @synthesize methodInfos=_methodInfos;
@property(readonly, nonatomic) NSDictionary *propertyInfos; // @synthesize propertyInfos=_propertyInfos;
- (void)copyIvarList:(CDUnknownBlockType)arg1;
- (void)copyMethodList:(CDUnknownBlockType)arg1;
- (_Bool)swizzleMethod:(SEL)arg1 withMethod:(SEL)arg2;
- (void)copyPropertyList:(CDUnknownBlockType)arg1;
- (void)updateIfNeed;
- (_Bool)needUpdate;
- (void)setNeedUpdate;
- (void)__update;
- (id)initWithClass:(Class)arg1;

@end


//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "QKTableViewCell.h"

#import "LCTableViewCellConfigure-Protocol.h"

@class NSString, UIButton, UILabel;

@interface QKHomeSpaceCell : QKTableViewCell <LCTableViewCellConfigure>
{
    UILabel *_label;
    UIButton *_refresh;
}

@property(retain, nonatomic) UIButton *refresh; // @synthesize refresh=_refresh;
@property(retain, nonatomic) UILabel *label; // @synthesize label=_label;
- (void).cxx_destruct;
- (void)layoutSubviews;
- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2;
- (void)configureCellWithModel:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end


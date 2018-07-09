//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UICollectionViewCell.h>

@class QKPreSignStatusModel, UIImageView, UILabel;

@interface QKPreSignDayCell : UICollectionViewCell
{
    QKPreSignStatusModel *_signStatusModel;
    UILabel *_coinLabel;
    UIImageView *_statusImageView;
    UIImageView *_lineImageView;
    UILabel *_detailLabel;
}

@property(retain, nonatomic) UILabel *detailLabel; // @synthesize detailLabel=_detailLabel;
@property(retain, nonatomic) UIImageView *lineImageView; // @synthesize lineImageView=_lineImageView;
@property(retain, nonatomic) UIImageView *statusImageView; // @synthesize statusImageView=_statusImageView;
@property(retain, nonatomic) UILabel *coinLabel; // @synthesize coinLabel=_coinLabel;
@property(retain, nonatomic) QKPreSignStatusModel *signStatusModel; // @synthesize signStatusModel=_signStatusModel;
- (void).cxx_destruct;
- (void)hideLine;
- (void)setLast;
- (void)setFirst;
- (void)initSubviews;
- (id)initWithFrame:(struct CGRect)arg1;

@end

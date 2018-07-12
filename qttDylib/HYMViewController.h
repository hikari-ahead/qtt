//
//  HYMViewController.h
//  qttDylib
//
//  Created by kuangjeon on 2018/7/12.
//  Copyright © 2018年 kuangjeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMViewController : UIViewController
@property (nonatomic, strong, readonly) UITableView *tableView;
- (void)updateCellAtRow:(NSUInteger)row;
@end

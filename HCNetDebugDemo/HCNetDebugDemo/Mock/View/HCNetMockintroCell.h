//
//  HCNetMockintroCell.h
//  HCDebugTool_Example
//
//  Created by 黄鸿昌 on 2019/1/15.
//  Copyright © 2019 honchwong404@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCNetMockIntroViewModel.h"

@class HCNetMockintroCell;
@protocol HCNetMockintroCellActionDelegate <NSObject>

- (void)cell:(HCNetMockintroCell *)cell switchViewDidTap:(BOOL)isOn;
- (void)cellEditRuleBtnDidClick:(HCNetMockintroCell *)cell;

@end

@interface HCNetMockintroCell : UITableViewCell

@property (nonatomic, strong) HCNetMockIntroViewModel *viewModel;
@property (nonatomic, weak) id<HCNetMockintroCellActionDelegate> delegate;

+ (CGFloat)cellHeight;

@end


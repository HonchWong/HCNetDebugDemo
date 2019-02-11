//
//  HCNetDebugModule.m
//  HCNetDebugDemo
//
//  Created by 黄鸿昌 on 2019/2/11.
//  Copyright © 2019 黄鸿昌. All rights reserved.
//

#import "HCNetDebugModule.h"
#import "GYHttpMock.h"
#import "FLEX.h"
#import "HCNetDebugMockViewController.h"

typedef NS_OPTIONS(NSInteger, HCNetDebugOptionViewTag) {
    HCNetDebugOptionViewTag_Mock = 1,
    HCNetDebugOptionViewTag_PacketCapture,
};

@implementation HCNetDebugModule

#pragma mark - Private

+ (void)load {
    [[HCDebugToolManager sharedManager] registerModule:[[self alloc] init]];
}

#pragma mark - HCDebugToolCommonOptionViewDelegate

- (void)optionDidSelected:(HCDebugToolCommonOptionItemViewModel *)option
                  atIndex:(NSInteger)index {
    switch (option.viewTag) {
        case HCNetDebugOptionViewTag_Mock:
        {
            HCNetDebugMockViewController *vc =
            [[HCNetDebugMockViewController alloc] init];
            UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
            [self hideMenuView:^{
                [self presentViewController:naviVC];
            }];
            mockRequest(@"GET", @"https://www.easy-mock.com/mock/5b877ba37eb5e51ccf7d4db1/example/testBookList");
        }
            break;
        case HCNetDebugOptionViewTag_PacketCapture:
        {
            [[FLEXManager sharedManager] showExplorer];
        }
            break;
        default:
            break;
    }
}

#pragma mark - HCDebugToolModuleProtocol

- (NSString *)moduleTitle {
    return @"网络调试";
}

#pragma mark - SuperClass

- (NSArray <NSDictionary *>*)optionDicts {
    return @[@{HCDebugCommonModuleOptionKeys.title: @"Mock网络数据",
               HCDebugCommonModuleOptionKeys.viewTag: @(HCNetDebugOptionViewTag_Mock),
               },
             @{HCDebugCommonModuleOptionKeys.title: @"FLEX",
               HCDebugCommonModuleOptionKeys.viewTag: @(HCNetDebugOptionViewTag_PacketCapture),
               }];
}

@end

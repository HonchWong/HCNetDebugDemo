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
    HCNetDebugOptionViewTag_TestBookList,
};

@implementation HCNetDebugModule

#pragma mark - Private

+ (void)load {
    [[HCDebugToolManager sharedManager] registerModule:[[self alloc] init]];
}

- (void)testBookList {
    NSURL *url = [NSURL URLWithString:@"https://www.easy-mock.com/mock/5b877ba37eb5e51ccf7d4db1/example/testBookList"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask =
    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dict) {
            NSData *dictData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonString = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
            NSLog(@"%@", jsonString);
        } else {
            NSLog(@"data null");
        }
    }];
    [dataTask resume];
}

#pragma mark - HCDebugToolCommonOptionViewDelegate

- (void)optionDidSelected:(HCDebugToolCommonOptionItemViewModel *)option
                  atIndex:(NSInteger)index {
    switch (option.viewTag) {
        case HCNetDebugOptionViewTag_Mock:
        {
            HCNetDebugMockViewController *vc =
            [[HCNetDebugMockViewController alloc] init];
            [self pushViewController:vc];
        }
            break;
        case HCNetDebugOptionViewTag_PacketCapture:
        {
            [[FLEXManager sharedManager] showExplorer];
        }
            break;
        case HCNetDebugOptionViewTag_TestBookList:
        {
            [self testBookList];
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
               },
             @{HCDebugCommonModuleOptionKeys.title: @"TestBookList",
               HCDebugCommonModuleOptionKeys.viewTag: @(HCNetDebugOptionViewTag_TestBookList),
               }];
}

@end

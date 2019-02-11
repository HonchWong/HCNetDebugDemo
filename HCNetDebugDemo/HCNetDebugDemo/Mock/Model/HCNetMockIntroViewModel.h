//
//  HCNetMockIntroViewModel.h
//  HCDebugTool_Example
//
//  Created by 黄鸿昌 on 2019/1/15.
//  Copyright © 2019 honchwong404@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCNetMockIntroViewModel : NSObject

@property (nonatomic, strong) NSString *urlDetail;
@property (nonatomic, strong) NSString *urlDesc;
@property (nonatomic, strong) NSString *identity;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end


//
//  HCNetDebugMockViewController.m
//  HCDebugTool_Example
//
//  Created by 黄鸿昌 on 2019/1/13.
//  Copyright © 2019 honchwong404@gmail.com. All rights reserved.
//

#import "HCNetDebugMockViewController.h"
#import "HCNetMockintroCell.h"
#import "HCNetMockManager.h"
#import "HCNetDebugMockRuleViewController.h"

@interface HCNetDebugMockViewController () <
UITableViewDelegate,
UITableViewDataSource,
HCNetMockintroCellActionDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <HCNetMockIntroViewModel *>*viewModels;

@end

@implementation HCNetDebugMockViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupBackBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self loadData];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - navibar

- (void)setupBackBtn {
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(closePage)];
    self.title = @"Mock 设置";
}

- (void)closePage {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Data

- (void)loadData {
    [[HCNetMockManager sharedManager] requestIntroViewModelWithCompletionHandler:^(BOOL success, NSArray<HCNetMockIntroViewModel *> *viewModels) {
        [self.viewModels addObjectsFromArray:viewModels];
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HCNetMockintroCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCNetMockintroCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HCNetMockintroCell class])];
    if (!cell) {
        cell = [[HCNetMockintroCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:NSStringFromClass([HCNetMockintroCell class])];
    }
    [cell setViewModel:[self.viewModels objectAtIndex:indexPath.row]];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - HCNetMockintroCellActionDelegate

- (void)cell:(HCNetMockintroCell *)cell switchViewDidTap:(BOOL)isOn {
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    HCNetMockIntroViewModel *viewModel = [self.viewModels objectAtIndex:index];
    
    if (isOn) {
        [[HCNetMockManager sharedManager] startMockWithIdentity:viewModel.identity];
    } else {
        [[HCNetMockManager sharedManager] stopMockWithIdentity:viewModel.identity];
    }
}

- (void)cellEditRuleBtnDidClick:(HCNetMockintroCell *)cell {
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    HCNetMockIntroViewModel *viewModel = [self.viewModels objectAtIndex:index];
    HCNetDebugMockRuleViewController *vc =
    [[HCNetDebugMockRuleViewController alloc] initWithRuleIdentity:viewModel.identity];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 44,
                                  self.view.bounds.size.width,
                                  self.view.bounds.size.height - 44);
        _tableView =
        [[UITableView alloc] initWithFrame:frame
                                     style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (NSMutableArray<HCNetMockIntroViewModel *> *)viewModels {
    if (!_viewModels) {
        _viewModels = @[].mutableCopy;
    }
    return _viewModels;
}

@end

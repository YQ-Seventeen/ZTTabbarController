//
//  ViewController2.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/21.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "ViewController2.h"
#import <ZTTabbarController/ZTTabbarController.h>
@interface ViewController2 () <UITableViewDelegate, UITableViewDataSource>
@end
@implementation ViewController2 {
    UITableView * _tabview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                = @"我是tab2";
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.
    BOOL isPhoneX = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
    float tabbarDefaultHeight = isPhoneX ? 83 : 49;
    UITableView *tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), [UIScreen mainScreen].bounds.size.height - tabbarDefaultHeight) style:UITableViewStylePlain];
    tabView.delegate   = self;
    tabView.dataSource = self;
    [self.view addSubview:tabView];
    _tabview = tabView;
}

- (void)viewWillLayoutSubviews {
    BOOL isPhoneX = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
    float tabbarDefaultHeight = isPhoneX ? 83 : 49;
    _tabview.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)  - tabbarDefaultHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"123"];
    [cell.textLabel setText:@"这是测试标题"];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
@end

//
//  ViewController4.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/21.
//  Copyright © 2017年 Suning. All rights reserved.
//

#import "ViewController4.h"
#import <ZTTabbarController/ZTTabbarController.h>
#import "ViewController.h"
@interface ViewController4 ()

@end

@implementation ViewController4
+ (void)load {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是tab4";
    self.view.backgroundColor = [UIColor purpleColor];
    self.hidesTabbarWhenPushed = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController * vc = [[ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [self.zt_tabbar setTabbarHidden:YES animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.zt_tabbar setTabbarHidden:NO animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

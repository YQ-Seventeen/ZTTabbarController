//
//  CustomNavigationController.m
//  ZTTabbarController
//
//  Created by yq on 2018/1/4.
//  Copyright © 2018年 Suning. All rights reserved.
//

#import "CustomNavigationController.h"
#import <ZTTabbarController/ZTTabbarController.h>
@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
}

@end

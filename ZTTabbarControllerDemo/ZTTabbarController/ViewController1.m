//
//  ViewController1.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/21.
//  Copyright © 2017年 Suning. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是tab1";
    self.view.backgroundColor = [UIColor redColor];
    
    
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"%@ %s",NSStringFromClass([self class]),(__bridge char *)_cmd);
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll ;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
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

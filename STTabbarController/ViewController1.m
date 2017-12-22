//
//  ViewController1.m
//  STTabbarController
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
    
    
    UIView * blueView = [[UIView alloc]init];
    blueView.frame = CGRectMake(0, 64, 20, 30);
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView * yellowView = [[UIView alloc]init];
    yellowView.frame = CGRectMake(0, self.view.frame.size.height - 49- 50 - 64, 100, 50);
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

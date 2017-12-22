//
//  STTabbarItemModel.h
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface STTabbarItemModel : NSObject
- (instancetype)initWithNormalImageName:(NSString *)normalImageName andSelectImageName:(NSString *)selectImageName andTitle:(NSString *)title;
@property (copy, nonatomic) NSString *normalImageName;
@property (copy, nonatomic) NSString *selectImageName;
@property (copy, nonatomic) NSString *title;
- (BOOL)isModelValidate;
@end

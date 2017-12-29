//
//  ZTTabbarItemModel.h
//  ZTTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface ZTTabbarItemModel : NSObject
- (instancetype)initWithNormalImageName:(id)imageName andSelectImageName:(id)selectImageName andTitle:(NSString *)title;
@property (copy, nonatomic) id imageName;
@property (copy, nonatomic) id selectImageName;
@property (copy, nonatomic) NSString *title;
- (BOOL)isModelValidate;
@end

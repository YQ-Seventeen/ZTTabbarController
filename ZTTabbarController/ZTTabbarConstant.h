//
//  ZTTabbarConstant.h
//  Pods
//
//  Created by yq on 2017/12/26.
//
#ifndef ZTTabbarConstant_h
#define ZTTabbarConstant_h
#import <Foundation/Foundation.h>

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define ZTTabbarDefaultHeight (kDevice_Is_iPhoneX) ? 83 : 49;
#define ZTTabbarContentHeight 49;
#define ZTJudge_STR_EMPTY(exp) (![exp isKindOfClass:[NSString class]] || !exp || exp == (id) kCFNull || !exp.length)
UIKIT_EXTERN CGFloat const ZTTabbarImageDefaultWidth;
UIKIT_EXTERN CGFloat const ZTTabbarImageDefaultHeight;
UIKIT_EXTERN CGFloat const ZTTabbarImageDefaultWidthWithTitle;
UIKIT_EXTERN CGFloat const ZTTabbarImageDefaultHeightWithTitle;
UIKIT_EXTERN CGFloat const ZTTabbarImageMaxSize;
UIKIT_EXTERN CGFloat const ZTTabbarImageMaxSizeWithTitle;
UIKIT_EXTERN CGFloat const ZTTabbarTitleFontMaxSize;
#endif /* STTabbarConstant_h */

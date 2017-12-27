//
//  STTabbarConstant.h
//  Pods
//
//  Created by yq on 2017/12/26.
//
#ifndef STTabbarConstant_h
#define STTabbarConstant_h
#import <Foundation/Foundation.h>

#define STAvoidPerformSelectorWarning(block)                                    \
do {                                                                            \
_Pragma("clang diagnostic push")                                                \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")             \
block;                                                                          \
_Pragma("clang diagnostic pop")                                                 \
} while (0);

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define STTabbarDefaultHeight (kDevice_Is_iPhoneX) ? 83 : 49;
#define STTabbarContentHeight 49;
#define STR_IS_EMPTY(exp) (![exp isKindOfClass:[NSString class]] || !exp || exp == (id) kCFNull || !exp.length)
UIKIT_EXTERN CGFloat const STTabbarImageDefaultWidthWithTitle;
UIKIT_EXTERN CGFloat const STTabbarImageDefaultHeightWithTitle;
UIKIT_EXTERN CGFloat const STTabbarImageDefaultWidthWithoutTitle;
UIKIT_EXTERN CGFloat const STTabbarImageDefaultHeightWithoutTitle;
#endif /* STTabbarConstant_h */

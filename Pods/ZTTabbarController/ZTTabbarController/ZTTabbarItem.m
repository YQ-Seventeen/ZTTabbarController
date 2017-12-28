//
//  ZTTabbarItem.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "ZTTabbarItem.h"
#import "ZTTabbarItemModel.h"
#import "UIView+ZTTabbar.h"
#import "ZTTabbarItemAttribute.h"
#import "ZTTabbarConstant.h"
static float imageTitleVSpace = 5.0f;
CGSize zt_calcuteTitleAdjustSize(ZTTabbarItemModel *model, UIFont *titleFont, UIView *v) {
    NSDictionary *dic  = @{NSFontAttributeName : titleFont};
    float adjustMargin = 5.0f;
    float maxWidth     = v.zt_w - adjustMargin;
    CGRect fillRect    = [model.title boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:NULL];
    fillRect.size.width = MIN(fillRect.size.width, maxWidth);
    return fillRect.size;
}
CGSize zt_calculateImageAdjustSize(UIImage *zt_image, ZTTabbarItemModel *model,ZTTabbarItemAttribute * attribute) {
    
    CGSize imageSize;
    if (!CGSizeEqualToSize(attribute.itemImgSize, CGSizeZero)) {
        imageSize = attribute.itemImgSize;
    }
    else{
        imageSize = zt_image.size;
    }
    float maxWidth, maxHeight;
    if (model.title && model.title.length > 0) {
        maxWidth  = ZTTabbarImageDefaultWidthWithTitle;
        maxHeight = ZTTabbarImageDefaultHeightWithTitle;
    } else {
        maxWidth  = ZTTabbarImageDefaultWidthWithoutTitle;
        maxHeight = ZTTabbarImageDefaultHeightWithoutTitle;
    }
    imageSize = CGSizeMake(MIN(maxWidth, imageSize.width),MIN(maxHeight, imageSize.height));
    return imageSize;
}
CGRect zt_calculateImageAdjustPosition(UIImage *zt_image, STTabbarItemModel *model, UIView *v, STTabbarItemAttribute *attribute) {
    CGSize imageAdjustSize = zt_calculateImageAdjustSize(zt_image, model,attribute);
    CGSize titleAdjustSize = zt_calcuteTitleAdjustSize(model, attribute.itemTitleFont, v);
    float x, y = 0;
    if (model.title && model.title.length > 0) {
        y = (v.zt_h - imageAdjustSize.height - titleAdjustSize.height - imageTitleVSpace) / 2;
    } else {
        y = (v.zt_h - imageAdjustSize.height) / 2;
    }
    x = (v.zt_w - imageAdjustSize.width) / 2;
    return (CGRect){CGPointMake(x, y), imageAdjustSize};
}
CGRect zt_calcuteTitleAdjustPosition(ZTTabbarItemModel *model, UIView *v, ZTTabbarItemAttribute *attribute) {
    CGSize titleAdjustSize = zt_calcuteTitleAdjustSize(model, attribute.itemTitleFont, v);
    float x, y = 0;
    x = (v.zt_w - titleAdjustSize.width) / 2;
    y = (v.zt_h - titleAdjustSize.height - 2);
    return (CGRect){CGPointMake(x, y), titleAdjustSize};
}
@implementation ZTTabbarItem {
    UIImageView *_itemImageView;
    UILabel *_itemTitleLabel;
    UIView *_itemBadgeView;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addTapGesture];
    }
    return self;
}
- (void)layoutSubviews {
    _itemImageView.frame  = zt_calculateImageAdjustPosition(_itemImageView.image, _dataModel, self, _attribute);
    _itemTitleLabel.frame = zt_calcuteTitleAdjustPosition(_dataModel, self, _attribute);
}
- (void)setDataModel:(ZTTabbarItemModel *)dataModel {
    if (_dataModel != dataModel && [dataModel isModelValidate]) {
        _dataModel = dataModel;
        [self setupItem];
    }
}
- (void)setAttribute:(ZTTabbarItemAttribute *)attribute {
    _attribute = attribute;
}
- (void)setupItem {
    UIImage *itemNormalImage = [UIImage imageNamed:self.dataModel.normalImageName];
    if (itemNormalImage == nil) NSAssert(NO, @"error");
    _itemImageView  = [[UIImageView alloc] init];
    [_itemImageView setImage:itemNormalImage];
    [self addSubview:_itemImageView];
    
    NSString *title = self.dataModel.title;
    if (title && title.length > 0) {
        _itemTitleLabel      = [[UILabel alloc] init];
        _itemTitleLabel.font = self.attribute.itemTitleFont;
        _itemTitleLabel.text = title;
        [self addSubview:_itemTitleLabel];
    }
    
    if (self.attribute.itemBgColor) {
        self.backgroundColor = self.attribute.itemBgColor;
    }
}

- (void)addTapGesture {
    ZTAvoidPerformSelectorWarning({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTabbarItem:)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    })
}
- (void)clickTabbarItem:(UIGestureRecognizer *)ges {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZTTabbarItemDidClickNotification" object:@(ges.view.tag)];
}
- (void)setSelect:(BOOL)select {
    if (_select == select) return;
    if (select) {
        self->_itemTitleLabel.textColor = self.attribute.itemTitleSelectColor;
        self->_itemImageView.image      = [UIImage imageNamed:self.dataModel.selectImageName];
        if (self.attribute.itemBgSelectColor) {
            self.backgroundColor            = self.attribute.itemBgSelectColor;
        }
    } else {
        self->_itemTitleLabel.textColor = self.attribute.itemTitleColor;
        self->_itemImageView.image      = [UIImage imageNamed:self.dataModel.normalImageName];
        if (self.attribute.itemBgColor) {
            self.backgroundColor            = self.attribute.itemBgColor;
        }
    }
    _select = select;
}
@end

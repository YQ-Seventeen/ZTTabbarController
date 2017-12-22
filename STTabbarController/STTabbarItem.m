//
//  STTabbarItem.m
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "STTabbarItem.h"
#import "STTabbarItemModel.h"
#import "UIView+Util.h"
#import "STTabbarItemAttribute.h"
#define WIDTH_WITHTITLE_MAX 30
#define HEIGHT_WITHTITLE_MAX 30
#define WIDTH_WITHOUTTITLE_MAX 41
#define HEIGHT_WIDTHOUTTITLE_MAX 41
#define SYSTEM_IMAGE_SIZE CGSizeMake(30, 30)


static float  imageTitleVSpace = 5.0f;


CGSize st_calcuteTitleAdjustSize(STTabbarItemModel *model,UIFont * titleFont,UIView * v) {
    NSDictionary * dic = @{NSFontAttributeName:titleFont};
    float adjustMargin = 5.0f;
    float maxWidth     = v.st_w - adjustMargin;
    CGRect fillRect = [model.title boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:NULL];
    fillRect.size.width = MIN(fillRect.size.width, maxWidth);
    return fillRect.size;
}

 CGSize st_calculateImageAdjustSize(UIImage *st_image, STTabbarItemModel *model) {
    CGSize imageSize = st_image.size;
    float maxWidth, maxHeight;
    if (model.title && model.title.length > 0) {
        maxWidth  = WIDTH_WITHTITLE_MAX;
        maxHeight = HEIGHT_WITHTITLE_MAX;
    } else {
        maxWidth  = WIDTH_WITHOUTTITLE_MAX;
        maxHeight = HEIGHT_WIDTHOUTTITLE_MAX;
    }
    if (imageSize.width >= maxWidth || imageSize.height >= maxHeight) {
        imageSize = SYSTEM_IMAGE_SIZE;
    }
    return imageSize;
}


CGRect st_calculateImageAdjustPosition(UIImage *st_image, STTabbarItemModel *model,UIView * v ,STTabbarItemAttribute * attribute) {
    CGSize imageAdjustSize = st_calculateImageAdjustSize(st_image, model);
    CGSize titleAdjustSize = st_calcuteTitleAdjustSize(model, attribute.titleFont, v);
    float x,y = 0;
    if (model.title && model.title.length > 0) {
        y = (v.st_h - imageAdjustSize.height - titleAdjustSize.height - imageTitleVSpace)/2;
    }
    else{
        y = (v.st_h - imageAdjustSize.height)/2;
    }
    x =  (v.st_w - imageAdjustSize.width)/2;
    
    return (CGRect){CGPointMake(x, y),imageAdjustSize};
}



CGRect st_calcuteTitleAdjustPosition(STTabbarItemModel *model,UIView * v,STTabbarItemAttribute * attribute) {
    CGSize titleAdjustSize =  st_calcuteTitleAdjustSize(model, attribute.titleFont, v);
    float x,y = 0;
    x = (v.st_w - titleAdjustSize.width)/2;
    y = (v.st_h - titleAdjustSize.height -2);
    
    return (CGRect){CGPointMake(x, y),titleAdjustSize};
}

@implementation STTabbarItem {
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
    _itemImageView.frame  = st_calculateImageAdjustPosition(_itemImageView.image, _dataModel, self, _attribute);
    _itemTitleLabel.frame = st_calcuteTitleAdjustPosition(_dataModel, self, _attribute);
}
- (void)setDataModel:(STTabbarItemModel *)dataModel {
    if (_dataModel != dataModel && [dataModel isModelValidate]) {
        _dataModel = dataModel;
        [self setupItem];
    }
}
- (void)setAttribute:(STTabbarItemAttribute *)attribute {
    _attribute = attribute;
}
- (void)setupItem {
    UIImage *itemNormalImage = [UIImage imageNamed:self.dataModel.normalImageName];
    if (itemNormalImage == nil)
        NSAssert(NO, @"error");
    NSString *title = self.dataModel.title;
    _itemImageView  = [[UIImageView alloc] init];
    [_itemImageView setImage:itemNormalImage];
    if (title && title.length > 0) {
        _itemTitleLabel      = [[UILabel alloc] init];
        _itemTitleLabel.font = self.attribute.titleFont;
        _itemTitleLabel.text = title;
    }
    [self addSubview:_itemImageView];
    [self addSubview:_itemTitleLabel];
}
#define SuppressPerformSelectorLeakWarning(Stuff)                               \
    do {                                                                        \
        _Pragma("clang diagnostic push")                                        \
            _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
                Stuff;                                                          \
        _Pragma("clang diagnostic pop")                                         \
    } while (0);
- (void)addTapGesture {
    SuppressPerformSelectorLeakWarning({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTabbarItem:)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    })
}
- (void)clickTabbarItem:(UIGestureRecognizer *)ges {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"STTabbarItemDidClickNotification" object:@(ges.view.tag)];
}
- (void)setSelect:(BOOL)select {
    if (_select == select)
        return;
    NSString *imageKey;
    NSString *titleColorKey;
    if (select) {
        imageKey      = @"selectImageName";
        titleColorKey = @"titleSelectColor";
    } else {
        imageKey      = @"normalImageName";
        titleColorKey = @"titleColor";
    }
    self->_itemTitleLabel.textColor = [self.attribute valueForKey:titleColorKey];
    self->_itemImageView.image      = [UIImage imageNamed:[self.dataModel valueForKey:imageKey]];
    _select                         = select;
}
@end

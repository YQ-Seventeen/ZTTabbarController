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
static float imageTitleVSpace = 2.0f;


@interface UIView (Animation)
- (void)zt_addAnimations:(NSArray *)animations forKey:(NSString *)key;
- (void)zt_removeAnimationsWithKey:(NSString *)key;
- (BOOL)zt_isAnimating;
@end

@implementation UIView(Animation)
static float keyTimes = 1.0/24;
- (void)zt_addAnimations:(NSArray *)animations forKey:(NSString *)key {
    
    NSMutableArray * imagesRefArray = [NSMutableArray new];
    NSMutableArray * keyTimesArray       = [NSMutableArray new];
    for (UIImage * image in animations) {
        [imagesRefArray addObject:(__bridge id)[image CGImage]];
        [keyTimesArray addObject:[NSNumber numberWithFloat:keyTimes]];
    }
    
    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    keyFrameAnimation.calculationMode = kCAAnimationDiscrete;

    keyFrameAnimation.repeatCount = CGFLOAT_MAX;
    keyFrameAnimation.duration = keyTimes*animations.count;
    keyFrameAnimation.values = imagesRefArray;
    CALayer * layer = [CALayer layer];
    layer.frame = self.bounds;
    [layer addAnimation:keyFrameAnimation forKey:key];
    [self.layer addSublayer:layer];
}

- (void)zt_removeAnimationsWithKey:(NSString *)key {
    CALayer * animationLayer = [[self.layer sublayers]lastObject];
    [animationLayer removeAnimationForKey:key];
    [animationLayer removeFromSuperlayer];
}

- (BOOL)zt_isAnimating {
    CALayer * animationLayer = [[self.layer sublayers]lastObject];
    return [animationLayer.animationKeys count];
}
@end


@interface ZTTabbarItemBadgeView : UIView
@property (assign,nonatomic) NSInteger badgeNumber;
@property (strong,nonatomic) UILabel  *badgeNumberLabel;
- (instancetype)initWithBadgeNumber:(NSInteger)badgeNumber;
- (void)updateBadgeNumber:(NSInteger)badgeNumber;
@end


@implementation ZTTabbarItemBadgeView
- (instancetype)initWithBadgeNumber:(NSInteger)badgeNumber {
    self = [super init];
    if(self){
        self.badgeNumber = badgeNumber;
        [self addSubview:self.badgeNumberLabel];
        [self updateBadgeNumber:badgeNumber];
        self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

- (void)updateBadgeNumber:(NSInteger)badgeNumber {
    if (self.hidden) {
        self.hidden = !self.hidden;
    }
    if (!badgeNumber || ABS(badgeNumber) != badgeNumber) {
        self.badgeNumberLabel.hidden = YES;
    }
    else{
        self.badgeNumberLabel.hidden = NO;
    }
    NSString *badgeString = [NSString stringWithFormat:@"%ld",badgeNumber];
    [self.badgeNumberLabel setText:badgeString];
}


- (void)layoutSubviews {
    self.badgeNumberLabel.frame = self.bounds;
    float height = self.zt_h;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = height/2;
}

- (UILabel *)badgeNumberLabel {
    if (!_badgeNumberLabel) {
        _badgeNumberLabel = [UILabel new];
        _badgeNumberLabel.textColor = [UIColor whiteColor];
        _badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
        _badgeNumberLabel.font = [UIFont systemFontOfSize:12];
    }
    return _badgeNumberLabel;
}


@end


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
        maxWidth  = ZTTabbarImageDefaultWidth;
        maxHeight = ZTTabbarImageDefaultHeight;
    }
    imageSize = CGSizeMake(MIN(maxWidth, imageSize.width),MIN(maxHeight, imageSize.height));
    return imageSize;
}
CGRect zt_calculateImageAdjustPosition(UIImage *zt_image, ZTTabbarItemModel *model, UIView *v, ZTTabbarItemAttribute *attribute) {
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
    y = (v.zt_h - titleAdjustSize.height - 3);
    return (CGRect){CGPointMake(x, y), titleAdjustSize};
}
@implementation ZTTabbarItem {
    UIImageView *_itemImageView;
    UILabel *_itemTitleLabel;
    UIView *_itemBadgeView;
    NSMutableArray<UIImage *> * _normalImageArray;
    NSMutableArray<UIImage *> * _selectImageArray;
    NSString  *   _animationKey;
    ZTTabbarItemBadgeView * _badgeView;
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


- (void)didMoveToSuperview {
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

- (void)setIndex:(NSInteger)index {
    _index = index;
    _animationKey = [NSString stringWithFormat:@"ZTTabbar%ld",index];
}

- (void)setupImageObjectArray {
    id imageName = self.dataModel.imageName;
    NSMutableArray<UIImage *> * imageArrays = [NSMutableArray arrayWithCapacity:1];
    if ([imageName isKindOfClass:[NSString class]]) {
        UIImage * image = [UIImage imageNamed:imageName];
        [imageArrays addObject:image];
    }
    else if([imageName isKindOfClass:[NSArray class]]){
        [(NSArray *)imageName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [imageArrays addObject:[UIImage imageNamed:obj]];
        }];
    }
    _normalImageArray = imageArrays;
    
    
    id selectImageName = self.dataModel.selectImageName;
    if (selectImageName == nil) {
        _selectImageArray = _normalImageArray;
    }
    else{
        NSMutableArray<UIImage *> * selectImageArrays = [NSMutableArray arrayWithCapacity:1];
        if ([selectImageName isKindOfClass:[NSString class]]) {
            UIImage * image = [UIImage imageNamed:selectImageName];
            [selectImageArrays addObject:image];
        }
        else if([selectImageName isKindOfClass:[NSArray class]]){
            [(NSArray *)selectImageName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [selectImageArrays addObject:[UIImage imageNamed:obj]];
            }];
        }
        _selectImageArray = selectImageArrays;
    }
}

- (void)setupItem {
    
    if (self.attribute.itemBgColor) {
        self.backgroundColor = self.attribute.itemBgColor;
    }
    
    [self setupImageObjectArray];
    
    _itemImageView  = [[UIImageView alloc] init];
    [self addSubview:_itemImageView];
    
    NSString *title = self.dataModel.title;
    if (title && title.length > 0) {
        _itemTitleLabel      = [[UILabel alloc] init];
        _itemTitleLabel.font = self.attribute.itemTitleFont;
        [self addSubview:_itemTitleLabel];
    }
    
    if (_normalImageArray.count>1 || _selectImageArray.count>1) {
        _itemImageView.animationRepeatCount = 0;
    }
    
}

- (void)setupItemImage {
    if (_itemImageView.zt_isAnimating) {
        [_itemImageView zt_removeAnimationsWithKey:_animationKey];
    }
    if (_itemImageView.image){
        _itemImageView.image = nil;
    }
    NSArray * images = _select.boolValue?_selectImageArray:_normalImageArray;
    if (images.count > 1) {
        [_itemImageView zt_addAnimations:images forKey:_animationKey];
    }
    else {
        if (_itemImageView.image != images.firstObject) {
            _itemImageView.image = images.firstObject;
        }
    }
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTabbarItem:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
}
- (void)clickTabbarItem:(UIGestureRecognizer *)ges {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZTTabbarItemDidClickNotification" object:@(ges.view.tag)];
}
- (void)setSelect:(NSNumber *)select {
    if (_select && _select == select) return;
    if (select.boolValue) {
        self->_itemTitleLabel.textColor = self.attribute.itemTitleSelectColor;
        if (self.attribute.itemBgSelectColor) {
            self.backgroundColor            = self.attribute.itemBgSelectColor;
        }
    } else {
        self->_itemTitleLabel.textColor = self.attribute.itemTitleColor;
        if (self.attribute.itemBgColor) {
            self.backgroundColor            = self.attribute.itemBgColor;
        }
    }
    self->_itemTitleLabel.text = self.dataModel.title;
    _select = select;
    [self setupItemImage];
}
@end


@implementation ZTTabbarItem(BadgeView)
- (void)showBadgeNumber:(NSInteger)badgeNumber{
    if (self->_badgeView == nil) {
        self->_badgeView = [[ZTTabbarItemBadgeView alloc]initWithBadgeNumber:badgeNumber];
        self->_badgeView.backgroundColor = self.attribute.itemBadgeColor;
        [self insertSubview:self->_badgeView aboveSubview:self->_itemImageView];
    }
    else {
        [self->_badgeView updateBadgeNumber:badgeNumber];
    }

    CGSize badgeSize = [[NSString stringWithFormat:@"%ld",badgeNumber] sizeWithAttributes:@{NSFontAttributeName:self->_badgeView.badgeNumberLabel.font}];
    CGFloat xOffset = 5;
    CGFloat yOffset = 1;
    if (badgeNumber>0&&badgeNumber<100) {
        badgeSize = CGSizeMake(MAX(badgeSize.width, badgeSize.height), MAX(badgeSize.width, badgeSize.height));
    }
    else if(badgeNumber<=0){
        badgeSize = CGSizeMake(5, 5);
    }
    CGFloat badgeX  = self->_itemImageView.zt_maxX - xOffset;
    CGFloat badgeY  = self->_itemImageView.zt_y - yOffset;
    self->_badgeView.frame = CGRectMake(badgeX, badgeY, badgeSize.width+5, badgeSize.height+5);
}
- (void)hiddenBadgeNumber {
    self->_badgeView.hidden = YES;
}
@end



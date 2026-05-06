//
//  LBTagView.m
//  LBTagsView
//
//  Created by luobbe on 16/1/12.
//  Copyright © 2016年 luobbe. All rights reserved.
//

#import "LBTagView.h"

static const CGFloat LBTagViewCircleDiameter = 6.0;
static const CGFloat LBTagViewCircleInset = 12.0;
static const CGFloat LBTagViewHorizontalPadding = 10.0;
static const CGFloat LBTagViewVerticalPadding = 5.0;
static const CGFloat LBTagViewPointerWidth = 10.0;
static NSString * const LBTagViewPulseAnimationKey = @"LBTagViewPulseAnimation";

@interface LBTagView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) CALayer *pulseLayer;
@property (nonatomic, assign) CGPoint lastTouchPoint;

@end

@implementation LBTagView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _canMove = YES;
    _text = @"";
    _direction = LBTagDirectionLeft;
    _textColor = [UIColor whiteColor];
    _font = [UIFont systemFontOfSize:12.0];
    _backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    _circleColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    _circleShadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];

    [super setBackgroundColor:[UIColor clearColor]];
    self.clipsToBounds = NO;

    [self.layer addSublayer:self.pulseLayer];
    [self addSubview:self.textLabel];
    [self addSubview:self.circleView];

    [self applyStyle];
    [self updateLayoutPreservingOrigin:YES];
    [self startPulseAnimation];
}

#pragma mark - Views

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 1;
    }
    return _textLabel;
}

- (UIView *)circleView
{
    if (!_circleView) {
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, LBTagViewCircleDiameter, LBTagViewCircleDiameter)];
        _circleView.layer.cornerRadius = LBTagViewCircleDiameter / 2.0;
        _circleView.layer.masksToBounds = YES;
        _circleView.userInteractionEnabled = NO;
    }
    return _circleView;
}

- (CALayer *)pulseLayer
{
    if (!_pulseLayer) {
        _pulseLayer = [CALayer layer];
        _pulseLayer.bounds = CGRectMake(0.0, 0.0, LBTagViewCircleDiameter, LBTagViewCircleDiameter);
        _pulseLayer.cornerRadius = LBTagViewCircleDiameter / 2.0;
    }
    return _pulseLayer;
}

#pragma mark - Public setters

- (void)setText:(NSString *)text
{
    _text = [text copy] ?: @"";
    self.textLabel.text = _text;
    [self updateLayoutPreservingOrigin:YES];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor ?: [UIColor whiteColor];
    self.textLabel.textColor = _textColor;
}

- (void)setDirection:(LBTagDirection)direction
{
    _direction = direction;
    [self updateLayoutPreservingOrigin:YES];
}

- (void)setFont:(UIFont *)font
{
    _font = font ?: [UIFont systemFontOfSize:12.0];
    self.textLabel.font = _font;
    [self updateLayoutPreservingOrigin:YES];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor ?: [UIColor clearColor];
    self.textLabel.backgroundColor = _backgroundColor;
}

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor ?: [UIColor clearColor];
    self.circleView.backgroundColor = _circleColor;
}

- (void)setCircleShadowColor:(UIColor *)circleShadowColor
{
    _circleShadowColor = circleShadowColor ?: [UIColor clearColor];
    self.pulseLayer.backgroundColor = _circleShadowColor.CGColor;
}

- (UIColor *)circlrColor
{
    return self.circleColor;
}

- (void)setCirclrColor:(UIColor *)circlrColor
{
    self.circleColor = circlrColor;
}

- (UIColor *)circlrShadowColor
{
    return self.circleShadowColor;
}

- (void)setCirclrShadowColor:(UIColor *)circlrShadowColor
{
    self.circleShadowColor = circlrShadowColor;
}

- (void)setTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (_tapGestureRecognizer == tapGestureRecognizer) {
        return;
    }

    if (_tapGestureRecognizer) {
        [self removeGestureRecognizer:_tapGestureRecognizer];
    }

    _tapGestureRecognizer = tapGestureRecognizer;

    if (_tapGestureRecognizer) {
        [self addGestureRecognizer:_tapGestureRecognizer];
    }
}

#pragma mark - Styling

- (void)applyStyle
{
    self.textLabel.text = self.text;
    self.textLabel.textColor = self.textColor;
    self.textLabel.font = self.font;
    self.textLabel.backgroundColor = self.backgroundColor;
    self.circleView.backgroundColor = self.circleColor;
    self.pulseLayer.backgroundColor = self.circleShadowColor.CGColor;
}

- (void)startPulseAnimation
{
    if ([self.pulseLayer animationForKey:LBTagViewPulseAnimationKey]) {
        return;
    }

    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = @0.5;
    fadeAnimation.toValue = @0.0;

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue = @5.0;

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[fadeAnimation, scaleAnimation];
    animationGroup.duration = 1.0;
    animationGroup.repeatCount = HUGE_VALF;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    [self.pulseLayer addAnimation:animationGroup forKey:LBTagViewPulseAnimationKey];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateMask];
}

- (void)updateLayoutPreservingOrigin:(BOOL)preserveOrigin
{
    CGSize textSize = [self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat labelWidth = ceil(textSize.width) + (2.0 * LBTagViewHorizontalPadding) + LBTagViewPointerWidth;
    CGFloat labelHeight = ceil(textSize.height) + (2.0 * LBTagViewVerticalPadding);
    labelHeight = MAX(labelHeight, LBTagViewCircleDiameter);

    CGRect frame = self.frame;
    frame.size = CGSizeMake(labelWidth + (2.0 * LBTagViewCircleInset), labelHeight);
    if (preserveOrigin) {
        self.frame = frame;
    } else {
        self.bounds = (CGRect){CGPointZero, frame.size};
    }

    CGFloat textX = self.direction == LBTagDirectionLeft ? 2.0 * LBTagViewCircleInset : 0.0;
    self.textLabel.frame = CGRectMake(textX, 0.0, labelWidth, labelHeight);

    CGFloat circleCenterX = self.direction == LBTagDirectionLeft ? LBTagViewCircleInset + (LBTagViewCircleDiameter / 2.0) : labelWidth + LBTagViewCircleInset + (LBTagViewCircleDiameter / 2.0);
    CGPoint circleCenter = CGPointMake(circleCenterX, labelHeight / 2.0);
    self.circleView.bounds = CGRectMake(0.0, 0.0, LBTagViewCircleDiameter, LBTagViewCircleDiameter);
    self.circleView.center = circleCenter;
    self.pulseLayer.bounds = CGRectMake(0.0, 0.0, LBTagViewCircleDiameter, LBTagViewCircleDiameter);
    self.pulseLayer.position = circleCenter;

    [self updateMask];
}

- (void)updateMask
{
    CGRect labelBounds = self.textLabel.bounds;
    if (CGRectIsEmpty(labelBounds)) {
        self.textLabel.layer.mask = nil;
        return;
    }

    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = CGRectGetWidth(labelBounds);
    CGFloat height = CGRectGetHeight(labelBounds);

    if (self.direction == LBTagDirectionRight) {
        [path moveToPoint:CGPointMake(0.0, 0.0)];
        [path addLineToPoint:CGPointMake(0.0, height)];
        [path addLineToPoint:CGPointMake(width - LBTagViewPointerWidth, height)];
        [path addLineToPoint:CGPointMake(width, height / 2.0)];
        [path addLineToPoint:CGPointMake(width - LBTagViewPointerWidth, 0.0)];
    } else {
        [path moveToPoint:CGPointMake(LBTagViewPointerWidth, 0.0)];
        [path addLineToPoint:CGPointMake(0.0, height / 2.0)];
        [path addLineToPoint:CGPointMake(LBTagViewPointerWidth, height)];
        [path addLineToPoint:CGPointMake(width, height)];
        [path addLineToPoint:CGPointMake(width, 0.0)];
    }
    [path closePath];

    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = labelBounds;
    mask.path = path.CGPath;
    self.textLabel.layer.mask = mask;
}

#pragma mark - Touch handling

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.canMove || touches.count > 1 || !self.superview) {
        [super touchesBegan:touches withEvent:event];
        return;
    }

    UITouch *touch = [touches anyObject];
    self.lastTouchPoint = [touch locationInView:self.superview];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.canMove || touches.count > 1 || !self.superview) {
        [super touchesMoved:touches withEvent:event];
        return;
    }

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    self.center = CGPointMake(self.center.x + point.x - self.lastTouchPoint.x,
                              self.center.y + point.y - self.lastTouchPoint.y);
    self.lastTouchPoint = point;
}

@end

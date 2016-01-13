//
//  LBTagView.m
//  LBTagsView
//
//  Created by luobbe on 16/1/12.
//  Copyright © 2016年 luobbe. All rights reserved.
//

#import "LBTagView.h"

@interface LBTagView ()
{
    CGPoint lastPoint;
}

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, assign) CGSize circleSize;//circle size

@property (nonatomic, strong) UIView *circleView;

@property (nonatomic, strong) CALayer *circleLayer;

@end

@implementation LBTagView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    //add subviews
    _circleSize = CGSizeMake(6, 6);
    _canMove= YES;
    [self addSubview:self.textLabel];
    [self creatCircleView];
    //default configeration
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:12];
    self.circlrColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    self.circlrShadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    
}

- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        //
        _textLabel = ({
            UILabel *testView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            testView.textAlignment = NSTextAlignmentCenter;
            [self triangle:testView];
            testView;
        });
    }
    return _textLabel;
}

- (void)triangle:(UILabel *)label
{
    [label.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CGFloat angleWidth = 10;
    UIBezierPath  * path =  [ UIBezierPath  new ];
    [path moveToPoint :( CGPoint ) { angleWidth ,  0 }];
    [path addLineToPoint :( CGPoint ) { 0, CGRectGetHeight(label.frame)/2.0}];
    [path addLineToPoint :( CGPoint ) { angleWidth, CGRectGetHeight(label.frame)}];
    [path addLineToPoint :( CGPoint ) { CGRectGetWidth(label.frame), CGRectGetHeight(label.frame)}];
    [path addLineToPoint :( CGPoint ) { CGRectGetWidth(label.frame), 0}];
    [path addLineToPoint :( CGPoint ) { angleWidth, 0}];
    //
    CAShapeLayer* mask = [CAShapeLayer layer];
    mask.path = path.CGPath ;
    label.layer.mask = mask;
}

- (void)creatCircleView
{   //circleLayer
    CGSize circleSize = _circleSize;
    _circleLayer =[CALayer new];
    _circleLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    _circleLayer.position = CGPointMake(circleSize.width/2, circleSize.height/2);
    _circleLayer.bounds = CGRectMake(0, 0, circleSize.width, circleSize.height);
    _circleLayer.cornerRadius = circleSize.width/2;
    [self.layer addSublayer:_circleLayer];
    //circleView
    _circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, circleSize.width, circleSize.height)];
    _circleView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    _circleView.layer.cornerRadius = _circleView.frame.size.width / 2;
    _circleView.layer.masksToBounds = YES;
    [self addSubview:_circleView];
    //
    _circleView.center = CGPointMake(10, CGRectGetHeight(self.frame)/2.0);
    _circleLayer.position = _circleView.center;
    
    [self circleAnimation:_circleLayer];
}


- (void)circleAnimation:(CALayer *)layer
{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.repeatCount = HUGE_VALF;
    [animationGroup setDuration:1];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.timingFunction = timingFunction;
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.5];
    fadeAnimation.toValue = [NSNumber numberWithFloat:0];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleAnimation.toValue = [NSNumber numberWithFloat:5];
    animationGroup.animations = [NSArray arrayWithObjects:fadeAnimation, scaleAnimation, nil];
    [layer addAnimation:animationGroup forKey:@"fadeAnimation"];
}

- (void)setText:(NSString *)text
{
    _text = text;
    _textLabel.text = _text;
    [_textLabel sizeToFit];
    //textLabel.frame
    CGRect rect = _textLabel.frame;
    rect.size.height += 10;
    rect.size.width += 30;
    _textLabel.frame = rect;
    [self triangle:_textLabel];
    [self handelFrameWithRect:rect];
}

//change frame
- (void)handelFrameWithRect:(CGRect)rect
{
    //self.frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width + 4 *_circleSize.width, rect.size.height);
    _circleView.center = ( CGPoint ) { 5 *_circleSize.width/2.0 ,  self.frame.size.height/2.0 };
    _circleLayer.position = _circleView.center;
    _textLabel.frame = CGRectMake(4 *_circleSize.width, 0, CGRectGetWidth(_textLabel.frame), CGRectGetHeight(_textLabel.frame));
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _textLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font
{
    _textLabel.font = font;
    [self setText:_textLabel.text];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    _textLabel.backgroundColor = backgroundColor;
}

- (void)setCirclrColor:(UIColor *)circlrColor
{
    _circlrColor = circlrColor;
    _circleView.backgroundColor = circlrColor;
}

- (void)setCirclrShadowColor:(UIColor *)circlrShadowColor
{
    _circlrShadowColor = circlrShadowColor;
    _circleLayer.backgroundColor = circlrShadowColor.CGColor;
}

- (void)setTapGestureRecognizer:(UITapGestureRecognizer *)tapGesture
{
    if ([tapGesture isKindOfClass:[UITapGestureRecognizer class]]) {
        _tapGestureRecognizer = tapGesture;
        [self addGestureRecognizer:tapGesture];
    }
}

#pragma mark ----touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_canMove) {
        return;
    }
    if (touches.count > 1) {
        return;
    }
    UITouch *touch = [touches anyObject];
    UIView *superView = self.superview;
    lastPoint = [touch locationInView:superView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_canMove) {
        return;
    }
    if (touches.count > 1) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    self.center = CGPointMake(self.center.x + point.x - lastPoint.x, self.center.y + point.y - lastPoint.y);
    lastPoint = point;
}

@end

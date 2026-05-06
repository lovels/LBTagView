//
//  LBTagView.h
//  LBTagsView
//
//  Created by luobbe on 16/1/12.
//  Copyright © 2016年 luobbe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LBTagDirection) {
    LBTagDirectionLeft,
    LBTagDirectionRight
};

@interface LBTagView : UIView

/// Controls whether the tag can be dragged inside its superview. Defaults to YES.
@property (nonatomic, assign) BOOL canMove;

/// Text displayed inside the tag.
@property (nonatomic, copy) NSString *text;

/// Text color. Defaults to white.
@property (nonatomic, strong) UIColor *textColor;

/// Direction of the pointer shape. Defaults to LBTagDirectionLeft.
@property (nonatomic, assign) LBTagDirection direction;

/// Text font. Defaults to system 12 pt.
@property (nonatomic, strong) UIFont *font;

/// Tag fill color. Defaults to translucent black.
@property (nonatomic, strong) UIColor *backgroundColor;

/// Inner circle color. Defaults to translucent white.
@property (nonatomic, strong) UIColor *circleColor;

/// Pulse circle color. Defaults to translucent black.
@property (nonatomic, strong) UIColor *circleShadowColor;

/// Inner circle color. Kept for source compatibility with earlier releases.
@property (nonatomic, strong) UIColor *circlrColor;

/// Pulse circle color. Kept for source compatibility with earlier releases.
@property (nonatomic, strong) UIColor *circlrShadowColor;

/// Tap recognizer attached to the tag. Replacing it removes the previous one.
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

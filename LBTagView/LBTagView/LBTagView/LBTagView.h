//
//  LBTagView.h
//  LBTagsView
//
//  Created by luobbe on 16/1/12.
//  Copyright © 2016年 luobbe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBTagView : UIView

//is can be moved
@property (nonatomic, assign) BOOL canMove;

//text
@property (nonatomic, copy) NSString *text;

//default [UIColor whiteColor]
@property (nonatomic, strong) UIColor *textColor;

//default [UIFont systemFontOfSize:12]
@property (nonatomic, strong) UIFont *font;

//default [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
@property (nonatomic, strong) UIColor *backgroundColor;

//default [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]
@property (nonatomic, strong) UIColor *circlrColor;

//default [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]
@property (nonatomic, strong) UIColor *circlrShadowColor;

//tap action
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

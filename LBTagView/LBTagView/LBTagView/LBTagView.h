//
//  LBTagView.h
//  LBTagsView
//
//  Created by luobbe on 16/1/12.
//  Copyright © 2016年 luobbe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBTagView : UIView

@property (nonatomic, assign) BOOL canMove; //can be moved

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIColor *textColor; //default [UIColor whiteColor]

@property (nonatomic, strong) UIFont *font; //default [UIFont systemFontOfSize:12]

@property (nonatomic, strong) UIColor *backgroundColor; //default [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]

@property (nonatomic, strong) UIColor *circlrColor; //default [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]

@property (nonatomic, strong) UIColor *circlrShadowColor; //default [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]

@end

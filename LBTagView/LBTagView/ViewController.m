//
//  ViewController.m
//  LBTagView
//
//  Created by luobbe on 16/1/12.
//  Copyright © 2016年 luobbe. All rights reserved.
//

#import "ViewController.h"
#import "LBTagView.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *tags;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.tags = [NSMutableArray array];
    NSArray *tagTitles = @[@"hello, I am a fixed tag view",
                           @"hello, I am a bigger tag view",
                           @"Tap me to change my appearance",
                           @"hello, I am a default tag view"];
    
    [tagTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        LBTagView *tagView = [[LBTagView alloc] initWithFrame:CGRectMake(20, 20 + 70 * idx, 0, 0)];
        tagView.text = title;
        [self.view addSubview:tagView];
        [self.tags addObject:tagView];
    }];

    LBTagView *tagView1 = self.tags[0];
    tagView1.backgroundColor = [UIColor orangeColor];
    tagView1.direction = LBTagDirectionRight;
    tagView1.canMove = NO;

    LBTagView *tagView2 = self.tags[1];
    tagView2.direction = LBTagDirectionLeft;
    tagView2.font = [UIFont systemFontOfSize:16];
    tagView2.backgroundColor = [UIColor purpleColor];
    tagView2.circleColor = [UIColor orangeColor];
    tagView2.circleShadowColor = [UIColor blackColor];

    LBTagView *tagView3 = self.tags[2];
    tagView3.direction = LBTagDirectionRight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTagViewStyle:)];
    tagView3.tapGestureRecognizer = tap;
}

- (void)changeTagViewStyle:(UITapGestureRecognizer *)tap
{
    LBTagView *tag = (LBTagView *)tap.view;
    UIColor *color = [UIColor colorWithRed:(arc4random_uniform(255))/255.0
                                     green:(arc4random_uniform(255))/255.0
                                      blue:(arc4random_uniform(255))/255.0
                                     alpha:0.7];
    tag.backgroundColor = color;
    tag.circleColor = color;
    tag.circleShadowColor = color;
    tag.direction = tag.direction == LBTagDirectionLeft ? LBTagDirectionRight : LBTagDirectionLeft;
}

@end

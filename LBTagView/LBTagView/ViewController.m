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
    // Do any additional setup after loading the view, typically from a nib.
    _tags = @[].mutableCopy;
    NSArray *array = @[@"hello,I am a tagView,I can't be moved!",
                       @"hello,I am bigger tagView",
                       @"Tap me to change my appearance",
                       @"hello,I am a default tagView"];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        LBTagView *tagView = [[LBTagView alloc] initWithFrame:CGRectMake(20, 20 + 70 * idx, 0, 0)];
        tagView.text = obj;
        [self.view addSubview:tagView];
        [_tags addObject:tagView];
    }];
    //one
    LBTagView *tagView1 = _tags[0];
    tagView1.backgroundColor = [UIColor orangeColor];
    tagView1.direction = LBTagDirectionRight;
    tagView1.canMove = NO;
    //two
    LBTagView *tagView2 = _tags[1];
    tagView2.direction = LBTagDirectionLeft;
    tagView2.font = [UIFont systemFontOfSize:16];
    tagView2.backgroundColor = [UIColor purpleColor];
    tagView2.circlrColor = [UIColor orangeColor];
    tagView2.circlrShadowColor = [UIColor blackColor];
    
    //three
    LBTagView *tagView3 = _tags[2];
    tagView3.direction = LBTagDirectionRight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTagViewStyle:)];
    tagView3.tapGestureRecognizer = tap;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeTagViewStyle:(UITapGestureRecognizer *)tap
{
    LBTagView *tag = (LBTagView *)tap.view;
    UIColor *color = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:0.7];
    tag.backgroundColor = color;
    tag.circlrColor = color;
    tag.circlrShadowColor = color;
    tag.backgroundColor =  color;
    //
    static int key = 0;
    key == 0 ? (tag.direction = LBTagDirectionLeft,key++) : (tag.direction = LBTagDirectionRight,key--)
    ;
}

@end

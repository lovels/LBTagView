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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *array = @[@"hello,I am tagView one",
                       @"hello,I am tagView two",
                       @"hello,I am tagView three",
                       @"hello,I am tagView four",
                       @"hello,I am tagView five",];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        LBTagView *tagView = [[LBTagView alloc] initWithFrame:CGRectMake(20, 20 + 70 * idx, 0, 0)];
        tagView.text = obj;
        [self.view addSubview:tagView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

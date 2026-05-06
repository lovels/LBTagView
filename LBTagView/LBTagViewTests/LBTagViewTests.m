//
//  LBTagViewTests.m
//  LBTagViewTests
//
//  Created by luobbe on 16/1/12.
//  Copyright © 2016年 luobbe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LBTagView.h"

@interface LBTagViewTests : XCTestCase

@end

@implementation LBTagViewTests

- (void)testDefaultConfiguration
{
    LBTagView *tagView = [[LBTagView alloc] initWithFrame:CGRectMake(10.0, 20.0, 0.0, 0.0)];

    XCTAssertTrue(tagView.canMove);
    XCTAssertEqualObjects(tagView.text, @"");
    XCTAssertEqual(tagView.direction, LBTagDirectionLeft);
    XCTAssertEqualWithAccuracy(tagView.font.pointSize, 12.0, 0.01);
    XCTAssertEqualObjects(tagView.textColor, [UIColor whiteColor]);
    XCTAssertEqualObjects(tagView.circleColor, tagView.circlrColor);
    XCTAssertEqualObjects(tagView.circleShadowColor, tagView.circlrShadowColor);
    XCTAssertEqualWithAccuracy(CGRectGetMinX(tagView.frame), 10.0, 0.01);
    XCTAssertEqualWithAccuracy(CGRectGetMinY(tagView.frame), 20.0, 0.01);
}

- (void)testTextAndFontResizeTheView
{
    LBTagView *tagView = [[LBTagView alloc] initWithFrame:CGRectZero];

    tagView.text = @"short";
    CGSize shortSize = tagView.frame.size;

    tagView.text = @"a much longer tag label";
    XCTAssertGreaterThan(CGRectGetWidth(tagView.frame), shortSize.width);
    XCTAssertEqualWithAccuracy(CGRectGetHeight(tagView.frame), shortSize.height, 0.01);

    tagView.font = [UIFont boldSystemFontOfSize:20.0];
    XCTAssertGreaterThan(CGRectGetHeight(tagView.frame), shortSize.height);
}

- (void)testDirectionChangePreservesViewSize
{
    LBTagView *tagView = [[LBTagView alloc] initWithFrame:CGRectZero];
    tagView.text = @"direction";

    CGSize leftSize = tagView.frame.size;
    tagView.direction = LBTagDirectionRight;

    XCTAssertEqual(tagView.direction, LBTagDirectionRight);
    XCTAssertEqualWithAccuracy(CGRectGetWidth(tagView.frame), leftSize.width, 0.01);
    XCTAssertEqualWithAccuracy(CGRectGetHeight(tagView.frame), leftSize.height, 0.01);
}

- (void)testColorAliasesRemainCompatible
{
    LBTagView *tagView = [[LBTagView alloc] initWithFrame:CGRectZero];
    UIColor *circleColor = [UIColor redColor];
    UIColor *shadowColor = [UIColor blueColor];

    tagView.circleColor = circleColor;
    tagView.circleShadowColor = shadowColor;

    XCTAssertEqualObjects(tagView.circlrColor, circleColor);
    XCTAssertEqualObjects(tagView.circlrShadowColor, shadowColor);

    tagView.circlrColor = [UIColor greenColor];
    tagView.circlrShadowColor = [UIColor blackColor];

    XCTAssertEqualObjects(tagView.circleColor, [UIColor greenColor]);
    XCTAssertEqualObjects(tagView.circleShadowColor, [UIColor blackColor]);
}

- (void)testReplacingTapGestureRecognizerRemovesTheOldRecognizer
{
    LBTagView *tagView = [[LBTagView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer alloc] init];
    UITapGestureRecognizer *secondTap = [[UITapGestureRecognizer alloc] init];

    tagView.tapGestureRecognizer = firstTap;
    XCTAssertTrue([tagView.gestureRecognizers containsObject:firstTap]);

    tagView.tapGestureRecognizer = secondTap;
    XCTAssertFalse([tagView.gestureRecognizers containsObject:firstTap]);
    XCTAssertTrue([tagView.gestureRecognizers containsObject:secondTap]);
}

@end

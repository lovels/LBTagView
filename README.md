# LBTagView

`LBTagView` is a small Objective-C view for adding draggable, pointer-style tags to images or other views.

![LBTagView demo][image-1]

## Features

- Left- or right-facing tag pointer
- Draggable by default, with a `canMove` switch for fixed labels
- Custom text, font, text color, tag color, circle color, and pulse color
- Tap gesture support for lightweight interactions
- Source-compatible aliases for the historical `circlrColor` and `circlrShadowColor` API names

## Requirements

- iOS 13.0 or later
- Xcode with Objective-C and ARC support

## Usage

```objc
#import "LBTagView.h"

LBTagView *tagView = [[LBTagView alloc] initWithFrame:CGRectMake(50.0, 300.0, 0.0, 0.0)];
tagView.text = @"hello world";
tagView.direction = LBTagDirectionLeft;
tagView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
[self.view addSubview:tagView];
```

## Customization

```objc
tagView.canMove = NO;
tagView.textColor = [UIColor whiteColor];
tagView.font = [UIFont systemFontOfSize:14.0];
tagView.circleColor = [UIColor whiteColor];
tagView.circleShadowColor = [UIColor blackColor];
tagView.direction = LBTagDirectionRight;

UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTagTap:)];
tagView.tapGestureRecognizer = tap;
```

The older `circlrColor` and `circlrShadowColor` properties still work for existing integrations. New code should prefer `circleColor` and `circleShadowColor`.

## Example App

Open `LBTagView/LBTagView.xcodeproj` and run the shared `LBTagView` scheme. The sample app shows fixed, draggable, left-facing, right-facing, and tappable tags.

## Verification

```sh
xcodebuild build-for-testing \
  -project LBTagView/LBTagView.xcodeproj \
  -scheme LBTagView \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/LBTagViewDerivedData \
  CODE_SIGNING_ALLOWED=NO
```

To execute the unit tests, use a concrete installed simulator:

```sh
xcodebuild test \
  -project LBTagView/LBTagView.xcodeproj \
  -scheme LBTagView \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -derivedDataPath /tmp/LBTagViewDerivedData
```

If your simulator name is different, replace the `-destination` value with one from:

```sh
xcodebuild -showdestinations -project LBTagView/LBTagView.xcodeproj -scheme LBTagView
```

## Maintainer Workflow

This repository is being prepared for more regular open-source maintenance. Good Codex tasks for this project include:

- reviewing pull requests that touch layout or gesture behavior
- adding regression tests for rendering and sizing edge cases
- modernizing distribution metadata while preserving Objective-C compatibility
- checking security or supply-chain changes before releases

## Contributing

Issues and pull requests are welcome. Please keep changes focused, preserve compatibility with the public Objective-C API, and include tests when behavior changes.

## License

LBTagView is available under the MIT license. See `LICENSE` for details.

[image-1]: http://ww3.sinaimg.cn/large/9f1201f5gw1f069256ryjg209y0ddtvd.gif

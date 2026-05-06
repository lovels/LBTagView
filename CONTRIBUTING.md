# Contributing to LBTagView

Thanks for helping maintain LBTagView.

## Pull Requests

- Keep each pull request focused on one behavior or maintenance task.
- Preserve the existing Objective-C public API unless the change is explicitly documented as a breaking change.
- Add or update tests for layout, styling, gesture, or compatibility behavior changes.
- Avoid committing Xcode user state, generated build output, or local dependency folders.

## Local Checks

```sh
xcodebuild build-for-testing \
  -project LBTagView/LBTagView.xcodeproj \
  -scheme LBTagView \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/LBTagViewDerivedData \
  CODE_SIGNING_ALLOWED=NO
```

Use `xcodebuild -showdestinations -project LBTagView/LBTagView.xcodeproj -scheme LBTagView` to find a concrete simulator when you want to run `xcodebuild test`.

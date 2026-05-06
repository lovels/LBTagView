# Repository Instructions

This is a small Objective-C iOS project. Keep changes focused and preserve source compatibility with existing `LBTagView` users.

## Project Layout

- `LBTagView/LBTagView/LBTagView/` contains the reusable view.
- `LBTagView/LBTagView/` contains the demo app.
- `LBTagView/LBTagViewTests/` contains unit tests.
- `LBTagView/LBTagView.xcodeproj/xcshareddata/xcschemes/LBTagView.xcscheme` is the shared scheme used for local and CI verification.

## Development Notes

- Prefer additive API improvements over breaking property or enum changes.
- Keep the misspelled `circlrColor` and `circlrShadowColor` properties working for compatibility.
- Do not commit `xcuserdata`, `DerivedData`, or user-specific Xcode state.
- Update README examples when the public API changes.

## Verification

Compile the app and test bundle with a writable derived data path:

```sh
xcodebuild build-for-testing \
  -project LBTagView/LBTagView.xcodeproj \
  -scheme LBTagView \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/LBTagViewDerivedData \
  CODE_SIGNING_ALLOWED=NO
```

Run `xcodebuild test` with a concrete installed simulator when one is available.

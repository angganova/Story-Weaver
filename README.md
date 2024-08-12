# Story Weaver

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Command
### Run file generator using build_runner command
##### One time and exit
```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

##### Continuous run
```
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

### Build android and iOS command

##### Android - APK File
```
flutter build apk --debug
```

##### Android - APK Analyze Size
```
flutter build apk --analyze-size --target-platform=android-arm64
```

##### iOS - IPA File
```
flutter build ios --release --no-codesign
```

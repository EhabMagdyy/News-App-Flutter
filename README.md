https://github.com/user-attachments/assets/5ce57e77-0fb4-4d51-bdc7-66b754b06345

---

## Allowing Internet Access on Android

To enable network access for your Android application, add the following permission to the `android/app/src/main/AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

---

## Building a Flutter APK

To generate an APK file for your Flutter project, use the following command:

```bash
flutter build apk --build-name=<version> --build-number=<number>
```

### Example

```bash
flutter build apk --build-name=1.0 --build-number=1
```

This will produce a release-ready APK file.

---

## Adding an App Icon

To add an app icon to your Flutter project, update the `pubspec.yaml` file with the following dependencies:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  flutter_launcher_icons: ^0.13.1

flutter_icons:
  android: true
  ios: true
  image_path: "assets/app_icon.png"
```

##### Generate Icons

Run the following commands to apply the app icon:

```bash
flutter pub get
dart run flutter_launcher_icons
```

---

## Updating the Application Name

### For Android

1. Open the `android/app/src/main/AndroidManifest.xml` file.
2. Locate the `<application>` tag and update the `android:label` attribute:

```xml
<application
    android:label="YourAppName"    <!-- Replace with your app's name -->
    android:icon="@mipmap/ic_launcher">
```

### For iOS

1. Open the `ios/Runner/Info.plist` file.
2. Locate the `<key>CFBundleName</key>` entry and update the value:

```xml
<key>CFBundleName</key>
<string>YourAppName</string>    <!-- Replace with your app's name -->
```

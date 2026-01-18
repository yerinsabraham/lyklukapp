# LykLuk Flutter Project - Complete Setup Guide

This guide contains all the exact versions, dependencies, and configurations needed to run the LykLuk app on your MacBook.

---

## 📋 Quick Version Reference

| Tool | Version | Notes |
|------|---------|-------|
| **Flutter** | 3.38.x (stable) | Currently using 3.38.3/3.38.7 |
| **Dart** | 3.10.x | Comes with Flutter |
| **Java/JDK** | 17 or 21 LTS | OpenJDK recommended |
| **Gradle** | 8.13 | Specified in gradle-wrapper.properties |
| **Android Gradle Plugin (AGP)** | 8.13.0 | In settings.gradle.kts |
| **Kotlin** | 2.1.0 | In settings.gradle.kts |
| **Xcode** | 16.x | For iOS development |
| **CocoaPods** | 1.16.x | For iOS dependencies |
| **Ruby** | 2.6+ or 3.x | For CocoaPods |

---

## 🛠️ Step-by-Step Setup

### 1. Install Flutter

**Option A: Using FVM (Recommended)**
```bash
# Install FVM
dart pub global activate fvm

# Install the required Flutter version
fvm install 3.38.7

# Use it in the project
cd mobile_app_v2
fvm use 3.38.7
```

**Option B: Direct Flutter Installation**
```bash
# Download Flutter from https://flutter.dev
# Extract and add to PATH
export PATH="$PATH:/path/to/flutter/bin"

# Verify
flutter --version
# Should show: Flutter 3.38.x
```

### 2. Install Java (JDK)

**Using Homebrew (Recommended):**
```bash
# Install OpenJDK 21 (LTS - recommended)
brew install openjdk@21

# Or OpenJDK 17 (LTS - also works)
brew install openjdk@17

# Add to PATH (for zsh)
echo 'export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Verify
java --version
# Should show: openjdk 21.x.x or 17.x.x
```

**Important:** Java 25 also works but LTS versions (17/21) are more stable.

### 3. Android Studio & SDK

```bash
# Install Android Studio from https://developer.android.com/studio

# Open Android Studio → Settings → SDK Manager
# Install:
# - Android SDK Platform 36 (Android 16)
# - Android SDK Platform 35 (Android 15)
# - Android SDK Build-Tools 36.0.0
# - Android SDK Command-line Tools
# - Android NDK 28.0.12433566

# Set environment variables in ~/.zshrc:
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
```

### 4. Xcode & iOS Tools

```bash
# Install Xcode from Mac App Store (version 16.x)

# Install command line tools
xcode-select --install

# Accept license
sudo xcodebuild -license accept

# Install CocoaPods
sudo gem install cocoapods
# Or with Homebrew:
brew install cocoapods

# Verify
pod --version
# Should show: 1.16.x
```

### 5. Clone and Setup Project

```bash
# Clone the repository
git clone https://github.com/lyklukdigital/mobile_app_v2.git
cd mobile_app_v2

# Checkout the main branch
git checkout mvp-official

# Get Flutter dependencies
flutter pub get

# iOS setup
cd ios
pod install --repo-update
cd ..

# Verify setup
flutter doctor
```

---

## 📁 Critical Configuration Files

### Android: `android/settings.gradle.kts`
```kotlin
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.13.0" apply false
    id("com.google.gms.google-services") version("4.3.15") apply false
    id("com.google.firebase.crashlytics") version("2.8.1") apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}
```

### Android: `android/gradle/wrapper/gradle-wrapper.properties`
```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-8.13-bin.zip
```

### Android: `android/gradle.properties`
```properties
org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m -XX:+HeapDumpOnOutOfMemoryError
android.useAndroidX=true
android.enableJetifier=true

# BytePlus SDK credentials
username=android_texas_test
password=dVl90zD5G5KUotUz

# Force compile SDK for all subprojects
android.defaults.compilesdk=36
android.defaults.targetsdk=35
```

### Android: `android/app/build.gradle.kts` (Key Settings)
```kotlin
android {
    namespace = "com.lykluk.lykluk"
    compileSdk = 36
    ndkVersion = "28.0.12433566"

    defaultConfig {
        applicationId = "com.lykluk.lykluk"
        minSdk = 26
        targetSdk = 35
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }
    kotlinOptions {
        jvmTarget = "11"
    }
}
```

### iOS: `ios/Podfile`
```ruby
platform :ios, '14.0'
```

### Flutter: `pubspec.yaml`
```yaml
environment:
  sdk: ^3.7.2
```

---

## 🔧 Common Issues & Solutions

### Issue 1: Gradle Sync Failed
**Error:** `Could not resolve com.android.tools.build:gradle:X.X.X`

**Solution:**
```bash
# Clean Gradle cache
cd android
./gradlew clean
rm -rf ~/.gradle/caches/
cd ..

# Rebuild
flutter clean
flutter pub get
flutter build apk
```

### Issue 2: AGP Version Mismatch
**Error:** `Android Gradle plugin requires Java 17 to run`

**Solution:**
```bash
# Install correct Java version
brew install openjdk@21

# Set JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
```

### Issue 3: Kotlin Version Conflict
**Error:** `Kotlin version mismatch`

**Solution:**
Ensure `settings.gradle.kts` has:
```kotlin
id("org.jetbrains.kotlin.android") version "2.1.0" apply false
```

### Issue 4: iOS Pod Install Failed
**Error:** `CocoaPods could not find compatible versions`

**Solution:**
```bash
cd ios
rm -rf Pods Podfile.lock
pod cache clean --all
pod install --repo-update
cd ..
```

### Issue 5: NDK Not Found
**Error:** `NDK not configured or wrong version`

**Solution:**
Install NDK 28.0.12433566 via Android Studio SDK Manager, or:
```bash
sdkmanager "ndk;28.0.12433566"
```

### Issue 6: BytePlus SDK Auth Failed
**Error:** `401 Unauthorized` when building Android

**Solution:**
Ensure `android/gradle.properties` has:
```properties
username=android_texas_test
password=dVl90zD5G5KUotUz
```

### Issue 7: Build Timeout / Out of Memory
**Error:** `GC overhead limit exceeded` or very slow build

**Solution:**
Ensure `android/gradle.properties` has:
```properties
org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m
```

---

## 🚀 Running the App

### Debug Mode
```bash
# iOS
flutter run -d <device_id>

# Android
flutter run -d <device_id>

# List available devices
flutter devices
```

### Release Mode
```bash
# iOS
flutter run --release

# Android
flutter run --release
```

### Building for Production
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## ✅ Verification Checklist

Run this to verify everything is set up correctly:

```bash
flutter doctor -v
```

You should see:
```
[✓] Flutter (Channel stable, 3.38.x)
[✓] Android toolchain - develop for Android devices (Android SDK version 36.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 16.x)
[✓] Chrome - develop for the web
[✓] Android Studio
[✓] VS Code
[✓] Connected device
[✓] Network resources
```

---

## 📞 Getting Help

If you still have issues after following this guide:

1. Run `flutter doctor -v` and share the output
2. Check the exact error message in the terminal
3. Make sure all versions match this guide exactly
4. Try `flutter clean && flutter pub get` first

---

## 📝 Version History

| Date | Flutter | AGP | Gradle | Notes |
|------|---------|-----|--------|-------|
| Jan 2026 | 3.38.7 | 8.13.0 | 8.13 | Current stable |
| Nov 2025 | 3.38.3 | 8.9.0 | 8.9 | Previous |

---

*Last Updated: January 18, 2026*

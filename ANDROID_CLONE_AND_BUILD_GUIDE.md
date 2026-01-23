# Android Clone & Build Guide for LykLuk

**Quick Start Guide for Developers Cloning This Repo**

Last Updated: January 23, 2026

---

## 📋 Prerequisites Checklist

Before cloning, ensure you have these installed:

| Requirement | Version | Command to Check |
|------------|---------|------------------|
| **Flutter** | 3.38.x (stable) | `flutter --version` |
| **Java/JDK** | 17 or 21 LTS | `java --version` |
| **Android Studio** | Latest (2024.x+) | Check in About |
| **Android SDK** | Platform 35-36 | SDK Manager |
| **Android NDK** | 27.0.12077973 | SDK Manager |
| **Git** | 2.x+ | `git --version` |

### Quick Install Commands (if missing):

```bash
# Install Flutter (using FVM - recommended)
dart pub global activate fvm
fvm install 3.38.7

# Install Java 21 (Windows)
# Download from: https://adoptium.net/temurin/releases/
# Or use Chocolatey: choco install openjdk21

# Install Android Studio
# Download from: https://developer.android.com/studio
```

---

## 🚀 Step-by-Step Build Instructions

### Step 1: Clone the Repository

```bash
# Clone the repo
git clone https://github.com/lyklukdigital/mobile_app_v2.git
cd mobile_app_v2

# Checkout the correct branch
git checkout mvp-official
```

### Step 2: Verify Critical Files Exist

**Check these files are present (they should be in version control):**

```bash
# Firebase config (REQUIRED)
android/app/google-services.json ✅

# BytePlus license (REQUIRED)
android/app/src/main/assets/License/lykluk_test_20251027_20260131_com.lykluk.lykluk_1.8.0_493.licbag ✅

# Gradle properties with BytePlus credentials (REQUIRED)
android/gradle.properties ✅
```

**If any are missing, STOP and contact the team.**

### Step 3: Install Flutter Dependencies

```bash
# Get all Flutter packages
flutter pub get

# This should complete without errors
# If you see errors, check your Flutter version first
```

### Step 4: Configure Android SDK & NDK

Open Android Studio → SDK Manager and install:

```
✅ Android SDK Platform 36 (API 36)
✅ Android SDK Platform 35 (API 35)  
✅ Android SDK Build-Tools 36.0.0
✅ Android NDK 27.0.12077973 (EXACT version - important!)
✅ Android SDK Command-line Tools
```

**Set Environment Variables (Windows):**

```powershell
# Add to System Environment Variables
ANDROID_HOME=C:\Users\<YourUsername>\AppData\Local\Android\Sdk
ANDROID_NDK_HOME=%ANDROID_HOME%\ndk\27.0.12077973

# Add to PATH
%ANDROID_HOME%\platform-tools
%ANDROID_HOME%\cmdline-tools\latest\bin
```

**Verify NDK Installation:**

```bash
# Should show path to NDK
echo $env:ANDROID_NDK_HOME

# Should exist
ls $env:ANDROID_HOME\ndk\27.0.12077973
```

### Step 5: Verify BytePlus Credentials

Check `android/gradle.properties` contains:

```properties
# BytePlus SDK credentials (should already be there)
username=android_texas_test
password=dVl90zD5G5KUotUz
```

**These are already in the repo - do NOT change them.**

### Step 6: Build Debug APK (First Test)

```bash
# Clean build
flutter clean

# Build debug APK (no signing required)
flutter build apk --debug

# Expected output:
# ✓ Built build/app/outputs/flutter-apk/app-debug.apk
```

**If this fails, see [Troubleshooting](#troubleshooting) section below.**

### Step 7: Run on Physical Device or Emulator

```bash
# Connect your Android phone via USB with USB debugging enabled
# OR start an Android emulator

# List available devices
flutter devices

# Run the app
flutter run

# Or run in release mode (requires signing - see Step 8)
flutter run --release
```

### Step 8: Release Build Setup (Optional)

**For debug builds, SKIP THIS.**

For release builds, you need a signing key. The team should provide:

1. `key.properties` file → Place in `android/` folder
2. Keystore file (`.jks` or `.keystore`) → Place where `key.properties` references it

**Example `key.properties`:**
```properties
storePassword=<provided-by-team>
keyPassword=<provided-by-team>
keyAlias=<provided-by-team>
storeFile=<path-to-keystore>
```

**Then build release:**
```bash
flutter build apk --release
# OR
flutter build appbundle --release
```

---

## 🔧 Troubleshooting

### Error 1: "Failed to download BytePlus SDK"

**Symptoms:**
```
Could not resolve com.bytedance.ies.effectone:effect-sdk-base:1.8.0.493
```

**Solution:**
```bash
# 1. Verify gradle.properties has BytePlus credentials
cat android/gradle.properties | grep username

# 2. Clear Gradle cache
cd android
./gradlew clean --refresh-dependencies
cd ..

# 3. Rebuild
flutter clean
flutter pub get
flutter build apk --debug
```

### Error 2: "NDK not configured"

**Symptoms:**
```
No version of NDK matched the requested version
```

**Solution:**
```bash
# Install EXACT NDK version via Android Studio SDK Manager
# OR via command line:
sdkmanager "ndk;27.0.12077973"

# Verify installation
ls $env:ANDROID_HOME\ndk\27.0.12077973
```

### Error 3: "Java version mismatch"

**Symptoms:**
```
Android Gradle plugin requires Java 17 to run
```

**Solution:**
```bash
# Check current Java version
java --version

# If wrong version, install Java 21 from:
# https://adoptium.net/temurin/releases/

# Set JAVA_HOME (Windows - System Environment Variables)
JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-21.x.x

# Restart terminal and verify
java --version
```

### Error 4: "Gradle sync failed"

**Symptoms:**
```
Could not resolve all dependencies
```

**Solution:**
```powershell
# Clear all Gradle caches
cd android
./gradlew clean
Remove-Item -Recurse -Force ~/.gradle/caches/
cd ..

# Clean Flutter
flutter clean
flutter pub get

# Try again
flutter build apk --debug
```

### Error 5: "License not found or invalid"

**Symptoms:**
```
BytePlus license error / License validation failed
```

**Solution:**
```bash
# Verify license file exists
ls android/app/src/main/assets/License/

# Should show:
# lykluk_test_20251027_20260131_com.lykluk.lykluk_1.8.0_493.licbag

# If missing, contact team for license file
# License expires: January 31, 2026
```

### Error 6: "Out of memory / Build timeout"

**Symptoms:**
```
GC overhead limit exceeded
Gradle build daemon disappeared unexpectedly
```

**Solution:**
```bash
# Increase Gradle memory in android/gradle.properties
# Should already have:
org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m

# If build still fails, close Android Studio and other apps
# Then retry
```

### Error 7: "google-services.json not found"

**Symptoms:**
```
File google-services.json is missing
```

**Solution:**
```bash
# This file SHOULD be in the repo
# Verify it exists:
ls android/app/google-services.json

# If missing, contact team immediately
# App cannot run without Firebase config
```

### Error 8: "Execution failed for task :app:mergeDebugNativeLibs"

**Symptoms:**
```
Error while merging native libraries
```

**Solution:**
```bash
# This is usually NDK version mismatch
# Ensure EXACT version: 27.0.12077973

# Check android/build.gradle.kts has:
ndkVersion = "27.0.12077973"

# Reinstall NDK if needed
sdkmanager --uninstall "ndk;27.0.12077973"
sdkmanager "ndk;27.0.12077973"
```

---

## ✅ Verification Checklist

After setup, verify everything works:

```bash
# 1. Check Flutter environment
flutter doctor -v
# Should show all green checkmarks for Android

# 2. Check Gradle versions
cd android
./gradlew --version
cd ..
# Should show Gradle 8.13

# 3. List devices
flutter devices
# Should show your connected device or emulator

# 4. Build debug (should succeed)
flutter build apk --debug
# Should complete in 3-10 minutes on first build

# 5. Run app
flutter run
# App should launch and show login screen
```

**Expected First Build Time:**
- **First build:** 5-10 minutes (downloading dependencies)
- **Subsequent builds:** 1-3 minutes

---

## 🎯 Quick Build Commands Reference

```bash
# DEBUG BUILD (no signing needed)
flutter build apk --debug
flutter run --debug

# RELEASE BUILD (requires signing key)
flutter build apk --release
flutter build appbundle --release

# CLEAN BUILD (when errors occur)
flutter clean
flutter pub get
flutter build apk --debug

# GRADLE CLEAN (deeper clean)
cd android
./gradlew clean --refresh-dependencies
cd ..
```

---

## 📱 Testing on Your Device

### Enable USB Debugging (Android Phone)

1. Go to **Settings → About Phone**
2. Tap **Build Number** 7 times (enables Developer Options)
3. Go to **Settings → Developer Options**
4. Enable **USB Debugging**
5. Connect phone via USB
6. Approve the "Allow USB Debugging?" prompt on phone

### Verify Connection

```bash
# Should show your device
flutter devices

# Should show device name and ID
adb devices
```

---

## 🔍 Expected Build Output

**Successful Debug Build:**
```
Running Gradle task 'assembleDebug'...
✓ Built build/app/outputs/flutter-apk/app-debug.apk (123.4MB)
```

**Successful App Launch:**
```
Launching lib/main.dart on <device> in debug mode...
Running Gradle task 'assembleDebug'...
✓ Built build/app/outputs/flutter-apk/app-debug.apk
Installing build/app/outputs/flutter-apk/app-debug.apk...
Debug service listening on ws://127.0.0.1:xxxxx
Synced 0.0MB
```

---

## 🆘 Still Having Issues?

If you still can't build after following this guide:

1. **Run diagnostic:**
   ```bash
   flutter doctor -v > flutter_doctor_output.txt
   ```

2. **Check exact error:**
   ```bash
   flutter build apk --debug --verbose > build_output.txt 2>&1
   ```

3. **Share these files with the team:**
   - `flutter_doctor_output.txt`
   - `build_output.txt`
   - Your OS version
   - Your Android Studio version

4. **Common quick fixes:**
   ```bash
   # Nuclear option - clean everything
   flutter clean
   cd android
   ./gradlew clean
   rm -rf .gradle
   rm -rf ~/.gradle/caches
   cd ..
   flutter pub get
   flutter build apk --debug
   ```

---

## 📚 Additional Resources

- **Full Setup Guide:** [docs/PROJECT_SETUP_GUIDE.md](docs/PROJECT_SETUP_GUIDE.md)
- **Release Signing:** [docs/ANDROID_RELEASE_SIGNING.md](docs/ANDROID_RELEASE_SIGNING.md)
- **BytePlus Integration:** [docs/ANDROID_BYTEPLUS_FILTER_INTEGRATION_GUIDE.md](docs/ANDROID_BYTEPLUS_FILTER_INTEGRATION_GUIDE.md)
- **Copilot Instructions:** [.github/copilot-instructions.md](.github/copilot-instructions.md)

---

## 🎉 Success Criteria

You're ready to develop when:

- ✅ `flutter doctor` shows no errors for Android
- ✅ `flutter build apk --debug` completes successfully
- ✅ `flutter run` launches the app on your device/emulator
- ✅ App shows login screen without crashes
- ✅ You can record a video using the camera (BytePlus SDK working)

---

**Questions?** Contact the LykLuk development team.

**License Expiry:** BytePlus license expires **January 31, 2026** - contact team for renewal if building after this date.

# 🍎 iOS BytePlus Integration Guide
**Complete Setup for Lykluk iOS App with BytePlus Video Editor**

---

## 📌 OVERVIEW

This guide will help you integrate BytePlus SDK into the iOS app so it works **EXACTLY** like the Android version - with filters, effects, stickers, and all BytePlus features.

**What You'll Get:**
- ✅ BytePlus camera with filters/effects (like Android)
- ✅ BytePlus video editor from gallery (like Android)
- ✅ Same user experience as Android app
- ✅ Full feature parity

---

## 🚀 STEP 1: PULL LATEST CODE & CLEAN

First, get the latest code and clear all caches:

```bash
# Navigate to project
cd ~/lyklukapp  # Or wherever your project is

# Pull latest code from mvp-official branch
git fetch origin
git checkout mvp-official
git pull origin mvp-official

# IMPORTANT: Reset any local changes that might conflict
git reset --hard origin/mvp-official

# Clean all caches and build artifacts
flutter clean
cd ios
rm -rf Pods Podfile.lock build
pod install
cd ..
flutter pub get
```

**Why this matters:** This ensures you have the exact code structure that's ready for BytePlus integration, with no conflicting files.

---

## 🔽 STEP 2: DOWNLOAD BYTEPLUS SDK

### Download Link:
**🔗 https://bytedance.sg.larkoffice.com/wiki/UMxUwBZVoiZBi0kVP5FcmSXBn0e**

### What to Download:
- Download the **iOS SDK** package
- You'll get a ZIP file containing:
  - `EffectOneKit.xcframework` (this is the main SDK)
  - Documentation
  - Sample project (optional reference)
  - License file (`.licbag`)

### Where to Save:
- Extract the ZIP to your Downloads folder
- You should see: `EffectOneKit.xcframework`

---

## 📦 STEP 3: ADD SDK TO PROJECT

### 3.1: Copy SDK Framework

```bash
# Copy the framework to your iOS folder
# Replace ~/Downloads/EffectOneKit.xcframework with your actual path
cp -r ~/Downloads/EffectOneKit.xcframework ~/lyklukapp/ios/
```

### 3.2: Open Project in Xcode

```bash
cd ~/lyklukapp
open ios/Runner.xcworkspace  # IMPORTANT: Open .xcworkspace, NOT .xcodeproj
```

### 3.3: Add Framework to Xcode

**In Xcode:**

1. **In Project Navigator** (left sidebar):
   - Right-click on "Runner" folder
   - Select "Add Files to Runner..."
   - Navigate to `ios/EffectOneKit.xcframework`
   - ✅ Check "Copy items if needed"
   - ✅ Select "Runner" in "Add to targets"
   - Click "Add"

2. **Configure Framework Embedding:**
   - Click "Runner" project (blue icon at top of navigator)
   - Select "Runner" target (under TARGETS)
   - Go to "General" tab
   - Scroll to "Frameworks, Libraries, and Embedded Content" section
   - Find `EffectOneKit.xcframework` in the list
   - **CRITICAL:** Change dropdown from "Do Not Embed" to **"Embed & Sign"**

3. **Verify:**
   - You should see `EffectOneKit.xcframework` listed with "Embed & Sign"

---

## 📝 STEP 4: UPDATE iOS CODE

The code structure is already in place, you just need to enable BytePlus SDK usage.

### 4.1: Update BytePlusHelper.swift

**File:** `ios/Runner/BytePlusHelper.swift`

**Add BytePlus import at the top:**

```swift
import UIKit
import Foundation
import Photos
import AVFoundation
import MobileCoreServices
import UniformTypeIdentifiers
import EffectOneKit  // ADD THIS LINE
```

**Find the comment that says:**
```swift
/// NOTE: This is a simplified iOS implementation that uses UIImagePickerController
```

**Below that comment block, add SDK initialization:**

```swift
// MARK: - BytePlus SDK Configuration
private var isSDKInitialized = false

func initializeSDK() {
    guard !isSDKInitialized else { return }
    
    print("🎬 [iOS] Initializing BytePlus SDK...")
    
    // 1. Set license path (update license filename if different)
    let licensePath = Bundle.main.path(forResource: "BPVod", ofType: "lic")
    
    guard let path = licensePath else {
        print("🎬 [iOS] ERROR: License file not found!")
        return
    }
    
    // 2. Initialize SDK
    EOConfiguration.shared().setLicensePath(path)
    
    // 3. Set resource path
    if let resourcePath = Bundle.main.path(forResource: "EOLocalResources", ofType: "bundle") {
        EOConfiguration.shared().setResourcePath(resourcePath)
    }
    
    isSDKInitialized = true
    print("🎬 [iOS] BytePlus SDK initialized successfully!")
}
```

**Replace the `startRecorder` method:**

Find:
```swift
func startRecorder(from viewController: UIViewController, result: @escaping FlutterResult) {
```

Replace the ENTIRE method with:

```swift
func startRecorder(from viewController: UIViewController, result: @escaping FlutterResult) {
    print("🎬 [iOS] startRecorder called")
    self.pendingResult = result
    self.presentingViewController = viewController
    
    // Initialize SDK if not done yet
    initializeSDK()
    
    checkCameraPermission { [weak self] granted in
        guard granted, let self = self else {
            result(FlutterError(code: "PERMISSION_DENIED", 
                              message: "Camera permission denied", 
                              details: nil))
            return
        }
        
        DispatchQueue.main.async {
            // Create BytePlus recorder configuration
            let config = EORecorderViewControllerConfig()
            config.maxDuration = 60.0  // 60 seconds max
            
            // Create recorder
            let recorder = EORecorderViewController(config: config)
            recorder.completion = { [weak self] result in
                guard let self = self else { return }
                
                if let videoPath = result?.outputPath {
                    print("🎬 [iOS] Recording finished: \(videoPath)")
                    self.pendingResult?(videoPath)
                } else {
                    print("🎬 [iOS] Recording cancelled")
                    self.pendingResult?(nil)
                }
                
                self.pendingResult = nil
                viewController.dismiss(animated: true)
            }
            
            print("🎬 [iOS] Presenting BytePlus recorder")
            viewController.present(recorder, animated: true)
        }
    }
}
```

**Replace the `startEditorFromAlbum` method:**

Find:
```swift
func startEditorFromAlbum(from viewController: UIViewController, result: @escaping FlutterResult) {
```

Replace the ENTIRE method with:

```swift
func startEditorFromAlbum(from viewController: UIViewController, result: @escaping FlutterResult) {
    print("🎬 [iOS] startEditorFromAlbum called")
    self.pendingResult = result
    self.presentingViewController = viewController
    
    // Initialize SDK if not done yet
    initializeSDK()
    
    checkPhotoLibraryPermission { [weak self] granted in
        guard granted, let self = self else {
            result(FlutterError(code: "PERMISSION_DENIED", 
                              message: "Photo library permission denied", 
                              details: nil))
            return
        }
        
        DispatchQueue.main.async {
            // Create BytePlus editor configuration
            let config = EOVideoEditorViewControllerConfig()
            
            // Create editor
            let editor = EOVideoEditorViewController(config: config)
            editor.completion = { [weak self] result in
                guard let self = self else { return }
                
                if let videoPath = result?.outputPath {
                    print("🎬 [iOS] Editing finished: \(videoPath)")
                    self.pendingResult?(videoPath)
                } else {
                    print("🎬 [iOS] Editing cancelled")
                    self.pendingResult?(nil)
                }
                
                self.pendingResult = nil
                viewController.dismiss(animated: true)
            }
            
            print("🎬 [iOS] Presenting BytePlus editor")
            viewController.present(editor, animated: true)
        }
    }
}
```

### 4.2: Update AppDelegate.swift

**File:** `ios/Runner/AppDelegate.swift`

**Find the `application(_:didFinishLaunchingWithOptions:)` method and add SDK initialization:**

```swift
override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    
    // Initialize BytePlus SDK
    BytePlusHelper.shared.initializeSDK()  // ADD THIS LINE
    
    // Setup MethodChannel
    if let controller = window?.rootViewController as? FlutterViewController {
        setupMethodChannel(controller: controller)
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
```

---

## 🧪 STEP 5: BUILD AND TEST

### 5.1: Clean Build

```bash
flutter clean
cd ios
rm -rf build Pods Podfile.lock
pod install
cd ..
flutter pub get
```

### 5.2: Build for iOS

**IMPORTANT:** BytePlus SDK only works properly in **release mode** (not debug).

```bash
# Build in release mode
flutter build ios --release

# OR run directly on connected iPhone:
flutter run --release
```

### 5.3: Test Checklist

Run the app on a **real iPhone** (simulator won't work for camera):

- [ ] ✅ App launches without crashes
- [ ] ✅ Tap **+ button** → BytePlus camera opens (NOT native camera)
- [ ] ✅ Camera shows BytePlus interface with filters
- [ ] ✅ Can apply filters, effects, stickers
- [ ] ✅ Can record video with effects
- [ ] ✅ Video saves and returns to app
- [ ] ✅ Gallery button opens photo library
- [ ] ✅ Selecting video opens BytePlus editor
- [ ] ✅ Can edit existing videos
- [ ] ✅ Export works and returns to app

### 5.4: Check Logs

In Xcode console, look for these messages:

```
🎬 [iOS] Initializing BytePlus SDK...
🎬 [iOS] BytePlus SDK initialized successfully!
🎬 [iOS] startRecorder called
🎬 [iOS] Presenting BytePlus recorder
🎬 [iOS] Recording finished: /path/to/video.mp4
```

---

## ✅ SUCCESS CRITERIA

Your integration is complete when:

1. **Feature Parity with Android:**
   - iOS app has same camera interface as Android
   - Same filters, effects, stickers available
   - Same editing capabilities

2. **No Crashes:**
   - App builds without errors
   - Camera/gallery open without crashes
   - Video recording/editing complete successfully

3. **Performance:**
   - Smooth camera preview (30+ fps)
   - Real-time filter application
   - Fast video export (< 10 seconds for 1 minute video)

---

## 🐛 TROUBLESHOOTING

### Issue: "Module 'EffectOneKit' not found"

**Solution:**
1. Verify framework is in `ios/EffectOneKit.xcframework`
2. In Xcode, check it's set to "Embed & Sign"
3. Clean build: `Product` → `Clean Build Folder` in Xcode
4. Run: `cd ios && pod install && cd ..`

### Issue: "License verification failed"

**Solution:**
1. Check `BPVod.lic` file exists in `assets/` folder
2. Verify license filename in code matches actual filename
3. Request new license from BytePlus if expired

### Issue: App crashes when opening camera

**Solution:**
1. **MUST test in release mode** (not debug)
2. Run: `flutter run --release`
3. Check Xcode console for error messages
4. Verify all permissions in `Info.plist` are present

### Issue: Native camera opens instead of BytePlus camera

**Solution:**
- You didn't update the code correctly
- Re-check Step 4 and ensure you replaced ENTIRE methods
- The old code uses `UIImagePickerController` (native)
- New code uses `EORecorderViewController` (BytePlus)

### Issue: "Slow performance / laggy camera"

**Solution:**
- BytePlus SDK is SLOW in debug mode
- **ALWAYS test in release mode:**
  ```bash
  flutter run --release
  ```
- Debug mode is 10-100x slower for video processing

### Issue: Resources not loading / No filters available

**Solution:**
1. Verify `EOLocalResources.bundle` exists in `ios/` folder
2. In Xcode, check it's added to "Copy Bundle Resources"
3. Check internet connection (first launch downloads resources)

---

## 📋 VERIFICATION SCRIPT

Run this script to verify everything is in place:

```bash
#!/bin/bash
echo "🔍 Verifying BytePlus iOS Integration..."
echo ""

# Check SDK framework
if [ -d "ios/EffectOneKit.xcframework" ]; then
    echo "✅ EffectOneKit.xcframework found"
else
    echo "❌ EffectOneKit.xcframework MISSING"
fi

# Check resources bundle
if [ -d "ios/EOLocalResources.bundle" ]; then
    echo "✅ EOLocalResources.bundle found"
else
    echo "⚠️ EOLocalResources.bundle missing (optional)"
fi

# Check license file
if [ -f "assets/BPVod.lic" ]; then
    echo "✅ License file found"
else
    echo "❌ License file MISSING"
fi

# Check BytePlusHelper.swift for SDK import
if grep -q "import EffectOneKit" ios/Runner/BytePlusHelper.swift; then
    echo "✅ BytePlusHelper.swift has SDK import"
else
    echo "❌ BytePlusHelper.swift needs SDK import"
fi

# Check for EORecorderViewController usage
if grep -q "EORecorderViewController" ios/Runner/BytePlusHelper.swift; then
    echo "✅ Using BytePlus recorder (not native camera)"
else
    echo "❌ Still using native camera - update code!"
fi

echo ""
echo "📝 Next steps:"
echo "1. Fix any ❌ items above"
echo "2. Build: flutter run --release"
echo "3. Test on real iPhone"
```

Save as `verify_ios_byteplus.sh` and run: `bash verify_ios_byteplus.sh`

---

## 🔄 COMPARISON WITH ANDROID

Your iOS implementation should mirror the Android structure:

| Component | Android | iOS |
|-----------|---------|-----|
| **SDK Location** | `android/app/libs/` | `ios/EffectOneKit.xcframework` |
| **Initialization** | `EOQuickInitHelper.kt` | `BytePlusHelper.swift` |
| **Camera** | `EORecorder` | `EORecorderViewController` |
| **Editor** | `EOVideoEditor` | `EOVideoEditorViewController` |
| **MethodChannel** | `MainActivity.kt` | `AppDelegate.swift` |
| **License** | `assets/BPVod.lic` | `assets/BPVod.lic` |

Both should provide:
- ✅ Same filters and effects
- ✅ Same stickers
- ✅ Same editing capabilities
- ✅ Same user experience

---

## 📚 ADDITIONAL RESOURCES

### Android Reference Files
Compare your iOS implementation with Android:
- `android/app/src/main/kotlin/com/lykluk/lykluk/EOQuickInitHelper.kt`
- `android/app/src/main/kotlin/com/lykluk/lykluk/MainActivity.kt`

### BytePlus Documentation
- SDK Download: https://bytedance.sg.larkoffice.com/wiki/UMxUwBZVoiZBi0kVP5FcmSXBn0e
- Official Docs: Check downloaded SDK package for documentation

### Testing on Mac
- **MacBook Required:** iOS builds only work on Mac
- **Xcode Required:** Latest version from App Store
- **Apple Developer Account:** For code signing
- **Physical iPhone:** Camera testing requires real device

---

## 📞 SUPPORT

### If You Get Stuck

1. **Check logs:** Look for 🎬 emoji in Xcode console
2. **Verify steps:** Re-read this guide carefully
3. **Common mistakes:**
   - Testing in debug mode (use release!)
   - Forgot to set "Embed & Sign"
   - Didn't update code (still using native camera)
   - Missing license file

### Report Issues

When reporting problems, include:
- [ ] Xcode console logs (search for 🎬 and ERROR)
- [ ] Which step failed
- [ ] Error messages
- [ ] Screenshots if applicable

---

## 🎯 FINAL NOTES

### Why This Setup?

- **SDK Not in Git:** Binary files (~200MB) would bloat repository
- **`.gitignore` Added:** SDK excluded from version control
- **Download Separately:** Each dev downloads SDK once
- **Code Ready:** All integration code is already in place

### After Successful Integration

1. **Commit your changes:**
   ```bash
   git add ios/Runner/BytePlusHelper.swift
   git add ios/Runner/AppDelegate.swift
   git commit -m "feat: Enable BytePlus SDK for iOS"
   git push origin mvp-official
   ```

2. **Document for team:**
   - SDK must be downloaded separately
   - Link: https://bytedance.sg.larkoffice.com/wiki/UMxUwBZVoiZBi0kVP5FcmSXBn0e

3. **Test thoroughly:**
   - Test all filters
   - Test all effects
   - Test video export
   - Compare with Android app

---

**Last Updated:** November 21, 2025  
**Status:** Ready for integration  
**iOS SDK Version:** EffectOneKit 1.8.0+  
**Matches Android:** Yes ✅

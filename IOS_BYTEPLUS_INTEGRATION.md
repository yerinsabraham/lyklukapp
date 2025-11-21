# iOS BytePlus Integration Guide

## Overview

This guide will help you integrate the BytePlus EffectOne SDK into the iOS version of the app, enabling video recording with filters, effects, and stickers (matching the Android version).

**What you'll get:**
- ✅ BytePlus camera with filters and effects
- ✅ Video editing capabilities
- ✅ Stickers and beauty effects
- ✅ Feature parity with Android app

**Important:** This guide is based on the actual BytePlus iOS SDK v1.8.0.1 API. The code has been verified against the official sample project.

---

## Step 1: Pull Latest Code & Clean

```bash
cd ~/dev/mobile_app_v2
git pull origin mvp-official
flutter clean
cd ios
pod install
```

---

## Step 2: Download BytePlus SDK

1. Download the SDK from: https://bytedance.sg.larkoffice.com/wiki/UMxUwBZVoiZBi0kVP5FcmSXBn0e
2. Extract the downloaded file
3. Locate `EffectOneKit.xcframework` in the extracted folder
4. Copy `EffectOneKit.xcframework` to `ios/` folder in the project:

```bash
# From your downloads folder
cp -r ~/Downloads/EffecOne-iOS-Sample-V1.8.0.1/EffectOneKit.xcframework ~/dev/mobile_app_v2/ios/
```

**Note:** The framework is ~200MB and is excluded from git tracking (in .gitignore).

---

## Step 3: Add SDK to Xcode Project

1. Open the project in Xcode:
   ```bash
   cd ios
   open Runner.xcworkspace
   ```

2. In Xcode's Project Navigator:
   - Select the **Runner** project (top item)
   - Select the **Runner** target
   - Go to **General** tab
   - Scroll to **Frameworks, Libraries, and Embedded Content**

3. Click the **+** button

4. Click **Add Other** → **Add Files...**

5. Navigate to your project's `ios/` folder

6. Select `EffectOneKit.xcframework`

7. **CRITICAL:** In the "Embed" column, select **"Embed & Sign"** (not "Do Not Embed")

8. Click **Add**

9. Verify the framework appears in the list with "Embed & Sign"

---

## Step 4: Update iOS Code

### 4.1 Update `ios/Runner/BytePlusHelper.swift`

**⚠️ IMPORTANT:** Replace the ENTIRE file content with this correct implementation:

```swift
import UIKit
import Foundation
import Photos
import AVFoundation
import EffectOneKit  // BytePlus SDK

class BytePlusHelper: NSObject {
    
    // MARK: - Properties
    private var pendingResult: FlutterResult?
    private var presentingViewController: UIViewController?
    private var isAuthSucceeded: Bool = false
    
    // MARK: - Singleton
    static let shared = BytePlusHelper()
    
    private override init() {
        super.init()
        print("🎬 [iOS BytePlus] Helper initialized")
    }
    
    // MARK: - SDK Initialization
    func initializeSDK() {
        print("🎬 [iOS BytePlus] Initializing SDK...")
        
        // License file path
        guard let licensePath = Bundle.main.path(forResource: "com.volcengine.effectone.inhouse", ofType: "licbag", inDirectory: "License") else {
            print("🎬 [iOS BytePlus] ERROR: License file not found")
            return
        }
        
        // Authenticate
        EOLicense.checkLicense(withPath: licensePath) { [weak self] success, errMsg in
            if !success {
                print("🎬 [iOS BytePlus] Authentication failed: \(errMsg)")
            } else {
                print("🎬 [iOS BytePlus] Authentication successful, initializing resources...")
                self?.isAuthSucceeded = true
                
                // Initialize SDK and resources
                EOSDK.initSDK {
                    // Set resource paths
                    EOSDK.setResourceBaseDir(EOSDK.getEODocumentRootDir() + "/download")
                    
                    // Get local bundle
                    if let bundlePath = Bundle.main.path(forResource: "EOLocalResources", ofType: "bundle"),
                       let bundle = Bundle(path: bundlePath) {
                        EOSDK.setResourceDefaultBuiltInConfig(EOSDK.defaultPanelConfigDir(bundle.bundlePath))
                        EOSDK.setBuiltInResourceDir(EOSDK.defaultResourceDir(bundle.bundlePath))
                    }
                    
                    // Enable remote config
                    EOSDK.useRemoteConfig(true, useRemoteResource: true)
                    
                    print("🎬 [iOS BytePlus] SDK initialization complete")
                }
            }
        }
    }
    
    // MARK: - Start Recorder (Camera)
    func startRecorder(from viewController: UIViewController, result: @escaping FlutterResult) {
        print("🎬 [iOS BytePlus] Starting recorder (camera)...")
        
        guard isAuthSucceeded else {
            print("🎬 [iOS BytePlus] ERROR: SDK not authenticated")
            result(FlutterError(code: "NOT_AUTHENTICATED", message: "BytePlus SDK not authenticated", details: nil))
            return
        }
        
        self.pendingResult = result
        self.presentingViewController = viewController
        
        // Create recorder config
        let config = EORecorderConfig { initializer in
            initializer.configRecorderViewController { recorderVCInitializer in
                // Configure recorder settings here if needed
                // Example: recorderVCInitializer.musicBarHidden = true
            }
        }
        
        // Start recorder
        EORecorderViewController.startRecorder(with: config, presenter: viewController, delegate: self) { [weak self] error in
            if let err = error as? NSError {
                print("🎬 [iOS BytePlus] Recorder error: \(err)")
                self?.pendingResult?(FlutterError(
                    code: "RECORDER_ERROR",
                    message: "Failed to start recorder: \(err.localizedDescription)",
                    details: nil
                ))
                self?.cleanup()
            }
        }
    }
    
    // MARK: - Start Editor from Album (Gallery)
    func startEditorFromAlbum(from viewController: UIViewController, result: @escaping FlutterResult) {
        print("🎬 [iOS BytePlus] Starting editor from album...")
        
        guard isAuthSucceeded else {
            print("🎬 [iOS BytePlus] ERROR: SDK not authenticated")
            result(FlutterError(code: "NOT_AUTHENTICATED", message: "BytePlus SDK not authenticated", details: nil))
            return
        }
        
        self.pendingResult = result
        self.presentingViewController = viewController
        
        // Use BytePlus resource picker to select video from album
        let resourcePicker = EOResourcePicker()
        resourcePicker.pickResourcesFromRecorder { [weak self] resources, error, cancel in
            guard let self = self else { return }
            
            if cancel {
                print("🎬 [iOS BytePlus] User cancelled album picker")
                self.pendingResult?(nil)
                self.cleanup()
                return
            }
            
            if let err = error as? NSError {
                print("🎬 [iOS BytePlus] Album picker error: \(err)")
                self.pendingResult?(FlutterError(
                    code: "PICKER_ERROR",
                    message: "Failed to pick video: \(err.localizedDescription)",
                    details: nil
                ))
                self.cleanup()
                return
            }
            
            guard !resources.isEmpty, let resource = resources.first else {
                print("🎬 [iOS BytePlus] No resources selected")
                self.pendingResult?(nil)
                self.cleanup()
                return
            }
            
            // Open editor with selected video
            self.openEditor(with: [resource], from: viewController)
        }
    }
    
    // MARK: - Private Methods
    
    private func openEditor(with resources: [EOResource], from viewController: UIViewController) {
        let sceneConfig = EOEditorSceneConfig()
        sceneConfig.resourceList = resources
        
        let config = EOEditorConfig { initializer in
            // Configure editor settings here if needed
        }
        
        EOEditorViewController.startEditor(with: config, sceneConfig: sceneConfig, presenter: viewController, delegate: self) { [weak self] error in
            if let err = error as? NSError {
                print("🎬 [iOS BytePlus] Editor error: \(err)")
                self?.pendingResult?(FlutterError(
                    code: "EDITOR_ERROR",
                    message: "Failed to start editor: \(err.localizedDescription)",
                    details: nil
                ))
                self?.cleanup()
            }
        }
    }
    
    private func cleanup() {
        self.pendingResult = nil
        self.presentingViewController = nil
    }
}

// MARK: - EORecorderViewControllerDelegate

extension BytePlusHelper: EORecorderViewControllerDelegate {
    
    func recorderViewController(_ recorderViewController: EORecorderViewController, didFinishRecordingMediaWith info: EORecordInfo) {
        print("🎬 [iOS BytePlus] Recording finished")
        
        // Pause preview
        recorderViewController.pausePreview()
        
        // Open editor with recorded video
        guard let viewController = presentingViewController else { return }
        
        let resource = EOResource(type: .video)
        resource.path = info.outputPath
        
        openEditor(with: [resource], from: viewController)
    }
    
    func recorderViewControllerDidTapAlbum(_ recorderViewController: EORecorderViewController) {
        print("🎬 [iOS BytePlus] User tapped album from recorder")
        // This is called when user taps album button within recorder
        // We can handle it here if needed
    }
}

// MARK: - EOEditorViewControllerDelegate

extension BytePlusHelper: EOEditorViewControllerDelegate {
    
    func editorViewController(_ editorViewController: EOEditorViewController, didFinishExportingMediaWith info: EOExportInfo) {
        print("🎬 [iOS BytePlus] Export finished: \(info.outputPath)")
        
        // Dismiss editor
        editorViewController.dismiss(animated: true) { [weak self] in
            // Return video path to Flutter
            self?.pendingResult?(info.outputPath)
            self?.cleanup()
        }
    }
    
    func editorViewControllerDidCancel(_ editorViewController: EOEditorViewController) {
        print("🎬 [iOS BytePlus] User cancelled editor")
        
        editorViewController.dismiss(animated: true) { [weak self] in
            self?.pendingResult?(nil)
            self?.cleanup()
        }
    }
}
```

### 4.2 Update `ios/Runner/AppDelegate.swift`

Add SDK initialization in `application(_:didFinishLaunchingWithOptions:)`:

```swift
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // ... existing code ...
    
    // Initialize BytePlus SDK
    BytePlusHelper.shared.initializeSDK()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

---

## Step 5: Build and Test

### 5.1 Clean Build

```bash
cd ios
rm -rf build
cd ..
flutter clean
flutter pub get
cd ios
pod install
```

### 5.2 Build for iPhone

**⚠️ CRITICAL:** BytePlus SDK has poor performance in debug mode. Always test in **release mode**:

```bash
flutter run --release
```

**Note:** You MUST test on a real iPhone (not simulator) as the camera is required.

### 5.3 Test Checklist

Open the app on your iPhone and test:

- [ ] **Camera**: Tap the + button → Should open BytePlus camera (NOT native iOS camera)
- [ ] **Filters**: Check if filters tab is visible and working
- [ ] **Effects**: Check if effects tab is visible and working
- [ ] **Stickers**: Check if stickers tab is visible and working
- [ ] **Record**: Record a video with effects applied
- [ ] **Editor**: After recording, editor should open automatically
- [ ] **Export**: Tap done/export → Video should save and return to app
- [ ] **Gallery**: Try opening from gallery → Should open BytePlus picker
- [ ] **Performance**: Should be smooth in release mode

---

## Troubleshooting

### "Module 'EffectOneKit' not found"

**Cause:** Framework not properly embedded in Xcode.

**Solution:**
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select Runner project → Runner target → General tab
3. Scroll to "Frameworks, Libraries, and Embedded Content"
4. Find EffectOneKit.xcframework
5. Change "Embed" column to **"Embed & Sign"**
6. Clean build: Product → Clean Build Folder (Cmd+Shift+K)
7. Rebuild

### "Cannot find 'EOSDK' / 'EOLicense' in scope"

**Cause:** Missing import statement.

**Solution:**
- Make sure `import EffectOneKit` is at the top of BytePlusHelper.swift
- Clean and rebuild

### "License file not found"

**Cause:** License file missing or wrong path.

**Solution:**
- Check if `ios/Runner/License/com.volcengine.effectone.inhouse.licbag` exists
- Verify the file is added to Xcode project
- Check the path in `BytePlusHelper.swift` matches your actual file name

### App crashes on launch

**Cause:** Usually license or resource path issues.

**Solution:**
1. Check Xcode console for error messages (look for 🎬 emoji logs)
2. Verify license file exists
3. Verify EOLocalResources.bundle exists in project
4. Try clean build

### Camera opens but no filters/effects

**Cause:** SDK not fully initialized or resources not loaded.

**Solution:**
1. Check Xcode console for "SDK initialization complete" message
2. Verify EOLocalResources.bundle is properly added to Xcode
3. Check internet connection (SDK may download additional resources)

### Very slow/laggy performance

**Cause:** Running in debug mode.

**Solution:**
- **ALWAYS** test in release mode: `flutter run --release`
- Debug mode is 10-100x slower with video processing
- Release mode is required for accurate performance testing

---

## Verification Script

Run this to verify all files are in place:

```bash
#!/bin/bash
echo "🔍 Verifying BytePlus iOS Setup..."

# Check framework
if [ -d "ios/EffectOneKit.xcframework" ]; then
    echo "✅ EffectOneKit.xcframework found"
else
    echo "❌ EffectOneKit.xcframework NOT found - Download from BytePlus"
fi

# Check resources
if [ -d "ios/EOLocalResources.bundle" ]; then
    echo "✅ EOLocalResources.bundle found"
else
    echo "❌ EOLocalResources.bundle NOT found"
fi

# Check BytePlusHelper.swift
if grep -q "import EffectOneKit" ios/Runner/BytePlusHelper.swift 2>/dev/null; then
    echo "✅ BytePlusHelper.swift has BytePlus import"
else
    echo "❌ BytePlusHelper.swift missing BytePlus import"
fi

# Check if using BytePlus recorder
if grep -q "EORecorderViewController" ios/Runner/BytePlusHelper.swift 2>/dev/null; then
    echo "✅ Using BytePlus recorder (not native camera)"
else
    echo "❌ Still using native camera (UIImagePickerController)"
fi

echo ""
echo "📝 Next steps:"
echo "1. If framework not found: Download from https://bytedance.sg.larkoffice.com/wiki/UMxUwBZVoiZBi0kVP5FcmSXBn0e"
echo "2. Add framework to Xcode with 'Embed & Sign'"
echo "3. Update BytePlusHelper.swift with provided code"
echo "4. Build in release mode: flutter run --release"
```

---

## Comparison with Android

| Feature | Android | iOS (After Integration) |
|---------|---------|------------------------|
| Camera | BytePlus EORecorder | BytePlus EORecorderViewController |
| Filters | ✅ Available | ✅ Available |
| Effects | ✅ Available | ✅ Available |
| Stickers | ✅ Available | ✅ Available |
| Beauty | ✅ Available | ✅ Available |
| Editor | BytePlus EOVideoEditor | BytePlus EOEditorViewController |
| Gallery Picker | BytePlus | BytePlus EOResourcePicker |

After completing this guide, iOS and Android apps should have **identical** BytePlus features.

---

## Important Notes

1. **Release Mode Required**: BytePlus SDK has poor debug performance. Always test with `flutter run --release`.

2. **Real Device Required**: Simulator doesn't support camera. Must test on actual iPhone.

3. **SDK Not in Git**: The EffectOneKit.xcframework (~200MB) is excluded from git via .gitignore. Each developer must download it separately.

4. **License File**: Make sure you have the correct license file for your app. The sample uses `com.volcengine.effectone.inhouse.licbag`.

5. **Internet Required**: First launch may download additional resources from BytePlus servers.

6. **iOS Version**: BytePlus SDK requires iOS 11.0 or later.

---

## Need Help?

If you encounter issues:
1. Check Xcode console for 🎬 emoji logs
2. Verify all files are in correct locations
3. Make sure framework is "Embed & Sign" in Xcode
4. Always test in release mode on real iPhone
5. Check that license file matches your app bundle ID

**Reference:** This implementation is based on official BytePlus iOS Sample v1.8.0.1

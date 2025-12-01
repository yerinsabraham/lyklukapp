# BytePlus iOS Export Issue - Support Request

**Date:** December 1, 2025  
**App:** Lykluk (TikTok-style video sharing app)  
**Platform:** iOS  
**SDK Version:** EffectOneKit 1.8.0  
**Contact:** Developer meeting scheduled for December 2, 2025

---

## Executive Summary

We have been working on integrating BytePlus EffectOne SDK on iOS for several days. The **Android version (v1.6.0) works correctly**, but on iOS (v1.8.0), the export flow completes to 100% but **never returns the video path to our app**. The user gets stuck and the app returns to the camera screen instead of navigating to the upload flow.

---

## The Problem

### Expected Flow (How Android Works ✅)
1. User opens BytePlus camera → Records video
2. User applies effects/filters → Taps "Next"
3. Editor opens → User makes edits → Taps "Next"  
4. Export screen shows → Progress 0% → 100%
5. **Export completes → `exportDone` callback fires with video path**
6. App receives path → Navigates to Upload screen
7. User adds caption/description → Posts video

### Actual iOS Behavior (Broken ❌)
1. User opens BytePlus camera → Records video ✅
2. User applies effects/filters → Taps "Next" ✅
3. Editor opens → User makes edits → Taps "Next" ✅
4. Export screen shows → Progress 0% → 100% ✅
5. **Export completes → NO callback fires → App returns to camera** ❌
6. User is stuck - cannot proceed to upload

---

## Technical Details

### SDK Versions
| Platform | SDK | Version |
|----------|-----|---------|
| iOS | EffectOneKit | **1.8.0** |
| Android | EffectOne | **1.6.0** |

### iOS Implementation Files

**Main Integration:** `ios/Runner/EffectOneModule.swift`

```swift
// Class declaration with delegate conformance
class EffectOneModule: NSObject, EODraftBoxControllerDelegate, EOExportViewControllerDelegate {
    // ...
}

// Video Editor Delegate - This IS being called
extension EffectOneModule: EOVideoEditorViewControllerDelegate {
    func videoEditorViewControllerTapNext(
        _ exportModel: EOExportModel, 
        presentVC viewController: UIViewController
    ) {
        // This method IS triggered when user taps "Next"
        // We start the export here:
        EOExportViewController.startExport(
            with: exportModel, 
            presentVC: viewController, 
            delegate: self  // We set ourselves as the delegate
        )
    }
}

// Export Delegate - This is NEVER called
extension EffectOneModule {
    // Based on EOExportUI header file (ios/EOExportUI/Classes/ViewController/EOExportViewController.h)
    func exportVideoPath(_ videoPath: String, videoImage videoImg: UIImage) {
        // THIS METHOD IS NEVER INVOKED despite export completing to 100%
        print("Export completed with path: \(videoPath)")
        sendVideoPathToFlutter(videoPath)
    }
}
```

### EOExportUI Header File (from our codebase)

**File:** `ios/EOExportUI/Classes/ViewController/EOExportViewController.h`

```objc
@protocol EOExportViewControllerDelegate <NSObject>

@optional
- (void)exportVideoPath:(NSString *)videoPath videoImage:(UIImage *)videoImg;
- (void)getPickSingleImageResourceWithCompletion:(nullable void(^)(NSURL * _Nullable pickImage, NSError * _Nullable error, BOOL cancel))completionBlock;
- (void)exportViewController:(EOExportViewController *)exportViewController didExportImage:(UIImage *)image;

@end

@interface EOExportViewController : UIViewController

+ (void)startExportWithExportModel:(EOExportModel *)exportModel presentVC:(UIViewController *)viewController;
+ (void)startExportWithExportModel:(EOExportModel *)exportModel
                        presentVC:(UIViewController *)viewController
                        delegate:(id<EOExportViewControllerDelegate> _Nullable)delegate;

@property (nonatomic, weak) id<EOExportViewControllerDelegate> delegate;

@end
```

### EOExportViewController.m Implementation (lines 489-502)

```objc
// This code exists in the implementation but delegate is NEVER called
if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(exportVideoPath:videoImage:)]) {
    [strongSelf.delegate exportVideoPath:filePath.path videoImage:strongSelf.coverView.image];
    [strongSelf restoreState];
}
else {
    // Falls through to this - saves to photo library instead
    [strongSelf saveVideoToPhotoLibrary:filePath.path saveTestVideo:NO];
}
```

---

## What We Have Tried

### 1. Multiple Delegate Method Signatures
We tried various method signatures thinking the API might differ:
- `exportVideoPath:videoImage:` ❌ Never called
- `exportViewControllerDidFinishExport:outputPath:` ❌ Never called
- `exportViewController:didFinishExportWithOutputPath:` ❌ Never called

### 2. Extensive Debug Logging
Added comprehensive print statements with emoji banners:
```swift
print("🎯🎯🎯 videoEditorViewControllerTapNext CALLED!")  // This DOES print
print("🎉🎉🎉 exportVideoPath CALLED!")  // This NEVER prints
```

**Result:** `videoEditorViewControllerTapNext` IS called, but `exportVideoPath` is NEVER called.

### 3. Verified Delegate Assignment
```swift
EOExportViewController.startExport(
    with: exportModel, 
    presentVC: viewController, 
    delegate: self  // Confirmed this is set
)
```

### 4. Checked Protocol Conformance
```swift
print("Delegate conforms: \(self is EOExportViewControllerDelegate)")  // Prints: true
```

### 5. Clean Rebuilds
- Deleted `ios/build/`
- Deleted `DerivedData`
- Ran `pod install` fresh
- Full Xcode clean build

---

## Console Logs During Export

When export runs, we see these BytePlus internal logs:

```
## [AE_ALGORITHM_TAG]Algorithm type: 4 load model ttfacemodel/tt_face_v11.1.model failed: -1000
## [AE_ALGORITHM_TAG]report model md5 path: (null)/ttfacemodel/algo_ggl1pqh_v11.1.model
## [AE_ALGORITHM_TAG]AlgorithmFace create handler fail:-1000
```

These face algorithm errors repeat continuously during the export process. The export still completes to 100%, but the delegate is never called.

---

## Questions for BytePlus

1. **Why is `exportVideoPath:videoImage:` never called?**
   - We've verified the delegate is set correctly
   - The export reaches 100%
   - The code in EOExportViewController.m checks for the delegate and should call it

2. **Is there a different delegate method for iOS 1.8.0?**
   - Android 1.6.0 uses `exportDone(path: String)`
   - iOS 1.8.0 EOExportUI shows `exportVideoPath:videoImage:`
   - Are these the correct methods?

3. **Do the face algorithm errors affect export completion?**
   - Errors: `AlgorithmFace create handler fail:-1000`
   - Model path shows `(null)/ttfacemodel/...`
   - Does this null path cause the export to fail silently?

4. **Is there sample code for iOS 1.8.0 export with delegate?**
   - We referenced the demo at `effectone_swift_flutter_demo/`
   - The demo may be for a different version

5. **Should we downgrade to iOS 1.6.0 to match Android?**
   - Would this solve the delegate issue?
   - Is 1.6.0 available for iOS?

---

## Comparison: Android vs iOS

| Feature | Android (Working) | iOS (Broken) |
|---------|-------------------|--------------|
| SDK Version | 1.6.0 | 1.8.0 |
| Export Callback | `exportDone(path)` | `exportVideoPath:videoImage:` |
| Callback Fires | ✅ Yes | ❌ No |
| Export Reaches 100% | ✅ Yes | ✅ Yes |
| Video Path Returned | ✅ Yes | ❌ No |
| Navigation to Upload | ✅ Works | ❌ Stuck |

---

## Project Structure

```
ios/
├── Runner/
│   ├── AppDelegate.swift          # Initializes BytePlus, sets up method channel
│   ├── EffectOneModule.swift      # Main BytePlus integration (delegate methods here)
│   └── License/                   # BytePlus license file
├── EOExportUI/                    # Export UI module (copied from demo)
│   └── Classes/
│       └── ViewController/
│           ├── EOExportViewController.h
│           └── EOExportViewController.m
├── Podfile                        # EffectOneKit 1.8.0
└── Pods/
    └── EffectOneKit/              # BytePlus SDK framework
```

---

## Flutter Integration

**Method Channel:** `effectOne.flutter`

```dart
// lib/core/services/byteplus_editor_service.dart
class BytePlusEditorService {
  static const _channel = MethodChannel('effectOne.flutter');
  
  // Stream to receive exported video path from native
  final _exportedVideoController = StreamController<String>.broadcast();
  Stream<String> get onVideoExported => _exportedVideoController.stream;
  
  Future<void> initialize() async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onVideoExported') {
        final path = call.arguments['path'] as String;
        _exportedVideoController.add(path);  // Never receives path from iOS
      }
    });
  }
}
```

---

## What We Need

1. **Working iOS export callback** - The delegate method must fire when export completes
2. **Video file path** - We need the path to the exported video file
3. **Seamless flow** - Export → Get path → Navigate to upload screen → User posts

---

## Environment

- **macOS:** Latest
- **Xcode:** 15+
- **iOS Target:** 12.0+
- **Flutter:** 3.x
- **CocoaPods:** Latest
- **Test Device:** iPhone (real device, not simulator)

---

## Contact

Ready to share screen during video call to demonstrate:
1. The export reaching 100%
2. The app returning to camera instead of upload screen
3. The delegate methods not being called
4. The console logs showing the behavior

---

## Attachments for Call

1. This document
2. `ios/Runner/EffectOneModule.swift` - Full source code
3. `ios/EOExportUI/Classes/ViewController/EOExportViewController.h` - Header file
4. Xcode console logs during export
5. Screen recording of the issue (if needed)

---

**Priority:** HIGH - This is blocking our MVP launch. Android works, iOS does not.

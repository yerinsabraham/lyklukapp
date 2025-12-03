# iOS BytePlus SDK v1.6.0 Downgrade Guide

**Date:** December 3, 2025  
**Platform:** macOS (iOS development)  
**Current iOS SDK:** v1.8.0  
**Target iOS SDK:** v1.6.0  
**Reason:** SDK version parity with Android for Flutter bridge compatibility

---

## 🎯 OBJECTIVE

Downgrade iOS BytePlus SDK from v1.8.0 to v1.6.0 to match the Android implementation currently working on Windows.

---

## 📋 BACKGROUND CONTEXT

### Why We're Downgrading

**Problem Discovered:**
- Android is running BytePlus SDK v1.6.0 (working perfectly on Windows)
- iOS was upgraded to v1.8.0 in `mvp-official` branch
- When we merged iOS v1.8.0 code with Android v1.6.0, the upload flow broke
- **Root Cause:** Different Flutter-to-Native bridge implementations between SDK versions

**BytePlus Support Confirmation (Mark):**
> "The native parts of Android and iOS will not affect each other because the codes are in separate folders in Flutter, and the compilation also goes through their respective independent compilation processes. Therefore, the core issue is that the implementations of the two branches (iOS and Android) for bridging Flutter may be different, which causes functional abnormalities after code merging. The demo of iOS we provided yesterday is based on v1.6.0, so you can use both iOS and Android v1.6.0."

**Key Insights:**
1. Android and iOS native code compile independently (no cross-contamination)
2. The issue is **bridge architecture differences**, not platform conflicts
3. BytePlus iOS demo is also v1.6.0, confirming this is the stable version
4. Both platforms should use v1.6.0 for consistent bridge implementation

### What Happened on Windows

**Successful Windows Workflow:**
1. Started with `feature/yerin/clean-snapshot` (Android v1.6.0 working)
2. Merged new UI features from `mvp-official` (auth, explore, profile pages)
3. Attempted to merge iOS v1.8.0 BytePlus code → **Upload flow broke**
4. Identified callback incompatibility:
   - v1.6.0: Uses `pendingResult.success(videoPath)` direct callback
   - v1.8.0: Uses stream-based `onVideoExported` event system
5. **Executed partial rollback** - reverted upload flow files to v1.6.0:
   - `lib/core/services/byteplus_editor_service.dart`
   - `lib/modules/home/presentation/nav_bar.dart`
   - `android/app/src/main/kotlin/.../MainActivity.kt`
   - `lib/initializer.dart`
6. Result: Upload flow working, new features preserved ✅

**Current Windows Branch State:**
- Branch: `feature/yerin/clean-snapshot`
- Android SDK: v1.6.0 (stable)
- New Features: Auth pages, explore page, profile updates
- Upload Flow: Working (camera → BytePlus edit → upload screen)

---

## 🔧 IMPLEMENTATION STEPS

### Step 1: Locate iOS BytePlus SDK Files

The iOS BytePlus SDK is typically integrated via:
```
ios/
├── Podfile                           # Check for BytePlus pod dependencies
├── Podfile.lock                      # Version lock file
└── Runner/
    ├── AppDelegate.swift             # BytePlus initialization
    └── [Other BytePlus integration files]
```

Or manually in:
```
ios/Frameworks/
└── [BytePlus SDK .framework files]
```

### Step 2: Check Current SDK Version

```bash
# In ios/ directory
cat Podfile | grep -i byteplus
cat Podfile.lock | grep -i byteplus
```

Or check framework version info:
```bash
# If manually integrated
ls -la ios/Frameworks/ | grep -i byteplus
```

### Step 3: Downgrade to v1.6.0

**If using CocoaPods:**
1. Edit `ios/Podfile` and change BytePlus version to `1.6.0`
2. Run: `pod install` or `pod update BytePlus`

**If manually integrated:**
1. Remove existing v1.8.0 framework files
2. Download v1.6.0 from BytePlus
3. Add v1.6.0 frameworks to project

### Step 4: Review Flutter Bridge Implementation

**Critical File:** `ios/Runner/AppDelegate.swift` (or similar)

Ensure the Flutter method channel callback matches the v1.6.0 pattern:
```swift
// v1.6.0 pattern (what we need):
// Direct callback with video path result
result(videoPath)  // or similar direct result return

// NOT v1.8.0 pattern (what broke):
// Stream-based event system
// FlutterEventChannel or posting to stream
```

**Compare with Android v1.6.0:**
- Android uses: `pendingResult?.success(videoPath)`
- iOS should use equivalent direct callback mechanism

### Step 5: Update Bridge Files (If Needed)

If your iOS code has stream-based callbacks from v1.8.0, revert to direct callbacks:

**Files to check:**
- `ios/Runner/AppDelegate.swift`
- Any `*MethodChannel.swift` or `*EventChannel.swift` files
- BytePlus initialization/configuration files

**Pattern to restore:**
```swift
// When BytePlus export completes:
if let result = pendingResult {
    result(videoPath)  // Direct callback
    pendingResult = nil
}
```

### Step 6: Test Upload Flow on iOS

1. Run the app on iOS simulator/device:
   ```bash
   flutter run -d <ios-device-id>
   ```

2. Test complete upload flow:
   - Open camera/recorder
   - Record video
   - Edit in BytePlus
   - **Verify:** Returns to upload screen (NOT homepage)
   - Complete upload process

3. If it works → proceed to commit

### Step 7: Commit iOS v1.6.0 Changes

```bash
git add ios/
git add lib/  # If you modified any iOS-specific Flutter files
git commit -m "iOS: Downgrade BytePlus SDK to v1.6.0 for bridge compatibility

- Downgraded iOS BytePlus SDK from v1.8.0 to v1.6.0
- Updated method channel callbacks to match Android v1.6.0 pattern
- Removed stream-based export callbacks in favor of direct result returns
- Ensures consistent Flutter bridge implementation across platforms

Reason: Android is on v1.6.0 (stable). BytePlus confirmed their iOS demo
is also v1.6.0. Merging v1.8.0 iOS with v1.6.0 Android caused bridge
callback incompatibility, breaking upload flow. Both platforms now on v1.6.0."

git push origin <your-ios-branch>
```

---

## 🔄 NEXT STEPS (Back on Windows)

Once iOS v1.6.0 is committed and pushed:

1. **Switch back to Windows machine**
2. **Notify Windows AI:** "iOS downgrade to v1.6.0 complete, ready to merge"
3. **Windows AI will:**
   - Merge iOS v1.6.0 code into `feature/yerin/clean-snapshot`
   - Verify bridge compatibility between platforms
   - Test that upload flow remains working
   - Ensure new features still function correctly

---

## 🚨 CRITICAL VERIFICATION

Before committing, verify these files have v1.6.0-compatible code:

### iOS Files to Check:
- [ ] `ios/Podfile` or framework versions show v1.6.0
- [ ] `ios/Runner/AppDelegate.swift` uses direct callbacks (no streams)
- [ ] Upload flow tested: BytePlus export → upload screen (not homepage)
- [ ] No compilation errors
- [ ] No runtime crashes during export

### Flutter Files (Shared):
- [ ] `lib/core/services/byteplus_editor_service.dart` - Direct method channel (no streams)
- [ ] No `BytePlusEditorService.initialize()` or stream setup in initializer
- [ ] Upload navigation logic returns to correct screen

---

## 📚 REFERENCE DOCUMENTS

- `docs/MERGE_STRATEGY.md` - Complete merge strategy with lessons learned
- `docs/BYTEPLUS_SUPPORT_RESPONSE.md` - Original BytePlus support thread
- `BACKEND_SWITCHING_GUIDE.md` - Related architecture decisions

---

## 💡 KEY TIPS FOR MACBOOK AI

1. **Don't overthink the downgrade** - v1.6.0 is the stable version BytePlus recommends
2. **Focus on bridge callbacks** - Ensure direct result returns, not streams
3. **Match Android pattern** - The Windows Android code is your reference
4. **Test thoroughly** - Upload flow MUST navigate to upload screen, not homepage
5. **Commit clearly** - Explain SDK downgrade reason for future reference

---

## ⚠️ COMMON PITFALLS

1. **Don't keep v1.8.0 stream callbacks** - They're incompatible with v1.6.0 Android
2. **Don't add `BytePlusEditorService.initialize()`** - Not needed for v1.6.0
3. **Don't use `onVideoExported` stream** - Use direct callback result
4. **Don't skip testing** - Upload flow must be verified before committing

---

**STATUS:** Ready for macOS implementation  
**NEXT MILESTONE:** iOS v1.6.0 committed → Merge on Windows → Full platform parity

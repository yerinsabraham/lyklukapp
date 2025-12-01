# BytePlus EffectOne SDK Integration Issue - Support Document

**Date**: December 1, 2025  
**App**: Lykluk Mobile (Flutter/Android)  
**BytePlus SDK Version**: Android 1.6.0 (iOS uses 1.8.0)  
**Issue Type**: Authentication Error & Export Callback Failure

---

## Critical Context

**IMPORTANT**: The app was working this morning (December 1, 2025) before pulling latest code from GitHub. After pulling the project, BytePlus integration stopped working completely.

### Current Behavior
1. **Authentication Error**: "no authentication found please contact sales for further information or to obtain an evaluation license"
2. Sometimes the editor loads but still shows the authentication error
3. Export never completes or returns to Flutter app
4. Video editing flow is completely broken

---

## License Information

**License File**: `assets/BPVod.lic`  
**License Details**:
- Package Name: `com.lykluk.lykluk`
- SDK Version: `1.8.0`
- Expiration: `2025-12-31` (valid for 30 more days)
- MD5 Checksum: `09A668C5A6C7C00D3082CD85295848A4`

**License File Path in Code**:
```kotlin
// android/app/src/main/kotlin/com/lykluk/lykluk/MainActivity.kt
private const val LICENSE_NAME = "BPVod.lic"
private const val LICENSE_PATH = "assets/$LICENSE_NAME"
```

**Verification**: License file exists and MD5 matches expected value.

---

## What We've Tried (Past 2 Days)

### 1. License Verification
- ✅ Confirmed license file exists in `assets/BPVod.lic`
- ✅ Verified MD5 checksum matches
- ✅ Confirmed expiration date is valid (Dec 31, 2025)
- ✅ Verified package name matches: `com.lykluk.lykluk`
- ✅ License is being loaded via `context.assets.open("assets/BPVod.lic")`

### 2. SDK Initialization
- ✅ Added `VEEffectSDK.initEffectSDK()` in MainActivity.onCreate()
- ✅ Verified initialization happens before any BytePlus activities launch
- ✅ Added extensive logging to track initialization flow
- ✅ Confirmed all initialization code executes without errors

### 3. Activity Configuration
- ✅ Configured MainActivity, AlbumActivity, EditorMainActivity, ExportActivity
- ✅ Added proper intent-filters for BytePlus SDK activities
- ✅ Implemented ActivityCollector for proper activity lifecycle management
- ✅ Added ExportActivity for handling video export completion

### 4. Export Callback Implementation
- ✅ Implemented dual callback mechanism (pendingResult + method channel)
- ✅ Added retry logic for MainActivity instance timing issues
- ✅ Changed method channel from 'onVideoExported' to 'exportDone' (per iOS example from Mark)
- ✅ Changed argument format from map to direct string (per iOS convention)
- ✅ Verified callbacks execute successfully on Android side

### 5. Method Channel Setup
- ✅ Method channel name: `effectOne.flutter`
- ✅ Implemented handler for 'exportDone', 'exportProcess', 'exportError'
- ✅ Handler registered during app initialization
- ✅ Verified Android sends callbacks but Flutter never receives them

---

## Technical Issue Details

### Issue 1: Authentication Error (PRIMARY ISSUE)

**Error Message**: "no authentication found please contact sales for further information or to obtain an evaluation license"

**When It Occurs**: 
- Immediately when trying to open gallery/album picker
- Sometimes appears after editor loads
- Blocks all BytePlus functionality

**What We Verified**:
1. License file exists and is readable
2. License MD5 matches expected checksum
3. Package name in license matches app package name
4. SDK initialization is called before any BytePlus activities
5. License expiration date is valid (30 days remaining)

**Logs Showing License Load**:
```
D/MainActivity: 🔑 Loading license from: assets/BPVod.lic
D/MainActivity: ✅ License loaded successfully, size: 4789 bytes
D/MainActivity: ✅ VEEffectSDK initialized successfully
```

**Despite Successful License Load, Authentication Still Fails**

### Issue 2: Export Callback Never Reaches Flutter (SECONDARY ISSUE)

Even when export completes (on previous working builds), Flutter never receives the video path.

**Android Side (WORKING)**:
```
D/ActivityCollector: 🎬 onExportDone called with path: /storage/emulated/0/DCIM/lykluk-20251201-160516.mp4
D/MainActivity: ✅ Successfully sent via pendingResult!
D/MainActivity: ✅ Successfully sent via method channel!
```

**Flutter Side (NOT WORKING)**:
- `await openEditorFromAlbum()` never resolves
- Method channel handler never receives 'exportDone' callback
- No logs from BytePlusEditorService.initialize() handler
- App returns to home screen instead of upload screen

**Root Cause**: The pendingResult and method channel callbacks are sent successfully from Android, but Flutter's awaiting code never receives them. This suggests:
1. The method call context is lost when editor activities launch
2. The Dart isolate connection is broken
3. Flutter's method channel handler isn't properly registered

---

## Key Code Files

### MainActivity.kt
**Location**: `android/app/src/main/kotlin/com/lykluk/lykluk/MainActivity.kt`

**Key Methods**:
- `onCreate()`: Initializes VEEffectSDK with license
- `onMethodCall()`: Handles Flutter → Android method calls ('draft', 'record', etc.)
- `sendVideoPathToFlutter()`: Sends export result back to Flutter via pendingResult and method channel
- `onActivityResult()`: Handles results from BytePlus activities

**License Loading Code**:
```kotlin
// Load license from assets
val licenseStream = context.assets.open(LICENSE_PATH)
val licenseContent = licenseStream.readBytes()

// Initialize EffectSDK
val initResult = VEEffectSDK.initEffectSDK(licenseContent, LICENSE_NAME, context)
```

### BytePlusEditorService.dart
**Location**: `lib/core/services/byteplus_editor_service.dart`

**Key Methods**:
- `initialize()`: Sets up method channel handler for 'exportDone' callbacks
- `openEditorFromAlbum()`: Opens gallery → editor → export flow, awaits result
- `openRecorder()`: Opens camera → recording → editing → export flow

**Method Channel Handler**:
```dart
_channel.setMethodCallHandler((call) async {
  if (call.method == 'exportDone') {
    final path = call.arguments as String?;
    if (path != null && path.isNotEmpty) {
      _videoExportedController.add(path);
    }
  }
});
```

### ActivityCollector.kt
**Location**: `android/app/src/main/kotlin/com/lykluk/lykluk/ActivityCollector.kt`

**Purpose**: Maintains weak references to all BytePlus activities for proper cleanup and callback routing

**Key Callbacks**:
- `onExportDone()`: Called when export completes, triggers MainActivity.sendVideoPathToFlutter()
- `onRecordSuccess()`: Called when recording completes

### ExportActivity.kt
**Location**: `android/app/src/main/kotlin/com/lykluk/lykluk/ExportActivity.kt`

**Purpose**: Handles video export progress and completion

**Key Features**:
- Auto-starts export when launched (no manual button click)
- Shows progress bar (0-100%)
- Calls ActivityCollector.onExportDone() on completion

---

## Version Mismatch Concern

**Android**: BytePlus EffectOne SDK v1.6.0  
**iOS**: BytePlus EffectOne SDK v1.8.0  
**License**: Created for v1.8.0

**Potential Issue**: License was created for SDK v1.8.0 but Android is using v1.6.0. This might cause authentication issues.

**Request for BytePlus Support**: 
- Can a v1.8.0 license work with v1.6.0 SDK?
- Should we upgrade Android SDK to v1.8.0?
- Can you provide a license specifically for v1.6.0?

---

## Sample Logs

### Successful License Load (but authentication still fails)
```
12-01 16:05:05.123 D/MainActivity: 🔑 Loading license from: assets/BPVod.lic
12-01 16:05:05.145 D/MainActivity: 📦 License file size: 4789 bytes
12-01 16:05:05.147 D/MainActivity: 🔐 License MD5: 09A668C5A6C7C00D3082CD85295848A4
12-01 16:05:05.149 D/MainActivity: ✅ VEEffectSDK initialized successfully
12-01 16:05:05.152 D/MainActivity: 📱 MainActivity created and ready
```

### Export Completion (Android Side)
```
12-01 16:05:21.950 D/ActivityCollector: 🎬 albumActivityRef is null: true
12-01 16:05:21.951 D/ActivityCollector: 🎬 recordActivityRef is null: false
12-01 16:05:21.951 D/MainActivity: 🎬🎬🎬 sendVideoPathToFlutter called with: /storage/emulated/0/DCIM/lykluk-20251201-160516.mp4 (retry: 0)
12-01 16:05:21.953 D/MainActivity: 🎬 methodChannel is null: false
12-01 16:05:21.954 D/MainActivity: ✅ Sending video path via pendingResult: /storage/emulated/0/DCIM/lykluk-20251201-160516.mp4
12-01 16:05:21.955 D/MainActivity: ✅ Successfully sent via pendingResult!
12-01 16:05:21.956 D/MainActivity: ✅ Sending video path via method channel: /storage/emulated/0/DCIM/lykluk-20251201-160516.mp4
12-01 16:05:21.957 D/MainActivity: ✅ Successfully sent via method channel!
```

### Flutter Side (No Logs - Callback Never Received)
```
12-01 16:05:22.796 I flutter: App is hidden
12-01 16:05:22.798 I flutter: App is inactive
// NO LOGS FROM BytePlusEditorService
// NO LOGS FROM post_record_screen navigation code
// await openEditorFromAlbum() never resolves
```

---

## Questions for BytePlus Support

### 1. License/Authentication
- Why does authentication fail despite valid license file?
- Is SDK version mismatch (v1.6.0 vs v1.8.0 license) causing this?
- How can we verify the license is being loaded correctly by the SDK?
- Are there any additional initialization steps required for v1.6.0?

### 2. Activity Lifecycle
- How should we handle activity lifecycle with Flutter integration?
- Is there a recommended way to return results from BytePlus activities to Flutter?
- Should we use `startActivityForResult()` or method channels?

### 3. Export Callback
- What is the correct way to receive export completion in Flutter?
- Should we use iOS-style method channel callbacks ('exportDone')?
- How do other Flutter integrations handle this?

### 4. SDK Version
- Should we upgrade Android SDK from v1.6.0 to v1.8.0 to match iOS?
- What are the breaking changes between v1.6.0 and v1.8.0?
- Can you provide documentation for v1.6.0 specifically?

---

## Request for BytePlus Team

### What We Need
1. **Verify License**: Can you check if our license is valid and properly configured?
2. **Version Guidance**: Should we upgrade to v1.8.0 or stay on v1.6.0?
3. **Sample Code**: Do you have working Flutter + BytePlus Android sample code we can reference?
4. **Debug Assistance**: Can you help us understand why authentication fails despite successful license load?

### Files We Can Share
- License file: `assets/BPVod.lic`
- MainActivity.kt (complete file)
- Full logcat output showing initialization and authentication error
- Any other files needed for debugging

---

## Environment

**Device**: OPPO PBFM00 (Android 8.1.0, API 27)  
**Flutter**: 3.x  
**Build Tool**: Gradle 8.x  
**Kotlin**: 1.9.x  
**Target SDK**: 34  
**Min SDK**: 26

**Dependencies**:
```
com.volcengine.effectone:core:1.6.0
com.volcengine.effectone:resource:1.6.0  
com.volcengine.effectone:effect:1.6.0
com.volcengine.effectone:mediarecord:1.6.0
```

---

## Working State Reference

**Last Working Time**: December 1, 2025, ~8:00 AM (before git pull)  
**What Changed**: Pulled latest code from GitHub  
**Result**: BytePlus authentication completely broken

**Request**: Can you help us identify what might have changed in the codebase that broke the integration?

---

## Summary

We have a valid BytePlus license that was working this morning. After pulling code from GitHub, authentication completely broke. We've verified:
- ✅ License file exists and loads successfully
- ✅ SDK initialization completes without errors  
- ✅ All activity configurations are correct
- ✅ Export callbacks work on Android side
- ❌ Authentication fails with "no authentication found" error
- ❌ Flutter never receives export completion callbacks

We suspect either:
1. SDK version mismatch (v1.6.0 SDK with v1.8.0 license)
2. Something in the pulled code broke license validation
3. Missing initialization step specific to v1.6.0

We need BytePlus support to help diagnose why authentication fails despite valid license.

---

**Prepared for**: BytePlus Support Video Call  
**Contact**: Lykluk Development Team  
**Date**: December 1, 2025

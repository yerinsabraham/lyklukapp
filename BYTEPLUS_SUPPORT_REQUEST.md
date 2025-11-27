# BytePlus EffectOne SDK - Export Callback Issue

**Date:** November 27, 2025  
**SDK Version:** EffectOne v1.8.0  
**Platform:** Android 14 (API 34), Kotlin  
**App:** Lykluk (Flutter hybrid app)  
**Severity:** CRITICAL - Blocking Production Release

---

## Issue Summary

The `ActivityCollector.onExportDone()` callback is **never invoked** after video export completes in `EditorMainActivity`, causing the app to restart and lose the exported video path. This prevents users from uploading their edited videos.

---

## Expected Behavior

1. User edits video in `EditorMainActivity`
2. User taps export button
3. Export completes
4. `ActivityCollector.onExportDone(outputPath)` is called with the exported video path
5. App navigates to upload page with the video

---

## Actual Behavior

1. User edits video in `EditorMainActivity`
2. User taps export button
3. `EditorMainActivity` finishes immediately
4. `ActivityCollector.onExportDone()` is **NEVER called**
5. MainActivity input channel breaks: `Channel is unrecoverably broken and will be disposed!`
6. App restarts completely
7. Exported video path is lost

---

## LogCat Evidence

```
11-27 09:44:31.843 E InputDispatcher: channel '937f7db com.lykluk.lykluk/com.volcengine.effectone.editorui.EditorMainActivity (server)' ~ Channel is unrecoverably broken and will be disposed!

11-27 09:44:31.845 E InputDispatcher: channel 'e057f4c com.lykluk.lykluk/com.lykluk.lykluk.MainActivity (server)' ~ Channel is unrecoverably broken and will be disposed!
```

**NO logs showing:** `"onExportDone called with path"` after export completes

---

## Implementation Details

### How We Launch the Editor

```kotlin
// StartEditorFinishImpl in EOQuickInitHelper.kt
class StartEditorFinishImpl : IAlbumFinish {
    override suspend fun finishAction(
        activity: Activity, 
        mediaList: List<IMaterialItem>, 
        albumConfig: AlbumConfig
    ) {
        EditorMainActivity.startEditorActivityFromAlbum(activity, mediaList.map {
            MediaItem(
                path = it.path,
                type = if (it.isVideo()) MediaType.VIDEO else MediaType.IMAGE,
                duration = if (it.isVideo()) it.duration else 3000
            )
        } as ArrayList<MediaItem>)

        if (!activity.isFinishing) {
            activity.finish()
        }
    }
}
```

### ActivityCollector Implementation

```kotlin
// ActivityCollector.kt
object ActivityCollector {
    const val PATH_RESULT_CODE = 10086
    const val PATH_RESULT_KEY = "video_path"

    var editorActivityRef: WeakReference<Activity>? = null
    var albumActivityRef: WeakReference<Activity>? = null
    var recordActivityRef: WeakReference<Activity>? = null

    fun onExportDone(outputPath: String) {
        android.util.Log.d("ActivityCollector", "🎬 onExportDone called with path: $outputPath")
        
        // Send path to Flutter BEFORE finishing activities
        MainActivity.sendVideoPathToFlutter(outputPath)
        
        // Then finish BytePlus activities
        editorActivityRef?.get()?.let { activity ->
            if (!activity.isFinishing) {
                activity.finish()
            }
        }
        albumActivityRef?.get()?.let { activity ->
            if (!activity.isFinishing) {
                activity.finish()
            }
        }
        recordActivityRef?.get()?.let { activity ->
            if (!activity.isFinishing) {
                activity.finish()
            }
        }
        
        // Clear references
        editorActivityRef = null
        albumActivityRef = null
        recordActivityRef = null
    }
}
```

### Activity Lifecycle Tracking

```kotlin
// EOQuickInitHelper.kt - initApplication()
application.registerActivityLifecycleCallbacks(object : Application.ActivityLifecycleCallbacks {
    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
        when (activity) {
            is EditorMainActivity -> {
                ActivityCollector.editorActivityRef = WeakReference(activity)
                android.util.Log.d("EOQuickInitHelper", "🎬 EditorMainActivity created")
            }
            is EORecordActivity -> {
                ActivityCollector.recordActivityRef = WeakReference(activity)
                android.util.Log.d("EOQuickInitHelper", "🎬 EORecordActivity created")
            }
            is LocalAlbumActivity -> {
                ActivityCollector.albumActivityRef = WeakReference(activity)
                android.util.Log.d("EOQuickInitHelper", "🎬 LocalAlbumActivity created")
            }
        }
    }

    override fun onActivityDestroyed(activity: Activity) {
        when (activity) {
            is EditorMainActivity -> {
                android.util.Log.d("EOQuickInitHelper", "🎬 EditorMainActivity destroyed")
                // Export callback should have been called before this
            }
        }
    }
})
```

### AndroidManifest.xml

```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTask"
    android:taskAffinity=""
    android:theme="@style/LaunchTheme"
    android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
    android:hardwareAccelerated="true"
    android:windowSoftInputMode="adjustResize">
```

---

## Authentication Status

✅ **Authentication is working correctly:**

```
11-27 09:43:58.123 D EOQuickInitHelper: 🔐 License path: /data/user/0/com.lykluk.lykluk/app_flutter/lykluk_test_20251027_20251231_com.lykluk.lykluk_1.8.0_472.licbag
11-27 09:43:58.123 D EOQuickInitHelper: 🔐 License file exists: true
11-27 09:43:58.124 D EOQuickInitHelper: 🔐 License copied successfully
11-27 09:43:58.857 D EOQuickInitHelper: 🔐 Auth result code: EO_AUTH_SUCCESS
11-27 09:43:58.857 D EOQuickInitHelper: ✅ BytePlus SDK authorized successfully!
```

**License Details:**
- File: `lykluk_test_20251027_20251231_com.lykluk.lykluk_1.8.0_472.licbag`
- Expiration: December 31, 2025
- Status: Valid and working

---

## What We've Tried

### ✅ Attempts That Worked
1. Authentication is successful (EO_AUTH_SUCCESS)
2. License file is valid and properly loaded
3. Activity lifecycle callbacks are registered and tracking activities
4. Changed MainActivity launchMode to `singleTask` to prevent destruction
5. Implemented `ActivityCollector.onExportDone()` to send result BEFORE finishing activities

### ❌ Attempts That Failed
1. **EditorConfig.finishAction** - This class doesn't exist in the SDK
2. **EffectOneSdk.exportCallback** - This property doesn't exist in the SDK
3. **EditorWrapperActivity with onActivityResult** - Never receives result because `startEditorActivityFromAlbum` uses `startActivity` instead of `startActivityForResult`
4. **Intent extras monitoring** - `activity.intent?.getStringExtra("outputPath")` returns null
5. **Export activity detection** - Can detect Export activity creation but no way to get the path

---

## Critical Questions for BytePlus Support

### 1. Export Callback API
**What is the correct API to receive the exported video path after EditorMainActivity completes?**

We've implemented `ActivityCollector.onExportDone(outputPath: String)` but it's never called. Is there a different callback interface, listener, or registration method we should use?

### 2. SDK Documentation
**Where is the official documentation for handling export completion in production apps?**

We cannot find any documentation showing:
- How to register export completion callbacks
- How to receive the exported video file path
- How to properly integrate editor results into the app workflow

### 3. Result Mechanism
**Does the SDK provide any of the following mechanisms?**
- Broadcast receiver for export completion?
- Result callback interface we need to implement?
- Intent with result that we should listen for?
- Should we use `startActivityForResult` instead? If so, how?

### 4. Export Path
**Where does the SDK save exported videos?**

If there's no callback mechanism, we could potentially monitor a known directory. Where are exported videos saved by default?
- `/storage/emulated/0/Movies/`?
- `/storage/emulated/0/DCIM/`?
- App-specific directory?

### 5. Alternative Launch Method
**Is there a different method to launch EditorMainActivity that supports result callbacks?**

Current: `EditorMainActivity.startEditorActivityFromAlbum(activity, mediaList)`

Is there an alternative like:
- `EditorMainActivity.startEditorForResult(activity, requestCode, mediaList)`?
- A builder pattern with result callback?
- An intent-based approach with result extras?

---

## Technical Environment

- **SDK:** BytePlus EffectOne v1.8.0
- **Android Version:** 14 (API Level 34)
- **Language:** Kotlin with Kotlin DSL (build.gradle.kts)
- **App Framework:** Flutter hybrid app with native Android integration
- **Device:** Physical device (not emulator)
- **Build Tool:** Gradle 8.7

---

## Impact

This issue is **blocking our production release**. Users can edit videos but cannot upload them because the export path is never returned to our app. The app restarts instead of receiving the video.

**Affected User Flow:**
1. User records/selects video ✅
2. User edits video in BytePlus editor ✅
3. User taps export ❌ (App restarts here)
4. User uploads video ❌ (Never reached)

---

## What We Need

1. **The correct API/method to receive exported video path**
2. **Official documentation or sample code** showing export completion handling
3. **Explanation of the expected integration pattern** for production apps
4. **Workaround or alternative approach** if the current implementation has limitations

---

## Contact Information

**Company:** Lykluk Digital  
**App:** Lykluk (Social Video Platform)  
**Package:** com.lykluk.lykluk  
**Priority:** URGENT - Production Blocker

---

## Additional Notes

We're happy to provide:
- Full source code of our integration
- Complete LogCat logs
- Screen recordings showing the issue
- APK for testing
- Any other information needed

Please respond with the correct implementation approach as soon as possible. We're ready to implement any changes needed.

Thank you!

# BytePlus EffectOne SDK Support Request

## Issue: Cannot Get Exported Video File Path After Editing

### Current Situation

We are integrating BytePlus EffectOne SDK into our Android Flutter application for video editing functionality. The editor works perfectly, but **we cannot retrieve the exported video file path after the user completes editing and clicks "Next"**.

### SDK Version Confusion

**This is a critical issue we need clarification on:**

We have received multiple SDK versions from BytePlus, and the versioning is extremely confusing:

1. **Initial SDK:** Version 1.6.0 (Maven dependency: `com.volcengine.effectone:editor-ui:1.6.0`)
2. **Downloaded SDK Folder:** `EffectOne-1.8.0-Android-20250527-all` (claims to be v1.8.0)
3. **Version Mismatch:** The downloaded folder says 1.8.0, but we're not sure if this is compatible with the Maven 1.6.0 we're using

**PLEASE CLARIFY:**
- What is the actual current stable version number?
- If you update to a new version, how do we know? (Is there a changelog or notification?)
- Should we use Maven dependencies or the downloaded SDK folders?
- When you say "version 1.8.0", does that mean we need to stop using 1.6.0 from Maven?

This version confusion is causing significant delays in our development.

---

## Technical Problem Details

### Current Implementation (SDK v1.6.0)

We have successfully integrated:
- ✅ SDK Authentication (EO_AUTH_SUCCESS)
- ✅ Video Recording
- ✅ Video Editing UI opens correctly
- ✅ User can edit videos with all effects
- ✅ Export progress shows 100% completion
- ✅ Our custom `ExportActivity` launches via intent-filter `com.volcengine.effectone.Launch.EOExport`

### The Problem

**After the user clicks "Next" and export reaches 100%:**
1. BytePlus successfully exports the video file somewhere on the device
2. Our `ExportActivity` is launched (via the intent-filter)
3. **We receive NO file path in any intent extra, callback, or parameter**
4. We cannot find the video file to upload to our backend server

### Code Implementation

#### ExportActivity Registration (AndroidManifest.xml)
```xml
<activity
    android:name=".ExportActivity"
    android:exported="true"
    android:launchMode="singleTask">
    <intent-filter>
        <action android:name="com.volcengine.effectone.Launch.EOExport" />
        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
</activity>
```

#### ExportActivity Implementation (Kotlin)
```kotlin
class ExportActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Problem: How do we get the exported video path here?
        val videoPath = intent?.getStringExtra("video_path")  // Always null
        val outputPath = intent?.getStringExtra("outputPath")  // Always null
        val filePath = intent?.getStringExtra("file_path")    // Always null
        
        // We have tried checking intent extras, intent data URI, everything is null
        Log.d("ExportActivity", "Video path: $videoPath")  // Logs: "Video path: null"
        
        // Without the path, we cannot proceed with upload
        ActivityCollector.onExportDone("") // Empty string because we have no path!
    }
}
```

#### What We've Tried

1. **Checked all intent extras:**
   - `video_path`, `outputPath`, `file_path`, `export_path`, `output`, `path`
   - All return `null`

2. **Checked intent data URI:**
   ```kotlin
   intent?.data?.path // Also null
   ```

3. **Looked at the Export SDK documentation (BYTEPLUS EXPORT.md):**
   - Found `EOExportManager` with `exportVideo()` and `IEOExportListener`
   - **But these classes don't exist in SDK v1.6.0!**
   - Are they only available in v1.8.0?

4. **Attempted to search for the file manually:**
   - This is unreliable and could find wrong videos
   - We need BytePlus to give us the correct path

### What We Need

**Please provide clear instructions on how to:**

1. **Get the exported video file path after editing completes**
   - Which intent extra key should we check?
   - Or should we use a callback listener?
   - Or do we need to use `EOExportManager` API (and if so, which SDK version)?

2. **Clarify the SDK version situation:**
   - Are we supposed to migrate from 1.6.0 to 1.8.0?
   - If yes, is there a migration guide?
   - Why does the exported SDK folder say 1.8.0 but Maven still uses 1.6.0?

3. **Provide complete export flow documentation:**
   - Step-by-step: Editor → Export → Get file path → Return to app
   - Code examples for Android/Kotlin
   - Which callbacks/listeners to implement

---

## Expected Behavior

After the user finishes editing and clicks "Next":
1. BytePlus should export the video
2. BytePlus should provide the exported video file path to our app
3. We can then upload this video to our backend

---

## Current Behavior

After the user finishes editing and clicks "Next":
1. BytePlus exports the video successfully ✅
2. Our `ExportActivity` launches ✅
3. **We receive no file path** ❌
4. Cannot proceed with upload ❌

---

## Environment

- **SDK Name:** BytePlus EffectOne SDK
- **SDK Version:** 1.6.0 (Maven) or 1.8.0 (Downloaded folder) - **Please clarify!**
- **Platform:** Android (Kotlin)
- **Framework:** Flutter
- **Build Configuration:**
  ```gradle
  val effectOneVersion = "1.6.0"
  api("com.volcengine.effectone:editor-ui:${effectOneVersion}")
  api("com.volcengine.effectone:recorder-ui:${effectOneVersion}")
  api("com.volcengine.effectone:base-resource:${effectOneVersion}")
  ```

---

## Request for BytePlus Team

Please provide:

1. ✅ **Clear documentation** on how to get the exported video path in v1.6.0
2. ✅ **Version clarity** - What version should we actually be using?
3. ✅ **Migration guide** if we need to upgrade from 1.6.0 to 1.8.0
4. ✅ **Code examples** showing complete editor → export → get path flow
5. ✅ **Version update notifications** - How will we know when new versions are released?

---

## Additional Notes

- Our authentication works perfectly (EO_AUTH_SUCCESS)
- The editor UI works great
- Export completes successfully
- We just need to know where the exported video is saved!

This is blocking our production deployment. Any urgent assistance would be greatly appreciated.

---

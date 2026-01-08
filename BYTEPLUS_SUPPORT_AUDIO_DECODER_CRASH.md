# BytePlus Support Request - EffectOne Export Crash (Audio Decoder SIGSEGV)

**Date:** January 9, 2026  
**SDK:** BytePlus EffectOne v1.8.1-rc.4-immersion-bar-fix-16k-0912  
**App:** LykLuk (com.lykluk.lykluk)

---

## Issue Summary

EffectOne video export crashes immediately after clicking "Next" in the editor with a **SIGSEGV in the native audio decoder thread** (`VE-audioDecodeD`). The app restarts without completing the export.

**Critical:** This issue blocks our production release as video upload is a core feature.

---

## Timeline & Context

1. **Before MediaLive Integration:** EffectOne upload flow was working successfully
2. **After MediaLive Integration:** We integrated BytePlus MediaLive SDK v1.48.200.2 for livestreaming
3. **MediaLive Status:** Now working correctly (camera preview, streaming, no crashes)
4. **EffectOne Status:** Export now crashes consistently at the same point

**Both SDKs need to coexist in our app** - MediaLive for livestreaming and EffectOne for video editing/upload.

---

## Technical Details

### Device Information
- **Device:** OPPO PBFM00
- **Android Version:** 8.1.0 (API 27)
- **ABI:** arm64-v8a
- **Build Fingerprint:** `OPPO/PBFM00/PBFM00:8.1.0/OPM1.171019.026/2021030000:user/release-keys`

### SDK Configuration
```kotlin
// BytePlus EffectOne SDK
val effectOneVersion = "1.8.1-rc.4-immersion-bar-fix-16k-0912"
api("com.volcengine.effectone:editor-ui:${effectOneVersion}")
api("com.volcengine.effectone:recorder-ui:${effectOneVersion}")
api("com.volcengine.effectone:base-resource:${effectOneVersion}")
api("com.volcengine.effectone:base-network:${effectOneVersion}")

// BytePlus MediaLive SDK - with exclusions to avoid conflicts
implementation("com.bytedanceapi:ttsdk-ttlivepush:1.48.200.2") {
    exclude(group = "com.bytedanceapi", module = "ttsdk-ttffmpeg")
    exclude(group = "com.bytedanceapi", module = "ttsdk-bytevc1")
    exclude(group = "com.bytedanceapi", module = "ttsdk-bytenn")
    exclude(group = "com.bytedanceapi", module = "ttsdk-ttplayer")
}
implementation("com.bytedanceapi:ttsdk-ttlivepull_premium:1.48.200.2") {
    exclude(group = "com.bytedanceapi", module = "ttsdk-ttffmpeg")
    exclude(group = "com.bytedanceapi", module = "ttsdk-bytevc1")
    exclude(group = "com.bytedanceapi", module = "ttsdk-bytenn")
    exclude(group = "com.bytedanceapi", module = "ttsdk-ttplayer")
}
```

**Note:** We exclude MediaLive's shared native libraries to ensure EffectOne's versions are used.

### License
```
File: lykluk_test_20251027_20260131_com.lykluk.lykluk_1.8.0_493.licbag
Expires: 2026-01-31
Version: v1.8.0
Package: com.lykluk.lykluk
```

---

## Crash Details

### Crash Signature
```
Fatal signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 0x1e8
Thread: VE-audioDecodeD (Audio Decoder Thread)
Library: libttffmpeg.so
Function: ff_af_queue_add+132
```

### Stack Trace
```
backtrace:
#00 pc 000000000008b0e8  libttffmpeg.so (ff_af_queue_add+132)
#01 pc 000000000008b098  libttffmpeg.so (ff_af_queue_add+52)
```

### Crash Pattern
- **Consistent:** Happens every time on clicking "Next" after editing
- **Timing:** During export/compile initialization phase
- **Location:** Native code in FFmpeg audio frame queue (`ff_af_queue_add`)
- **Fault Address:** `0x1e8` (null pointer dereference - likely accessing a struct member at offset 0x1e8)

### Related Log Messages
```
[VESDK] playbackFrame::No free audio pipeline resource!
[VESDK] tryActiveAudioPipelineInPool, cnt 0
[VESDK] compile called
EditorManager-ExportImpl: compile called
Fatal signal 11 (SIGSEGV), code 1, fault addr 0x1e8 in tid VE-audioDecodeD
```

The crash occurs immediately after the compile process starts, specifically in the audio decoder thread when trying to add audio frames to a queue.

---

## Export Code (Following BytePlus Documentation)

```kotlin
class ExportActivity: BaseActivity() {
    private lateinit var eoExportManager: EOExportManager
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        EffectOneSdk.immersionBar.applyFitFullScreen(this, ...)
        setContentView(R.layout.export)
        
        eoExportManager = EOExportManager.init(this) { success ->
            if (success) {
                runExportAction()
            } else {
                finish()
            }
        }
    }
    
    private fun runExportAction() {
        val exportFilePath = "$DCIM/sample-${timestamp}.mp4"
        
        eoExportManager.shouldAddWaterMark(false)
        eoExportManager.exportVideo(
            outputPath = exportFilePath,
            outputSetting = EOOutputVideoSettings(),
            exportListener = object : IEOExportListener {
                override fun onDone(outputPath: String) { ... }
                override fun onError(error: Int, msg: String?) { ... }
                override fun onProgress(progress: Float) { ... }
            }
        )
    }
}
```

---

## SDK Initialization

### EffectOne Initialization (in Application.onCreate)
```kotlin
EOQuickInitHelper.licenseFileName = "lykluk_test_20251027_20260131_com.lykluk.lykluk_1.8.0_493.licbag"
EOQuickInitHelper.prepareAndInit { success, message ->
    if (success) {
        Log.d("App", "EffectOne authenticated successfully")
    } else {
        Log.e("App", "EffectOne auth failed: $message")
    }
}
```

### MediaLive Initialization (in MainActivity.onCreate)
```kotlin
MediaLiveHelper.initializeSDK(
    context = this,
    appName = "LykLuk",
    appVersion = appVersion,
    appChannel = "google_play"
)
```

**Note:** EffectOne initializes first in Application class, MediaLive initializes later in MainActivity.

---

## What We've Tried

1. ✅ **Excluded MediaLive's FFmpeg:** Added `exclude(module = "ttsdk-ttffmpeg")` - Still crashes
2. ✅ **Excluded Additional Libraries:** Excluded `bytevc1`, `bytenn`, `ttplayer` from MediaLive - Still crashes
3. ✅ **Updated License:** Using latest license (493.licbag, expires 2026-01-31) - Still crashes
4. ✅ **ProGuard Rules:** Ensured all BytePlus classes are kept - Still crashes
5. ✅ **Verified SDK Version:** Confirmed using v1.8.1-rc.4-immersion-bar-fix-16k-0912 - Still crashes

---

## Questions for BytePlus Support

1. **Is this a known issue with EffectOne SDK v1.8.1 on Android 8.1?**
   - The crash is in `ff_af_queue_add` at offset +132, suggesting a null pointer dereference in FFmpeg's audio frame queue

2. **Are there compatibility issues between EffectOne v1.8.1 and MediaLive v1.48.200.2?**
   - Even with module exclusions, could there be version conflicts in shared native libraries?

3. **Is there a workaround to disable audio processing during export?**
   - Could we configure `EOOutputVideoSettings` to skip audio decoding/encoding?
   - Is there a hardware-only decode mode that bypasses the FFmpeg audio queue?

4. **Should we try a different SDK version?**
   - Would downgrading to v1.8.0 or v1.6.0 help?
   - Is there a stable v1.8.1 patch that fixes this crash?

5. **Are there specific device/OS requirements for SDK v1.8.1?**
   - Does v1.8.1 require Android 9.0+ for audio processing?
   - Are there known issues with OPPO devices or Qualcomm chipsets?

---

## Requested Support

1. **Immediate:** Workaround or configuration to prevent the audio decoder crash
2. **Short-term:** SDK version recommendation that supports both EffectOne and MediaLive on Android 8.1+
3. **Long-term:** Bug fix in EffectOne SDK's FFmpeg audio queue handling

---

## Additional Context

### Working State (Before MediaLive)
- EffectOne upload flow worked successfully
- SDK version: Same v1.8.1-rc.4
- Same device, same video files

### Current State (After MediaLive)
- MediaLive livestream: ✅ Working (camera preview, streaming, clean shutdown)
- EffectOne export: ❌ Crashes (SIGSEGV in audio decoder)

### App Requirements
- **Must have both features working:**
  - MediaLive for livestreaming
  - EffectOne for video editing/upload
- **Target:** Android 8.1+ (API 27+)
- **App size limit:** <200MB (using remote GCS resource loading)

---

## Attachments

- Full crash log: `crash_log4.txt` (attached)
- Build configuration: `android/app/build.gradle.kts` (see above)
- ProGuard rules: `android/app/proguard-rules.pro` (BytePlus classes kept)

---

## Contact Information

**App:** LykLuk  
**Package:** com.lykluk.lykluk  
**License:** lykluk_test_20251027_20260131_com.lykluk.lykluk_1.8.0_493.licbag  

Thank you for your assistance.

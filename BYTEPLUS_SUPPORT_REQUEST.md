# BytePlus Support Request - Return to Host App After Export

## Subject
**BytePlus Video Editor SDK v1.8.0 - Need to return control to Flutter app after video export with exported file path**

---

## Current Situation

We have successfully integrated BytePlus Video Editor SDK v1.8.0 into our Flutter Android application (package: `com.lykluk.lykluk`). The editor works perfectly:
- ✅ Authentication successful with license
- ✅ Video selection from gallery works
- ✅ Editor opens and all editing features work
- ✅ Video export completes successfully

**However**, when the user clicks "Next" to export the edited video, the BytePlus SDK finishes its entire activity stack, which causes our app to disconnect and relaunch to the home screen.

---

## What We Need

After the user completes video editing and export in BytePlus Editor, we need:

1. **Control returned to our Flutter application** (not app restart/relaunch)
2. **The exported video file path** passed back to our app
3. **User navigated to our upload screen** where they can add captions, descriptions, and upload the edited video (similar to TikTok's flow)

---

## Current Integration Approach

```kotlin
// 1. Flutter calls MethodChannel to open editor
MainActivity.kt:
- Opens BytePlus editor via EOQuickInitHelper.startEditorFromAlbum()

// 2. Album selection
EOQuickInitHelper.kt:
- AlbumConfig with StartEditorFinishImpl class
- Launches EditorMainActivity.startEditorActivityFromAlbum()

// 3. User edits video
EditorMainActivity:
- User edits video with BytePlus tools
- Clicks "Next" button to export

// 4. PROBLEM: BytePlus finishes and app relaunches
- Video exports successfully
- All activities finish
- App disconnects from device
- App relaunches to home screen
- Flutter never receives the exported video path
```

---

## What We've Tried

### Approach 1: Activity Result Handling
- Added `onActivityResult()` in MainActivity to catch results
- BytePlus never calls `setResult()` with video path
- **Result**: MainActivity never receives callback

### Approach 2: Custom ExportActivity
- Created custom export activity extending BytePlus's base
- Tried to intercept export completion with `IEOExportListener`
- **Result**: BytePlus has its own internal export flow that bypasses our activity

### Approach 3: EditorWrapperActivity
- Created wrapper activity to intercept editor lifecycle
- Launched EditorMainActivity from wrapper
- **Result**: Broke BytePlus SDK authentication completely

### Approach 4: ActivityCollector Pattern
- Tracked BytePlus activities with WeakReferences
- Called `ActivityCollector.onExportDone()` to set results
- **Result**: Activities finish before we can set results

---

## Questions for BytePlus Support

### Primary Question
**Does BytePlus Video Editor SDK v1.8.0 support returning control to the host application after video export with the exported file path?**

### If YES:
1. What is the correct integration pattern for Flutter Android apps?
2. Which callback or listener should we implement to receive the exported video path?
3. Are there any configuration options in `EditorConfig` or `EditorInitConfig` we should use?
4. Do you have any Flutter + BytePlus integration examples or documentation?

### If NO:
1. Is this functionality available in a newer SDK version?
2. Is there a different BytePlus SDK mode (embedded editor view instead of separate activity) that would work better for our use case?
3. Are there any workarounds you recommend?
4. Is this feature on your roadmap?

---

## Alternative Workaround Ideas (If Not Supported)

If BytePlus SDK truly doesn't support this flow, we're considering:

1. **File System Monitoring**
   - Monitor the export directory for new files
   - Automatically detect when export completes
   - Read the latest exported video path from file system

2. **Manual File Selection**
   - After editing, user is returned to upload screen
   - User manually selects the edited video from gallery again
   - Not ideal UX but functional

3. **Switch to Different SDK**
   - If BytePlus doesn't support this, we may need to evaluate other video editor SDKs

**Which of these approaches would you recommend, or do you have better suggestions?**

---

## Our SDK Configuration

**License**: `lykluk_test_20251027_20251130_com.lykluk.lykluk_1.8.0_462.licbag`
**Package**: `com.lykluk.lykluk`
**SDK Version**: 1.8.0 (462)
**Platform**: Android (Flutter)
**License Valid Until**: November 30, 2025

---

## Expected Behavior (Similar to TikTok)

1. User taps "Gallery" button in app
2. BytePlus album opens → user selects video
3. BytePlus editor opens → user edits video
4. User taps "Next" → video exports
5. **App returns to upload screen (not home screen)**
6. **App receives exported video path**
7. User adds caption, description, hashtags
8. User uploads edited video

---

## Request for Help

Please provide:
- ✅ Confirmation if this flow is possible with BytePlus SDK v1.8.0
- ✅ Code examples or documentation showing correct implementation
- ✅ Any configuration options we may have missed
- ✅ Recommended workarounds if direct support doesn't exist
- ✅ Timeline for this feature if it's in development

---

## Contact Information

**Company**: Lykluk Digital
**Package**: com.lykluk.lykluk
**License ID**: (from license file name)
**Priority**: High - Blocking MVP launch

Thank you for your assistance!

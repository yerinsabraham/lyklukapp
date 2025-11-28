# BytePlus EffectOne SDK - Technical Support Request

## Issue Summary
We need to intercept the exported video file path after editing to pass it to our Flutter upload flow, instead of having the video automatically saved to the iOS Photos library.

## Current Behavior
1. User records/selects video → BytePlus camera opens ✅
2. User edits video with effects → BytePlus editor works ✅  
3. User clicks "Export" button → BytePlus export UI shows progress ✅
4. Video reaches 100% → Saved to Photos library ✅
5. **PROBLEM**: User is stuck on export screen, video path is NOT returned to our app ❌

## Desired Behavior
After clicking "Export" and video reaches 100%:
1. Get the exported video file path/URL
2. Send path to Flutter via method channel
3. Dismiss all BytePlus screens
4. Navigate user to our app's upload flow (caption, location, etc.)

## Technical Details

### SDK Version
- EffectOne iOS SDK v1.8.0
- License: lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472.licbag
- Integration: Flutter + iOS Native (Swift)

### Current Implementation
```swift
func videoEditorViewControllerTapNext(
    _ exportModel: EOExportModel, 
    presentVC viewController: UIViewController
) {
    // This shows export UI and saves to Photos, but we can't get the path
    EOExportViewController.startExport(
        with: exportModel, 
        presentVC: viewController
    )
}
```

### What We've Tried

1. **Looking for delegate callbacks**
   ```swift
   // Tried implementing EOExportViewControllerDelegate
   // Methods never called - delegate might not exist or work differently
   func exportViewControllerDidFinishExport(
       _ exportViewController: EOExportViewController,
       outputPath: String
   ) { }
   ```

2. **Trying to export programmatically**
   ```swift
   // exportModel.export(to:completion:) - doesn't exist
   // exportModel.draftPath - doesn't exist
   // exportModel.outputPath - doesn't exist
   ```

3. **Using reflection to discover properties**
   ```swift
   let mirror = Mirror(reflecting: exportModel)
   // Need to know what properties/methods are actually available
   ```

## Questions for BytePlus Support

### 1. How do we get the exported video file path?
Is there a:
- Completion callback/delegate method we should implement?
- Property on `EOExportModel` that contains the output path?
- Alternative export method that returns the file path?

### 2. Should we use Draft Box instead?
Would saving to Draft Box give us access to the video path?
```swift
EODraftBoxController.presentDraftVCDelegate(self)
```

### 3. Can we export without showing the UI?
Is there a programmatic export method like:
```swift
exportModel.export(to: outputURL) { success, error in
    // Get file path here
}
```

### 4. What's the recommended integration pattern?
For apps that need to:
- Let users edit videos with BytePlus
- Get the edited video file
- Upload to their own backend
- NOT save to Photos library

## Additional Context

### App Flow
```
User clicks "+" → BytePlus Camera → Record/Select Video → 
BytePlus Editor → Add Effects → Click "Export" →
[NEED VIDEO PATH HERE] → Flutter Upload Screen → 
Add Caption/Location → Post to Backend
```

### Files Involved
- `/ios/Runner/EffectOneModule.swift` - Native BytePlus integration
- `/lib/core/services/byteplus_editor_service.dart` - Flutter service
- `/lib/modules/home/presentation/nav_bar.dart` - Upload flow trigger

## Urgency
This is blocking our MVP launch. We need the export-to-upload flow working for users to post videos.

## Contact Information
- Repository: lyklukdigital/mobile_app_v2
- Branch: new-byteplus
- Developer: AI Assistant helping client

## Request
Please provide:
1. Documentation for programmatic video export
2. Sample code showing how to get exported video path
3. Alternative approach if export callback doesn't exist
4. Timeline for any SDK updates if feature is missing

Thank you for your support!

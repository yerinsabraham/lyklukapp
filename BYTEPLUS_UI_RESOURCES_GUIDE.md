# BytePlus UI Resources Guide

## Problem

When BytePlus Video Editor shows "eo" text or broken symbols instead of actual icons (like gallery icon, camera buttons, etc.), it means the **EOLocalResources.bundle** is missing or incomplete.

## Why This Happens

The BytePlus UI resources (`EOLocalResources.bundle`) are **NOT tracked in Git** because:
1. They're listed in `.gitignore` to keep the repository size manageable
2. These files are ~200MB and contain icons, fonts, effects, and other UI assets
3. Each developer needs to download them separately

## Solution

### For iOS (Primary Solution)

You needs to copy the `EOLocalResources.bundle` folder from the BytePlus demo or from your machine.

#### Option A: Copy from BytePlus Demo (Recommended)

If you have the BytePlus demo downloaded (`effectone_swift_flutter_demo`):

```bash
# Navigate to your iOS folder
cd /path/to/mobile_app_v2/ios

# Copy the EOLocalResources.bundle from BytePlus demo
cp -R /path/to/effectone_swift_flutter_demo/ios/EOLocalResources.bundle ./
```



Then on your mac:
```bash
cd /path/to/mobile_app_v2/ios
unzip EOLocalResources.zip
```

### Folder Structure Required

After copying, your `ios/` folder should have:

```
ios/
├── EOLocalResources.bundle/
│   ├── BuiltInResource/
│   │   ├── Albums/
│   │   ├── Animations/
│   │   ├── Configs/
│   │   ├── CutSame/
│   │   ├── Icons/          ← These are the UI icons (eo_*.png files)
│   │   └── Strings/
│   ├── EffectResource/
│   │   ├── ComposeMakeup.bundle/
│   │   ├── ModelResource.bundle/
│   │   ├── Panel_configs/
│   │   ├── Resource_icons/
│   │   ├── StickerResource.bundle/
│   │   ├── duet.bundle/
│   │   ├── filter.bundle/
│   │   ├── fonts.bundle/
│   │   ├── music.bundle/
│   │   ├── sound.bundle/
│   │   ├── sticker.bundle/
│   │   ├── tone.bundle/
│   │   ├── transitions.bundle/
│   │   └── ve_effect.bundle/
│   └── License/
│       └── [your_license].licbag
├── Runner/
├── Podfile
└── ...
```

### For Android

Android resources come from Maven dependencies, so they should download automatically. If icons are missing on Android:

1. **Clean and rebuild:**
   ```bash
   cd android
   ./gradlew clean
   cd ..
   flutter clean
   flutter pub get
   flutter build apk --debug
   ```

2. **Check build.gradle.kts dependencies:**
   Make sure these are present in `android/app/build.gradle.kts`:
   ```kotlin
   val effectOneVersion = "1.6.0"
   api("com.volcengine.effectone:editor-ui:${effectOneVersion}")
   api("com.volcengine.effectone:recorder-ui:${effectOneVersion}")
   api("com.volcengine.effectone:base-resource:${effectOneVersion}")  // ← This provides UI resources
   ```

3. **If still missing, sync project:**
   - Open Android Studio
   - File → Sync Project with Gradle Files
   - Build → Clean Project
   - Build → Rebuild Project

## Verification

After adding `EOLocalResources.bundle`, verify the icons folder exists:

```bash
# Check if Icons folder has the eo_*.png files
ls -la ios/EOLocalResources.bundle/BuiltInResource/Icons/

# You should see files like:
# eo_album_list_bar_back@3x.png
# eo_base_back@3x.png
# eo_camera_beauty_back@3x.png
# etc.
```

## Important Notes

1. **Don't commit to Git**: The `EOLocalResources.bundle` is in `.gitignore` intentionally. Don't remove it from `.gitignore` or your repo will become huge.

2. **After pod install**: If you run `pod install`, make sure the bundle is still in place. Some pod operations might affect it.

3. **Xcode Build Phase**: Make sure `EOLocalResources.bundle` is added to the Xcode project's "Copy Bundle Resources" build phase if icons still don't appear.

4. **Size Warning**: The full `EOLocalResources.bundle` is ~200MB. For production, you may want to use online resource delivery as documented in `IOS_BYTEPLUS_INTEGRATION.md`.

## Quick Fix Commands

For your colleague on `video-feed-update` branch:

```bash
# 1. Get the EOLocalResources.bundle from a team member (zip file)

# 2. Navigate to your project
cd /path/to/mobile_app_v2

# 3. Unzip to ios folder
cd ios
unzip /path/to/EOLocalResources.zip

# 4. Verify it's there
ls EOLocalResources.bundle/BuiltInResource/Icons/ | head -10

# 5. Clean and rebuild iOS
cd ..
flutter clean
flutter pub get
cd ios
pod install
cd ..
flutter run -d [your-ios-device]
```

## Contact

If you don't have access to the BytePlus demo or SDK:
1. Check with the team lead for BytePlus portal access
2. Or request the `EOLocalResources.bundle` zip from a team member who has it working

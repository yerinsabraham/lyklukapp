# iOS BytePlus License Update Guide for Dimeji

## Overview

This guide shows you how to update the BytePlus license file for iOS. The new license expires **December 31, 2025** (replacing the old one that expired November 30, 2025).

**What happened on Android:**
- Old license expired November 30, 2025
- Downloaded new license from BytePlus (expires Dec 31, 2025)
- Updated Android app to use new license
- Fixed caching issue so users don't need to reinstall

**What you need to do on iOS:**
- Download the same license package
- Extract and copy the iOS license file
- Update iOS code to reference the new license
- Test to ensure authentication works

---

## Step 1: Download License Package

### 1.1 Download from BytePlus

1. Go to: https://bytedance.larkoffice.com/wiki/UMxUwBZVoiZBi0kVP5FcmSXBn0e
2. Download the file: **`fcfa54b14428eb38f4ced4ac6095984c.zip`**
3. Save it to your Downloads folder

### 1.2 Extract the ZIP

```bash
cd ~/Downloads
unzip fcfa54b14428eb38f4ced4ac6095984c.zip
cd fcfa54b14428eb38f4ced4ac6095984c
```

### 1.3 Navigate to iOS License

```bash
cd iOS/License
ls -la
```

You should see **2 license files**:
- `lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472.licbag` (Dev)
- `lykluk_test_20251027_20251231_lykluk.com_1.8.0_472.licbag` (Prod - wrong bundle ID format)

**Important:** Use the **first file** (`com.lykluk.lyklukDev`) because:
- iOS bundle ID is: `com.lykluk.lykluk` 
- The second file has incorrect format: `lykluk.com` (bundle ID backwards)
- BytePlus made an error in the second filename

---

## Step 2: Copy License to iOS Project

### 2.1 Navigate to Your iOS Project

```bash
cd ~/dev/mobile_app_v2/ios/Runner/License
```

**Note:** If the `License` folder doesn't exist yet, create it:
```bash
mkdir -p ~/dev/mobile_app_v2/ios/Runner/License
```

### 2.2 Copy the New License File

```bash
cp ~/Downloads/fcfa54b14428eb38f4ced4ac6095984c/iOS/License/lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472.licbag ~/dev/mobile_app_v2/ios/Runner/License/
```

### 2.3 Verify the File Was Copied

```bash
ls -la ~/dev/mobile_app_v2/ios/Runner/License/
```

You should see:
- ✅ `lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472.licbag` (NEW - expires Dec 31)
- ⚠️ Old license file (if present) - you can delete it

### 2.4 Delete Old License (Optional)

If there's an old license file with `20251130` in the name:
```bash
rm ~/dev/mobile_app_v2/ios/Runner/License/lykluk_test_*_20251130_*.licbag
```

---

## Step 3: Update iOS Code to Use New License

### 3.1 Open EffectOneModule.swift

```bash
cd ~/dev/mobile_app_v2
code ios/Runner/EffectOneModule.swift
```

Or open it in Xcode.

### 3.2 Find the `makeAuth()` Function

Look for the function that loads the license (around line 30-50). It should look like:

```swift
func makeAuth() {
    // License is in Runner/License folder (not in bundle)
    guard let licensePath = Bundle.main.path(forResource: "OLD_LICENSE_NAME", ofType: "licbag", inDirectory: "License") else {
        print("❌ [BytePlus] License file not found")
        return
    }
    
    print("🎬 [BytePlus] License path: \(licensePath)")
    
    EOLicense.checkLicense(withPath: licensePath) { result, message in
        print("🎬 [BytePlus] License check: \(result), message: \(message ?? "none")")
    }
}
```

### 3.3 Update the License Filename

**Change this line:**
```swift
guard let licensePath = Bundle.main.path(forResource: "OLD_LICENSE_NAME", ofType: "licbag", inDirectory: "License") else {
```

**To this:**
```swift
guard let licensePath = Bundle.main.path(forResource: "lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472", ofType: "licbag", inDirectory: "License") else {
```

**Note:** Don't include `.licbag` in the filename - the `ofType` parameter handles that.

### 3.4 Save the File

Press `Cmd+S` to save in Xcode or VS Code.

---

## Step 4: Add License to Xcode Project

**⚠️ CRITICAL:** The license file must be added to the Xcode project, not just copied to the folder.

### 4.1 Open Xcode Workspace

```bash
cd ~/dev/mobile_app_v2/ios
open Runner.xcworkspace
```

**Important:** Open `.xcworkspace`, NOT `.xcodeproj`

### 4.2 Add License File to Xcode

1. In Xcode, locate the **Runner** folder in Project Navigator (left sidebar)
2. **Right-click** on **Runner** → **Add Files to "Runner"...**
3. Navigate to: `ios/Runner/License/`
4. Select: `lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472.licbag`
5. **Check these options:**
   - ✅ **Copy items if needed**
   - ✅ **Target: Runner**
   - ✅ Create folder references (NOT groups)
6. Click **Add**

### 4.3 Verify License Is Added

In Xcode Project Navigator, you should see:
```
Runner/
  ├── Runner/
  │   ├── License/
  │   │   └── lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472.licbag ✅
  │   ├── EffectOneModule.swift
  │   └── AppDelegate.swift
```

### 4.4 Check Target Membership

1. Click on the license file in Xcode
2. Open **File Inspector** (right sidebar, first tab)
3. Under **Target Membership**, verify:
   - ✅ **Runner** is checked

---

## Step 5: Clean Build and Test

### 5.1 Clean Xcode Build Cache

In Xcode menu:
1. **Product** → **Clean Build Folder** (Cmd+Shift+K)
2. Close Xcode
3. Delete derived data:
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData
   ```

### 5.2 Clean Flutter Build

```bash
cd ~/dev/mobile_app_v2
flutter clean
flutter pub get
```

### 5.3 Reinstall Pods

```bash
cd ios
rm -rf Pods Podfile.lock
pod install
```

### 5.4 Build and Run in Release Mode

**⚠️ IMPORTANT:** Always test BytePlus in release mode (debug mode is slow):

```bash
cd ~/dev/mobile_app_v2
flutter run --release -d <your-iphone-id>
```

Replace `<your-iphone-id>` with your iPhone's device ID (run `flutter devices` to see it).

---

## Step 6: Verify License Is Working

### 6.1 Check Xcode Console Logs

When the app launches, look for these logs in Xcode console:

**✅ SUCCESS:**
```
🎬 [BytePlus] License path: /path/to/lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472.licbag
🎬 [BytePlus] License check: true, message: Success
```

**❌ FAILURE (old license expired):**
```
🎬 [BytePlus] License check: false, message: License expired
```

**❌ FAILURE (file not found):**
```
❌ [BytePlus] License file not found
```

### 6.2 Test BytePlus Features

1. Open the app on your iPhone
2. Tap the **+** button to create a post
3. The BytePlus camera should open (not native iOS camera)
4. Check if filters/effects are available
5. Record a video
6. Video should save and upload successfully

**If you see "No authentication, please contact sales":**
- License file is not being loaded
- Check Xcode console for error messages
- Verify the license filename matches exactly in `makeAuth()`

---

## Comparison: Android vs iOS License Update

| Step | Android | iOS |
|------|---------|-----|
| **Download** | Same ZIP file | Same ZIP file |
| **License Location** | `android/app/src/main/assets/` | `ios/Runner/License/` |
| **License File Used** | `lykluk_test_20251027_20251231_com.lykluk.lykluk_1.8.0_472.licbag` | `lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472.licbag` |
| **Code Update** | `EffectOneApp.kt` line 17 | `EffectOneModule.swift` `makeAuth()` function |
| **Build System** | Gradle (auto-includes assets) | Xcode (must manually add to project) |
| **Caching Issue** | Yes - needed force-delete logic | No - iOS doesn't cache license |
| **Expiry Date** | Dec 31, 2025 | Dec 31, 2025 |

**Key Differences:**
- **Android:** License in `assets/` folder, automatically bundled in APK
- **iOS:** License in `Runner/License/`, must be added to Xcode project manually
- **Android:** Had caching bug where old license wasn't replaced - fixed with force-delete
- **iOS:** No caching issue (license always read from bundle)

---

## Troubleshooting

### "License file not found" in Xcode Console

**Cause:** File not added to Xcode project or wrong path.

**Solution:**
1. Check if file exists: `ls ~/dev/mobile_app_v2/ios/Runner/License/*.licbag`
2. In Xcode, verify file appears in Project Navigator under `Runner/License/`
3. Check Target Membership (file inspector, right sidebar) - Runner should be checked
4. Verify filename in `makeAuth()` matches exactly (case-sensitive, no `.licbag` extension)

### "License check: false, message: License expired"

**Cause:** Using old license file or wrong license file.

**Solution:**
1. Check which license file is in the folder: `ls -la ~/dev/mobile_app_v2/ios/Runner/License/`
2. Verify it has `20251231` in the filename (NOT `20251130`)
3. Delete old license: `rm ~/dev/mobile_app_v2/ios/Runner/License/*20251130*.licbag`
4. Clean build and try again

### "License check: false, message: Bundle ID mismatch"

**Cause:** Using wrong license file for bundle ID.

**Solution:**
- iOS bundle ID is: `com.lykluk.lykluk`
- Use license with: `com.lykluk.lyklukDev` in filename (BytePlus uses "Dev" suffix)
- Do NOT use: `lykluk.com` (reversed format - wrong file from BytePlus)

### App crashes on launch after license update

**Cause:** Old build cache or corrupted derived data.

**Solution:**
```bash
# Clean everything
cd ~/dev/mobile_app_v2
flutter clean
rm -rf ios/Pods ios/Podfile.lock
rm -rf ~/Library/Developer/Xcode/DerivedData

# Rebuild
cd ios
pod install
cd ..
flutter run --release -d <your-iphone-id>
```

### "No authentication, please contact sales" error

**Cause:** License not loading or expired.

**Solution:**
1. Check Xcode console for license check result
2. Verify license file is added to Xcode project
3. Verify `makeAuth()` has correct filename
4. Check license expiry date: Should be Dec 31, 2025
5. Try clean build (see above)

---

## Quick Reference

**License filename for iOS:**
```
lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472.licbag
```

**License location:**
```
~/dev/mobile_app_v2/ios/Runner/License/
```

**Code to update:**
```swift
// In EffectOneModule.swift, makeAuth() function:
guard let licensePath = Bundle.main.path(
    forResource: "lykluk_test_20251027_20251231_com.lykluk.lyklukDev_1.8.0_472", 
    ofType: "licbag", 
    inDirectory: "License"
) else {
    print("❌ [BytePlus] License file not found")
    return
}
```

**Test commands:**
```bash
# Clean build
cd ~/dev/mobile_app_v2
flutter clean
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..

# Run in release mode
flutter run --release -d <your-iphone-id>
```

---

## Success Checklist

Before considering the license update complete, verify:

- [ ] Downloaded `fcfa54b14428eb38f4ced4ac6095984c.zip` from BytePlus
- [ ] Extracted and found iOS license file
- [ ] Copied license to `ios/Runner/License/` folder
- [ ] Added license to Xcode project with Target Membership = Runner
- [ ] Updated `makeAuth()` in `EffectOneModule.swift` with new filename
- [ ] Clean build completed without errors
- [ ] Xcode console shows: "License check: true, message: Success"
- [ ] BytePlus camera opens (not native iOS camera)
- [ ] Filters and effects are available
- [ ] Video recording and upload works
- [ ] No "No authentication" error

**When all checked ✅, license update is complete!**

---

## Need Help?

If you encounter issues:
1. Check Xcode console for 🎬 emoji logs
2. Verify license file location and Target Membership in Xcode
3. Check `makeAuth()` function has correct filename
4. Try clean build (delete DerivedData and Pods)
5. Test in release mode (NOT debug mode)

**Remember:** iOS license expires **December 31, 2025** - mark your calendar to update it again before then!

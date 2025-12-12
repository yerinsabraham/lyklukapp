# Android BytePlus Filter/Effects/Music Integration Guide

## Overview

This guide is for integrating BytePlus EffectOne filters, effects, stickers, and music on the **Android** version of the LykLuk app. The iOS version is already working with GCS (Google Cloud Storage) resource delivery.

**IMPORTANT WARNINGS:**
- ⚠️ **DO NOT modify the existing BytePlus upload flow** - it already works
- ⚠️ **DO NOT break the video export functionality** - it already works
- ⚠️ This guide ONLY adds remote resource loading (filters, effects, stickers, music)
- ⚠️ The Android branch has a different implementation than iOS - respect it

**Branch:** `feature/yerin/clean-snapshot`
**Repository:** https://github.com/lyklukdigital/mobile_app_v2

---

## Current State (What Already Works on Android)

✅ BytePlus SDK authentication  
✅ Video recording with BytePlus camera  
✅ Video editing with BytePlus editor  
✅ Video export (different flow than iOS - DO NOT CHANGE)  
✅ Draft box functionality  
✅ License file authentication (`lykluk_test_20251027_20251231_com.lykluk.lykluk_1.8.0_472.licbag`)

❌ **NOT WORKING:** Filters, effects, stickers, music (need GCS integration)

---

## What Needs to Be Implemented

1. **Configure resource loading from GCS** instead of local-only
2. **Set up remote address configuration** pointing to our GCS bucket
3. **Ensure Panel_configs are available** (local bundled + remote download)
4. **Test filters, stickers, effects, and music** load from cloud

---

## GCS (Google Cloud Storage) Configuration

### Public Bucket URL
```
https://storage.googleapis.com/lykluk-pub-appfiles/byteplus/resource/
```

### Available Resource Bundles on GCS
```
gs://lykluk-pub-appfiles/byteplus/resource/
├── ComposeMakeup.bundle/
├── ModelResource.bundle/
├── Panel_configs/
├── Resource_icons/
├── StickerResource.bundle/
├── duet.bundle/
├── filter.bundle/
├── fonts.bundle/
├── music.bundle/
├── sound.bundle/
├── sticker.bundle/
├── tone.bundle/
├── transitions.bundle/
└── ve_effect.bundle/
```

### Cloud Functions Base URL
```
https://us-central1-lykluk-467006.cloudfunctions.net
```

### Config Endpoint
```
https://us-central1-lykluk-467006.cloudfunctions.net/byteplusConfig?panel_key=<PANEL_KEY>
```

---

## Step-by-Step Implementation

### Step 1: Update EOQuickInitHelper.kt - Resource Configuration

**File:** `android/app/src/main/kotlin/com/lykluk/lykluk/EOQuickInitHelper.kt`

Find the `resourceInit()` function and update it to support remote resources:

```kotlin
private fun resourceInit() {
    // Configure resource SDK for online/remote delivery from GCS
    val config = EOResourceConfig.Builder()
        .setResourceSavePath(EOUtils.pathUtil.internalResource())
        .setSysLanguage(Locale.getDefault().language)
        // Enable network for remote resource downloads
        .setNetWorker(DefaultNetWorker())
        .build()
    
    EOResourceManager.init(config)
    
    // Configure remote address for GCS
    configureRemoteResources()
}

private fun configureRemoteResources() {
    val cloudFunctionsBaseUrl = "https://us-central1-lykluk-467006.cloudfunctions.net"
    val gcsPublicBaseUrl = "https://storage.googleapis.com/lykluk-pub-appfiles/byteplus/resource"
    
    // Set resource token (same as iOS)
    EffectOneSdk.setResourceToken("ncfSwHVQ_PVSULrTem-N6yDyKGEg3gySLPIWnE3iALc")
    
    // Configure remote address
    val remoteAddrConfig = EORemoteAddrConfig(
        configDomain = cloudFunctionsBaseUrl,
        configPath = "/byteplusConfig",
        resourceDomain = gcsPublicBaseUrl,
        resourcePath = "",
        modelDomain = gcsPublicBaseUrl,
        modelPath = "/ModelResource.bundle"
    )
    
    // Set icon URL prefix for resource thumbnails
    remoteAddrConfig.iconUrlPrefix = "$gcsPublicBaseUrl/Resource_icons/"
    
    // Apply configuration
    EffectOneSdk.setRemoteAddrConfig(remoteAddrConfig)
    EffectOneSdk.useRemoteConfig(true, true) // useRemoteConfig, useRemoteResource
    
    android.util.Log.d("EOQuickInitHelper", "✅ Remote resource config set:")
    android.util.Log.d("EOQuickInitHelper", "   Config: $cloudFunctionsBaseUrl/byteplusConfig")
    android.util.Log.d("EOQuickInitHelper", "   Resources: $gcsPublicBaseUrl")
    android.util.Log.d("EOQuickInitHelper", "   Icons: $gcsPublicBaseUrl/Resource_icons/")
}
```

### Step 2: Add Required Imports

Add these imports at the top of `EOQuickInitHelper.kt`:

```kotlin
import com.volcengine.effectone.resource.api.EORemoteAddrConfig
import com.volcengine.effectone.resource.network.DefaultNetWorker
```

### Step 3: Update initConfigs() - Change Resource Loaders

**IMPORTANT:** Change from `DefaultLocalResourceLoader` to support remote loading.

In the `initConfigs()` function, update each panel config to use remote resource loading:

```kotlin
override fun initConfigs() {
    // For each panel, use the default loader which supports both local and remote
    // The SDK will automatically download from GCS when remote is enabled
    
    // Filter panel - loads filters from GCS filter.bundle
    EffectOneConfigList.configure(FilterUIConfig()) {
        // Default loader will use remote when configured
    }
    
    // Face effects/stickers panel
    EffectOneConfigList.configure(EOBaseStickerUIConfig()) {
        // Default loader will use remote
    }
    
    // Music panel - loads from GCS music.bundle
    EffectOneConfigList.configure(EOBaseMusicUIConfig()) {
        // Default loader will use remote
    }
    
    // Info sticker panel
    EffectOneConfigList.configure(InfoStickerUIConfig()) {
        // Default loader will use remote
    }
    
    // Text panel
    EffectOneConfigList.configure(TextStickerUIConfig()) {
        // Default loader will use remote
    }
    
    // Video effects panel - loads from GCS ve_effect.bundle
    EffectOneConfigList.configure(EffectPanelUIConfig()) {
        // Default loader will use remote
    }
    
    // Audio filter panel - loads from GCS tone.bundle
    EffectOneConfigList.configure(AudioFilterUIConfig()) {
        // Default loader will use remote
    }
    
    // Transitions panel - loads from GCS transitions.bundle
    EffectOneConfigList.configure(TransitionUIConfig()) {
        // Default loader will use remote
    }
    
    // Canvas ratio - no resource needed
    EffectOneConfigList.configure(RatioConfig()) {
        it.defaultRatio = CanvasAspectRatio.RATIO_9_16
    }
    
    // ... keep existing RecorderInitConfig and other configs unchanged
}
```

### Step 4: Ensure Local Panel_configs Are Bundled

The SDK needs local `Panel_configs` as fallback and for initial panel structure. Make sure:

**File Location:** `android/app/src/main/assets/EffectResource/Panel_configs/`

This should contain JSON config files for each panel. Check if these exist from the BytePlus delivery.

If missing, copy from:
```
~/Downloads/fcfa54b14428eb38f4ced4ac6095984c/Android/EffectResource/Panel_configs/
```

To:
```
android/app/src/main/assets/EffectResource/Panel_configs/
```

### Step 5: Update EffectOneApp.kt (If Needed)

**File:** `android/app/src/main/kotlin/com/lykluk/lykluk/EffectOneApp.kt`

Ensure the `copyEffectResourcesIfNeeded()` function copies `Panel_configs`:

```kotlin
private fun copyEffectResourcesIfNeeded() {
    val internalResourcePath = EOUtils.pathUtil.internalResource()
    val panelConfigsPath = "$internalResourcePath/Panel_configs"
    val markerFile = File(internalResourcePath, ".resources_copied")
    
    if (!markerFile.exists()) {
        // Copy Panel_configs from assets
        copyAssetFolder("EffectResource/Panel_configs", panelConfigsPath)
        markerFile.createNewFile()
        android.util.Log.d("EffectOneApp", "✅ Panel_configs copied to internal storage")
    }
}

private fun copyAssetFolder(assetPath: String, destPath: String) {
    val assetManager = assets
    val files = assetManager.list(assetPath) ?: return
    File(destPath).mkdirs()
    
    for (file in files) {
        val assetFilePath = "$assetPath/$file"
        val destFilePath = "$destPath/$file"
        
        try {
            val subFiles = assetManager.list(assetFilePath)
            if (subFiles != null && subFiles.isNotEmpty()) {
                // It's a directory, recurse
                copyAssetFolder(assetFilePath, destFilePath)
            } else {
                // It's a file, copy it
                assetManager.open(assetFilePath).use { input ->
                    File(destFilePath).outputStream().use { output ->
                        input.copyTo(output)
                    }
                }
            }
        } catch (e: Exception) {
            android.util.Log.e("EffectOneApp", "Error copying $assetFilePath: ${e.message}")
        }
    }
}
```

### Step 6: Add Internet Permission (Already Should Exist)

**File:** `android/app/src/main/AndroidManifest.xml`

Verify these permissions exist:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

---

## Key Files to Modify

| File | What to Change |
|------|----------------|
| `EOQuickInitHelper.kt` | Add `configureRemoteResources()`, update `resourceInit()` |
| `EffectOneApp.kt` | Ensure `Panel_configs` are copied to internal storage |
| `assets/EffectResource/Panel_configs/` | Add/verify panel config JSON files |

---

## What NOT to Modify

⛔ **DO NOT** change these files/flows:
- `ExportActivity.kt` or export-related code
- `MainActivity.kt` video upload flow
- Existing `prepareAndInit()` auth flow
- Any upload/export method channel handlers
- License file configuration

---

## Testing Checklist

After implementation, test:

- [ ] App launches without crashes
- [ ] BytePlus auth still succeeds
- [ ] Open BytePlus recorder - filters appear and are downloadable
- [ ] Apply a filter - it downloads and works
- [ ] Open music panel - music tracks appear
- [ ] Apply music - it downloads and plays
- [ ] Stickers/effects panel shows items
- [ ] Stickers download and apply correctly
- [ ] **Video export still works** (critical!)
- [ ] **Video upload to server still works** (critical!)

---

## Troubleshooting

### Filters Not Loading
1. Check logcat for "EOQuickInitHelper" logs
2. Verify GCS URL is accessible: `https://storage.googleapis.com/lykluk-pub-appfiles/byteplus/resource/filter.bundle/`
3. Check if `Panel_configs` exist in internal storage

### Network Errors
1. Verify internet permission
2. Check if device has internet connectivity
3. Look for SSL/TLS errors in logcat

### Resources Download But Don't Apply
1. Check if ModelResource.bundle is accessible
2. Verify license file is valid and not expired
3. Check SDK logs for decryption errors

### Export Breaks After Changes
1. **REVERT ALL CHANGES** - do not push broken export
2. The export flow is different from iOS - don't try to unify them
3. Export uses `ExportActivity.kt` and existing method channels

---

## Reference: iOS Implementation (for comparison only)

The iOS implementation in `ios/Runner/EffectOneModule.swift` uses:

```swift
// iOS GCS Configuration
let cloudFunctionsBaseUrl = "https://us-central1-lykluk-467006.cloudfunctions.net"
let gcsPublicBaseUrl = "https://storage.googleapis.com/lykluk-pub-appfiles/byteplus/resource"

let addrConfig = EORemoteAddrConfig(
    configDomain: cloudFunctionsBaseUrl,
    configPath: "/byteplusConfig",
    resourceDomain: gcsPublicBaseUrl,
    resourcePath: "",
    modelDomain: gcsPublicBaseUrl,
    modelPath: "/ModelResource.bundle"
)
addrConfig.iconUrlPrefix = "\(gcsPublicBaseUrl)/Resource_icons/"

EOSDK.setRemoteAddrConfig(addrConfig)
EOSDK.useRemoteConfig(true, useRemoteResource: true)
```

Android should use equivalent Kotlin code but **keep Android-specific implementations intact**.

---

## Summary

1. **Add remote GCS configuration** to `EOQuickInitHelper.kt`
2. **Remove or update `DefaultLocalResourceLoader`** to allow remote loading
3. **Ensure Panel_configs are bundled** in assets
4. **DO NOT touch export/upload code**
5. **Test thoroughly** before committing

---

## Contact

If filters still don't work after following this guide:
1. Check BytePlus SDK version compatibility
2. Verify GCS bucket permissions (should be public)
3. Contact BytePlus support with Android-specific logs

**License expires:** 2025-12-31  
**SDK Version:** 1.8.0 (build 472)  
**Bundle ID:** `com.lykluk.lykluk`

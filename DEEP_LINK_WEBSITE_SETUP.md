# Deep Link Website Setup for lykluk.com

This guide provides complete instructions for configuring your `lykluk.com` website to support Universal Links (iOS) and App Links (Android) for the Lykluk mobile app.

---

## Overview

Deep links allow users to:
- **Share video links** (`https://lykluk.com/watch/{uuid}`) that open directly in the app
- **Share profile links** (`https://lykluk.com/u/@username`) that open directly in the app

When a user clicks these links:
1. If the app is installed → Opens the app directly to the video/profile
2. If the app is NOT installed → Opens the website (you can redirect to App Store/Play Store)

---

## Part 1: iOS Universal Links Setup

### Step 1: Create the Apple App Site Association (AASA) File

Create a file named `apple-app-site-association` (no file extension) with this exact content:

```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "TEAM_ID.com.lykluk.app",
        "paths": [
          "/u/*",
          "/watch/*"
        ]
      }
    ]
  }
}
```

### Step 2: Find Your Apple Team ID

1. Go to [Apple Developer Portal](https://developer.apple.com/account)
2. Sign in with your Apple Developer account
3. Click on **Membership** in the left sidebar
4. Your **Team ID** is displayed (10-character alphanumeric string, e.g., `ABC123DEF4`)

### Step 3: Update the AASA File

Replace `TEAM_ID` in the file with your actual Team ID:

```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "ABC123DEF4.com.lykluk.app",
        "paths": [
          "/u/*",
          "/watch/*"
        ]
      }
    ]
  }
}
```

### Step 4: Host the AASA File

Upload the file to your web server at **one of these locations**:

**Option A (Recommended):**
```
https://lykluk.com/.well-known/apple-app-site-association
```

**Option B (Alternative):**
```
https://lykluk.com/apple-app-site-association
```

### Step 5: Configure Web Server Headers

The file MUST be served with specific headers. Configure your web server:

#### For Nginx:
```nginx
location /.well-known/apple-app-site-association {
    default_type application/json;
    add_header Content-Type application/json;
}
```

#### For Apache (.htaccess):
```apache
<Files "apple-app-site-association">
    Header set Content-Type "application/json"
</Files>
```

#### For Vercel (vercel.json):
```json
{
  "headers": [
    {
      "source": "/.well-known/apple-app-site-association",
      "headers": [
        { "key": "Content-Type", "value": "application/json" }
      ]
    }
  ]
}
```

#### For Firebase Hosting (firebase.json):
```json
{
  "hosting": {
    "headers": [
      {
        "source": "/.well-known/apple-app-site-association",
        "headers": [
          { "key": "Content-Type", "value": "application/json" }
        ]
      }
    ]
  }
}
```

### Step 6: AASA File Requirements Checklist

- [ ] File is named exactly `apple-app-site-association` (no `.json` extension)
- [ ] File is in the `/.well-known/` directory
- [ ] Served over HTTPS (not HTTP)
- [ ] Content-Type header is `application/json`
- [ ] No redirects when accessing the URL
- [ ] File is publicly accessible (no authentication required)
- [ ] Valid JSON format (no syntax errors)

---

## Part 2: Android App Links Setup

### Step 1: Create the Asset Links File

Create a file named `assetlinks.json` with this content:

```json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.lykluk.lykluk",
      "sha256_cert_fingerprints": [
        "YOUR_SHA256_FINGERPRINT_HERE"
      ]
    }
  }
]
```

### Step 2: Get Your SHA256 Certificate Fingerprint

#### For Debug/Development:
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

#### For Release/Production:
```bash
keytool -list -v -keystore /path/to/your/release-keystore.jks -alias your-key-alias
```

Look for the line that says `SHA256:` and copy the fingerprint (format: `AA:BB:CC:DD:...`)

### Step 3: Update the Asset Links File

Replace `YOUR_SHA256_FINGERPRINT_HERE` with your actual fingerprint:

```json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.lykluk.lykluk",
      "sha256_cert_fingerprints": [
        "FA:C6:17:45:DC:09:03:78:6F:B9:ED:E6:2A:96:2B:39:9F:73:48:F0:BB:6F:89:9B:83:32:66:75:91:03:3B:9C"
      ]
    }
  }
]
```

**Note:** For production, you may need BOTH debug and release fingerprints:

```json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.lykluk.lykluk",
      "sha256_cert_fingerprints": [
        "DEBUG_SHA256_FINGERPRINT",
        "RELEASE_SHA256_FINGERPRINT"
      ]
    }
  }
]
```

### Step 4: Host the Asset Links File

Upload the file to your web server at:
```
https://lykluk.com/.well-known/assetlinks.json
```

### Step 5: Configure Web Server Headers

#### For Nginx:
```nginx
location /.well-known/assetlinks.json {
    default_type application/json;
    add_header Content-Type application/json;
}
```

#### For Vercel (vercel.json):
```json
{
  "headers": [
    {
      "source": "/.well-known/assetlinks.json",
      "headers": [
        { "key": "Content-Type", "value": "application/json" }
      ]
    }
  ]
}
```

---

## Part 3: Complete .well-known Directory Setup

Your `/.well-known/` directory should contain:

```
lykluk.com/
└── .well-known/
    ├── apple-app-site-association    (iOS)
    └── assetlinks.json               (Android)
```

---

## Part 4: Web Page Fallback (Optional but Recommended)

When users without the app click deep links, they should see a useful page. Create these routes on your website:

### Video Page (`/watch/{uuid}`)

Create a page at `https://lykluk.com/watch/[uuid]` that:
1. Shows video information (thumbnail, title, description)
2. Includes App Store / Play Store download buttons
3. Has Open Graph meta tags for social sharing

Example meta tags:
```html
<meta property="og:title" content="Watch this video on Lykluk">
<meta property="og:description" content="Download Lykluk to watch this video">
<meta property="og:image" content="https://lykluk.com/video-thumbnail.jpg">
<meta property="og:url" content="https://lykluk.com/watch/uuid-here">
<meta property="og:type" content="video.other">
```

### Profile Page (`/u/{username}`)

Create a page at `https://lykluk.com/u/[username]` that:
1. Shows user profile information
2. Includes App Store / Play Store download buttons
3. Has Open Graph meta tags for social sharing

Example meta tags:
```html
<meta property="og:title" content="@username on Lykluk">
<meta property="og:description" content="Check out @username's profile on Lykluk">
<meta property="og:image" content="https://lykluk.com/user-avatar.jpg">
<meta property="og:url" content="https://lykluk.com/u/username">
<meta property="og:type" content="profile">
```

---

## Part 5: Testing & Validation

### Test iOS Universal Links

1. **Apple's Validation Tool:**
   ```
   https://search.developer.apple.com/appsearch-validation-tool/
   ```
   Enter: `https://lykluk.com`

2. **Direct URL Test:**
   Open in browser and verify valid JSON:
   ```
   https://lykluk.com/.well-known/apple-app-site-association
   ```

3. **On-Device Test:**
   - Install the app on an iOS device
   - Send yourself a link via Messages or Notes: `https://lykluk.com/watch/test-uuid`
   - Long-press the link - you should see "Open in Lykluk" option
   - Tap the link - should open the app directly

### Test Android App Links

1. **Google's Validation Tool:**
   ```
   https://developers.google.com/digital-asset-links/tools/generator
   ```

2. **Direct URL Test:**
   Open in browser and verify valid JSON:
   ```
   https://lykluk.com/.well-known/assetlinks.json
   ```

3. **ADB Verification (on connected device):**
   ```bash
   adb shell pm get-app-links com.lykluk.lykluk
   ```

4. **On-Device Test:**
   - Install the app on an Android device
   - Open a link in Chrome: `https://lykluk.com/watch/test-uuid`
   - Should open the app directly (or show app chooser)

---

## Part 6: Troubleshooting

### iOS Issues

| Problem | Solution |
|---------|----------|
| Links open in Safari | Check AASA file is valid JSON, no redirects, correct Team ID |
| "Open in App" not appearing | Reinstall app, check entitlements match AASA |
| Works in dev, not production | Verify production Team ID and bundle ID |

### Android Issues

| Problem | Solution |
|---------|----------|
| Links open in browser | Verify SHA256 fingerprint matches your signing key |
| App chooser appears | assetlinks.json may have wrong package name |
| Works in debug, not release | Add release keystore fingerprint to assetlinks.json |

### Common Issues

| Problem | Solution |
|---------|----------|
| 404 on .well-known files | Create the `.well-known` directory, check file permissions |
| Wrong Content-Type | Configure server to serve as `application/json` |
| Redirects breaking links | Serve files directly without any redirects |

---

## Quick Reference: Final File Contents

### `/.well-known/apple-app-site-association`
```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "YOUR_TEAM_ID.com.lykluk.app",
        "paths": ["/u/*", "/watch/*"]
      }
    ]
  }
}
```

### `/.well-known/assetlinks.json`
```json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.lykluk.lykluk",
      "sha256_cert_fingerprints": ["YOUR_SHA256_FINGERPRINT"]
    }
  }
]
```

---

## Checklist Summary

### iOS Setup
- [ ] Created `apple-app-site-association` file
- [ ] Replaced `TEAM_ID` with actual Apple Team ID
- [ ] Uploaded to `/.well-known/` directory
- [ ] Configured Content-Type header
- [ ] Tested with Apple validation tool
- [ ] Tested on real iOS device

### Android Setup
- [ ] Created `assetlinks.json` file
- [ ] Got SHA256 fingerprint from keystore
- [ ] Added both debug and release fingerprints (if needed)
- [ ] Uploaded to `/.well-known/` directory
- [ ] Configured Content-Type header
- [ ] Tested with Google validation tool
- [ ] Tested on real Android device

### Web Fallback (Optional)
- [ ] Created `/watch/[uuid]` page with app download links
- [ ] Created `/u/[username]` page with app download links
- [ ] Added Open Graph meta tags for social sharing

---

## Support Links

- [Apple Universal Links Documentation](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app)
- [Android App Links Documentation](https://developer.android.com/training/app-links)
- [Apple AASA Validator](https://search.developer.apple.com/appsearch-validation-tool/)
- [Google Asset Links Tool](https://developers.google.com/digital-asset-links/tools/generator)

# BytePlus EffectOne iOS SDK v1.6.0 - Missing Symbol Issue

**Date:** December 3, 2025  
**Platform:** iOS  
**SDK Version:** EffectOneKit 1.6.0  
**Issue:** Linker error - Undefined symbol `_OBJC_CLASS_$_EOExportModel`

---

## Problem Description

We are attempting to downgrade from EffectOneKit v1.8.0 to v1.6.0 to match our Android implementation (which uses v1.6.0 successfully). However, we encounter a linker error during iOS build:

```
Error (Xcode): Undefined symbol: _OBJC_CLASS_$_EOExportModel
Error (Xcode): Linker command failed with exit code 1
```

## Investigation Results

1. **Header File Check:** ✅  
   The class `EOExportModel` is declared in the EffectOneKit v1.6.0 headers:
   ```
   /ios/Pods/EffectOneKit/EffectOneKit.xcframework/ios-arm64/EffectOneKit.framework/Headers/EOExportModel.h
   ```

2. **Binary Symbol Check:** ❌  
   However, the symbol does NOT exist in the compiled binary:
   ```bash
   nm -g EffectOneKit.framework/EffectOneKit | grep "EOExportModel"
   # Result: Empty (no symbols found)
   ```

3. **Reference Code Verification:**  
   We tested with your official v1.6.0 demo code from:
   - `effectone_swift_flutter_demo`
   - `flutter_application_160_2025:12:2`
   
   Both reference projects declare usage of `EOExportModel` in the delegate:
   ```swift
   func videoEditorViewControllerTapNext(_ exportModel: EOExportModel, presentVC viewController: UIViewController)
   ```
   
   However, their EffectOneKit binaries also DO NOT contain the `EOExportModel` symbol, suggesting these demos cannot build successfully either.

## Technical Details

**Podfile Configuration:**
```ruby
pod 'EffectOneKit', '1.6.0', :source => 'https://github.com/volcengine/volcengine-specs'
pod 'EOExportUI', :path => './'
```

**Import Statements:**
```swift
import Foundation
import UIKit
import EffectOneKit
import EOExportUI
```

**Delegate Implementation (from your demo code):**
```swift
func videoEditorViewControllerTapNext(_ exportModel: EOExportModel, presentVC viewController: UIViewController) {
    EOExportViewController.startExport(with: exportModel, presentVC: viewController, delegate: self)
}
```

**Xcode Version:** 16.2.0  
**iOS Deployment Target:** iOS 13.0+  
**Device:** iPhone 12 Pro Max, iOS 18.7.1

## Steps We've Taken

1. ✅ Clean build folder
2. ✅ `pod deintegrate && pod install`
3. ✅ Updated bridging header with EffectOneKit imports
4. ✅ Verified EOExportUI compatibility
5. ✅ Matched import structure with your reference code
6. ✅ Verified v1.6.0 is correctly installed via CocoaPods

## Questions

1. **Is EffectOneKit v1.6.0 missing the compiled `EOExportModel` class?**  
   The header declares it but the binary doesn't contain the symbol.

2. **Are the v1.6.0 reference demos (`effectone_swift_flutter_demo`, `flutter_application_160`) known to be broken?**  
   They reference `EOExportModel` but the symbol doesn't exist in their installed v1.6.0 binaries either.

3. **What is the correct way to implement video export in v1.6.0?**  
   Should we avoid using `videoEditorViewControllerTapNext` delegate entirely?

4. **Is there a different v1.6.0 build we should use?**  
   Perhaps a different source or subspecs?

## Current Situation

- ✅ Android v1.6.0 working correctly
- ❌ iOS v1.6.0 cannot build due to missing `EOExportModel` symbol
- ✅ iOS v1.8.0 builds and works (but we need v1.6.0 for platform parity)

## Request

Could you please:
1. Verify if EffectOneKit v1.6.0 iOS binary is correctly packaged with all declared symbols
2. Provide working iOS v1.6.0 sample code that successfully builds
3. Advise on the correct implementation pattern for video export in v1.6.0

We need to use v1.6.0 to match our Android implementation. Any guidance would be greatly appreciated.

---

**Project Repository:** lyklukdigital/mobile_app_v2  
**Branch:** mvp-official  
**Framework:** Flutter with native iOS integration

# BytePlus/Dimeji Error Guide


Dimeji, here is a clear breakdown of what is likely causing the “No such module ‘EffectOneSDK’” issue and the exact things to check on your side. BytePlus support also confirmed that this error usually means the SDK was not added or linked correctly.

1. Confirm the BytePlus iOS SDK frameworks are actually added

Please double check that these frameworks from the BytePlus download package are inside the Xcode project:
	•	EffectOneSDK.framework
	•	TTFFmpeg.framework
	•	TTPlayerSDK.framework
	•	BytePlusEffect.framework
	•	Any other dependencies that came in the package

If these are not inside the “Frameworks” section in Xcode, the import will fail.

2. Make sure all frameworks are set to “Embed and Sign”

Go to:
Xcode, Target, General, Frameworks, Libraries and Embedded Content

Every BytePlus related framework must be set to:

Embed and Sign

If any of them are set to “Do Not Embed”, the SDK will not load and the module import will fail.

3. Add the license file (.licbag) correctly

Please confirm the license file was added to Xcode like this:
	•	Drag the .licbag file into Xcode
	•	Make sure Copy items if needed is checked
	•	Make sure the Lykluk target is selected
	•	Make sure it appears under Build Phases → Copy Bundle Resources

Also confirm that the filename inside the code matches the file in Xcode exactly. Even one character difference will break the lookup.

4. Make sure the effect resource bundles are included

BytePlus requires specific resource bundles for filters, stickers, models and effects.

These bundles must be present either in the Xcode project or downloaded during initialization. If the resource folder structure is missing, the SDK will not initialize properly.

Typical resources include:
	•	ModelResource.bundle
	•	ComposeMakeup.bundle
	•	Filters.bundle
	•	StickerResource.bundle

5. Confirm the permissions in Info.plist

Check that these keys exist, because the SDK will silently fail without them:
	•	NSCameraUsageDescription
	•	NSMicrophoneUsageDescription
	•	NSPhotoLibraryUsageDescription
	•	NSPhotoLibraryAddUsageDescription

6. Check the iOS deployment version

BytePlus typically requires iOS 12 or 13 minimum. Make sure the deployment target is not set lower than what the SDK supports.

7. Clean and rebuild

After updating anything above, run:
	1.	Product, Clean Build Folder
	2.	Rebuild the project


This issue almost always means that the SDK frameworks were not added correctly or not embedded correctly. Once the frameworks, license file and resources are correctly included, the import should work.

Let me know once you have checked these parts so we can move forward.


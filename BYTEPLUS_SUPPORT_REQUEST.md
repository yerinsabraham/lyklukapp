# BytePlus Follow-up Question - EditorConfig Property Name

## Background
Thank you for confirming that the export page can be customized! We're implementing this now.

## Question
We have created a custom `ExportActivity` class that extends `BaseActivity` and uses `EOExportManager` to handle video export with `IEOExportListener`.

**How do we configure BytePlus SDK to use our custom ExportActivity?**

We tried:
```kotlin
val editorConfig = EditorConfig().apply {
    exportActivityClazz = ExportActivity::class.java
}

EditorMainActivity.startEditorActivityFromAlbum(
    activity, 
    mediaList,
    editorConfig = editorConfig
)
```

## Specific Questions:

1. **Is `exportActivityClazz` the correct property name in `EditorConfig`?**
   - Or should it be: `exportActivity`, `exportClass`, `customExportActivity`?

2. **How do we pass EditorConfig to EditorMainActivity?**
   - Is there an overload of `startEditorActivityFromAlbum()` that accepts `EditorConfig`?
   - Or should we set it globally before launching the editor?

3. **Should we use `EffectOneConfigList.configure(EditorConfig()) { ... }`?**
   - Similar to how we configure other UI components like FilterUIConfig, RatioConfig, etc.?

4. **Can you provide sample code** showing:
   ```kotlin
   // How to configure custom export activity
   // Complete code snippet from your documentation/examples
   ```

## Our Current Setup

**SDK Version**: 1.8.0 (462)  
**License**: lykluk_test_20251027_20251130_com.lykluk.lykluk_1.8.0_462.licbag  
**Package**: com.lykluk.lykluk

**ExportActivity** (already created):
```kotlin
class ExportActivity: BaseActivity() {
    private lateinit var eoExportManager: EOExportManager
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.export)
        
        eoExportManager = EOExportManager.init(this) { success ->
            if (success) {
                runExportAction()
            }
        }
    }
    
    private fun runExportAction() {
        eoExportManager.exportVideo(
            outputPath = exportFilePath,
            outputSetting = EOOutputVideoSettings(),
            exportListener = object : IEOExportListener {
                override fun onDone(outputPath: String) {
                    // Send result to Flutter app
                    // Close BytePlus activities
                    // Return to upload screen
                }
                
                override fun onError(error: Int, msg: String?) {
                    // Handle error
                }
                
                override fun onProgress(progress: Float) {
                    // Show progress
                }
            }
        )
    }
}
```

## What We Need

Please provide:
- ✅ Exact property/method names for EditorConfig
- ✅ Complete code example showing integration
- ✅ Any additional configuration needed in AndroidManifest.xml
- ✅ Documentation link for EditorConfig API reference

Thank you!

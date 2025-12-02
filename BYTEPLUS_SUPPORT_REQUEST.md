iOS Export Delegate Implementation (EffectOneModule.swift):

// MARK: - EOExportViewControllerDelegate Methods (iOS 1.8.0 EOExportUI)
extension EffectOneModule {
    
    // Delegate method 1: Called when export completes successfully
    func exportVideoPath(_ videoPath: String, videoImage videoImg: UIImage) {
        print("✅ [BytePlus Export] Export completed!")
        print("📹 [BytePlus Export] Video path: \(videoPath)")
        
        // Send video path to Flutter
        self.parentVC.dismiss(animated: true)
        FlutterMessageManager.shared.invokeMethod(method: "exportDone", message: videoPath)
    }
    
    // Delegate method 2: Called during export with progress updates
    func exportVideoProgress(_ progress: String, state: String) {
        print("📊 [BytePlus Export] Progress: \(progress), State: \(state)")
        
        if state == "exportProcess" {
            // Send progress percentage to Flutter
            let progressString = String(format: "%.2f", progress)
            FlutterMessageManager.shared.invokeMethod(method: "exportProcess", message: progressString)
        } else if state == "exportError" {
            // Export failed - dismiss and notify Flutter
            self.parentVC.dismiss(animated: true)
            FlutterMessageManager.shared.invokeMethod(method: "exportError", message: "export error")
        }
    }
}

This matches your reference code exactly (lines 400-412 from flutter_application_160_2025:12:2).

Both delegate methods are implemented using FlutterMessageManager.shared pattern as shown in your reference.



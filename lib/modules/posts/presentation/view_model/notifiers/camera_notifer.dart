import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final cameraControllerProvider =
    StateNotifierProvider<CameraControllerNotifier, CameraController?>(
      (ref) => CameraControllerNotifier()..initialize(),
    );

/// StateNotifier that manages the camera lifecycle + permissions
class CameraControllerNotifier extends StateNotifier<CameraController?>
    with WidgetsBindingObserver {
  CameraControllerNotifier() : super(null) {
    WidgetsBinding.instance.addObserver(this);
  }

  /// Initialize the camera if not already initialized
  Future<bool> initialize() async {
    // Request permissions
    final statuses = await [Permission.camera, Permission.microphone].request();

    if (!statuses[Permission.camera]!.isGranted ||
        !statuses[Permission.microphone]!.isGranted) {
      return false;
    }

    // Already initialized
    if (state != null && state!.value.isInitialized) {
      return true;
    }

    final cameras = await availableCameras();
    if (cameras.isEmpty) return false;

    final controller = CameraController(
      cameras.first,
      ResolutionPreset.medium, // medium avoids memory/buffer issues
      enableAudio: true,
    );

    await controller.initialize();
    state = controller;
    return true;
  }

  /// Dispose current controller
  void clear() {
    state?.dispose();
    state = null;
  }

  /// Handle app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    final controller = state;

    if (controller == null || !controller.value.isInitialized) return;

    if (lifecycleState == AppLifecycleState.inactive ||
        lifecycleState == AppLifecycleState.paused) {
      clear();
    } else if (lifecycleState == AppLifecycleState.resumed) {
      initialize();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    clear();
    super.dispose();
  }
}

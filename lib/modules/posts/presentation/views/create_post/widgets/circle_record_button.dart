import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/view_model/notifiers/video_upload_notifier.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';
import 'package:permission_handler/permission_handler.dart';

class CircleRecordButton extends HookConsumerWidget {
  const CircleRecordButton({super.key, required this.onToggle});
  final Future<void> Function(bool isRecording) onToggle;

  Future<bool> _ensureCameraReady(WidgetRef ref) async {
    final statuses = await [Permission.camera, Permission.microphone].request();

    if (!statuses[Permission.camera]!.isGranted ||
        !statuses[Permission.microphone]!.isGranted) {
      ToastNotification.showSimpleNotification(
        title: 'Camera & microphone permissions required',
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecording = ref.watch(isRecordingProvider);

    // animation controller managed by hooks
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    // 👇 run this whenever `isRecording` changes
    useEffect(() {
      if (isRecording) {
        controller.forward();
      } else {
        controller.reverse();
      }
      return null; // no cleanup needed
    }, [isRecording]);

    return GestureDetector(
      onTap: () async {
        final ready = await _ensureCameraReady(ref);
        if (!ready) return;

        final newState = !isRecording;
        ref.read(isRecordingProvider.notifier).state = newState;
        await onToggle(newState);
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final outerSize = 74.0 + (controller.value * 10);
          final innerSize = 58.0 - (controller.value * 10);

          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: outerSize,
                height: outerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: .1),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: innerSize,
                height: innerSize,
                decoration: BoxDecoration(
                  shape: isRecording ? BoxShape.rectangle : BoxShape.circle,
                  // borderRadius: isRecording ? BorderRadius.circular(12) : null,
                  color: Colors.purple,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

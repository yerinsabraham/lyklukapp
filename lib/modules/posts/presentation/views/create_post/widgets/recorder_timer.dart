import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecordingTimer extends ConsumerStatefulWidget {
  const RecordingTimer({super.key});

  @override
  ConsumerState<RecordingTimer> createState() => _RecordingTimerState();
}

class _RecordingTimerState extends ConsumerState<RecordingTimer> {
  late final Stopwatch _stopwatch;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _ticker = Ticker((_) => setState(() {}))..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = _stopwatch.elapsed;
    final minutes = elapsed.inMinutes.toString().padLeft(2, '0');
    final seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');

    return Text(
      '$minutes:$seconds',
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 12.sp,
      ),
    );
  }
}

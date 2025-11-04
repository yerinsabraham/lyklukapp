// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:byteplus_bd_file_upload/core/api.dart';
// import 'package:byteplus_bd_file_upload/core/callback/video.dart';
// import 'package:byteplus_bd_file_upload/core/env.dart';
// import 'package:byteplus_bd_file_upload/core/upload.dart';
// import 'package:byteplus_vod/ve_vod.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lykluk/core/others/logger_service.dart';
// import 'package:lykluk/modules/home/presentation/video_feed/video_constants.dart';
// import 'package:permission_handler/permission_handler.dart';

// class LykLukVodPlayer extends StatefulWidget {
//   const LykLukVodPlayer({
//     super.key,
//     required this.url,
//     this.cacheKey,
//     required this.bottomSeek,
//   });

//   /// Media URL to play
//   final String url;

//   /// Optional cache key for BytePlus player (can be null)
//   final String? cacheKey;

//   final double bottomSeek;

//   @override
//   State<StatefulWidget> createState() => _LykLukVodPlayerState();
// }

// class _LykLukVodPlayerState extends State<LykLukVodPlayer>
//     with WidgetsBindingObserver {
//   final ImagePicker picker = ImagePicker();
//   VodPlayerFlutter player = VodPlayerFlutter();
//   TTVideoPlayerView? playerView;

//   // playback/UI state
//   bool _isPlaying = false;
//   bool _showOverlay = true;
//   bool _isDragging = false;
//   Duration _position = Duration.zero;
//   Duration _duration = Duration.zero;

//   Timer? _overlayHideTimer;
//   Timer? _progressTimer;

//   // upload fields
//   String video = '';
//   String filename = '';

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _enterImmersive(); // immersive + autorotate
//     initPlayerState();
//     initUploadState();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _overlayHideTimer?.cancel();
//     _progressTimer?.cancel();
//     player.stop();
//     _exitImmersive(); // restore system UI & orientations
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive) {
//       _pause();
//     }
//   }

//   // keep immersive across rotation/metrics changes (Android sometimes exits)
//   @override
//   void didChangeMetrics() {
//     // re-apply immersive when system bars try to reappear
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   }

//   // --------- system UI / orientation -----------------------------------------

//   void _enterImmersive() {
//     // Allow portrait + landscape, keep upside-down off (optional)
//     SystemChrome.setPreferredOrientations(const [
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   }

//   void _exitImmersive() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//   }

//   // ---- init player & polling -------------------------------------------------
//   Future<void> initPlayerState() async {
//     await FlutterTTSDKManager.openAllLog();
//     TTFLogger.onLog = (level, msg) => log.d(msg);

//     const String licPath = 'assets/BPVod.lic';
//     final String channel =
//         Platform.isAndroid ? 'test_channel_android' : 'App Store';

//     final TTSDKVodConfiguration vodConfig =
//         TTSDKVodConfiguration()..cacheMaxSize = 300 * 1024 * 1024;

//     final TTSDKConfiguration sdkConfig =
//         TTSDKConfiguration.defaultConfigurationWithAppIDAndLicPath(
//           appID: '796977', // ← ensure matches license
//           licenseFilePath: licPath, // ← ensure this asset exists in this app
//           channel: channel,
//         );
//     sdkConfig.vodConfiguration = vodConfig;
//     sdkConfig.appName = "test_sdk01";
//     sdkConfig.appVersion = "1.1.1";
//     FlutterTTSDKManager.startWithConfiguration(sdkConfig);

//     FlutterTTSDKManager.setCurrentUserUniqueID('test_1234');

//     await player.createPlayer();

//     const nativeViewType = NativeViewType.SurfaceView;
//     playerView = TTVideoPlayerView(
//       onPlatformViewCreated: (int viewId) async {
//         player.setPlayerContainerView(viewId);

//         final url =
//             widget.url.isNotEmpty ? widget.url : AppConstant.ttVImageSource;
//         final cacheKey = widget.cacheKey ?? AppConstant.ttVImageCache;
//         final TTVideoEngineUrlSource source =
//             TTVideoEngineUrlSource.initWithURL(url, cacheKey);

//         player.setMediaSource(source);

//         await _play();
//         _startProgressPolling();
//       },
//       nativeViewType: nativeViewType,
//     );

//     if (!mounted) return;
//     setState(() {});
//   }

//   void _startProgressPolling() {
//     _progressTimer?.cancel();
//     _progressTimer = Timer.periodic(const Duration(milliseconds: 250), (
//       _,
//     ) async {
//       try {
//         final Duration pos = await player.position;
//         final Duration dur = await player.duration;

//         if (!mounted || _isDragging) return;

//         setState(() {
//           _position = pos;
//           _duration =
//               dur.inMilliseconds <= 0 ? const Duration(milliseconds: 1) : dur;
//         });
//       } catch (ex) {
//         // ignore until prepared
//         log.d('Progress Polling Error: ${ex.toString()}');
//       }
//     });
//   }

//   // ---- controls --------------------------------------------------------------

//   void _toggleOverlay([bool? show]) {
//     setState(() => _showOverlay = show ?? !_showOverlay);
//     _overlayHideTimer?.cancel();
//     if (_showOverlay && _isPlaying && !_isDragging) {
//       _overlayHideTimer = Timer(const Duration(seconds: 2), () {
//         if (mounted) setState(() => _showOverlay = false);
//       });
//     }
//   }

//   Future<void> _play() async {
//     await player.play();
//     if (mounted) setState(() => _isPlaying = true);
//     _toggleOverlay(true);
//   }

//   Future<void> _pause() async {
//     await player.pause();
//     if (mounted) setState(() => _isPlaying = false);
//     _toggleOverlay(true);
//   }

//   Future<void> _togglePlayPause() async {
//     if (_isPlaying) {
//       await _pause();
//     } else {
//       await _play();
//     }
//   }

//   // Double-tap seek (±10s)
//   Future<void> _seekRelative(int deltaMs) async {
//     final int current = _position.inMilliseconds;
//     final int total =
//         (_duration.inMilliseconds == 0) ? 1 : _duration.inMilliseconds;
//     final int target = (current + deltaMs).clamp(0, total).toInt();
//     await player.seekToTimeMs(time: target.toDouble());
//     if (!mounted) return;
//     setState(() => _position = Duration(milliseconds: target));
//     _toggleOverlay(true);
//   }

//   // Horizontal drag scrubbing
//   double _dragStartFraction = 0.0;

//   void _onDragStart(DragStartDetails d, BoxConstraints c) {
//     _isDragging = true;
//     _dragStartFraction =
//         (c.maxWidth == 0) ? 0 : (d.localPosition.dx / c.maxWidth);
//     _pause();
//     _toggleOverlay(true);
//   }

//   Future<void> _onDragUpdate(DragUpdateDetails d, BoxConstraints c) async {
//     if (!_isDragging || _duration == Duration.zero) return;
//     final double width = c.maxWidth == 0 ? 1.0 : c.maxWidth;
//     final double deltaFraction = d.delta.dx / width;
//     final int total = _duration.inMilliseconds;
//     final int target =
//         ((_dragStartFraction + deltaFraction).clamp(0.0, 1.0) * total).toInt();
//     setState(() => _position = Duration(milliseconds: target));
//   }

//   Future<void> _onDragEnd() async {
//     if (!_isDragging) return;
//     _isDragging = false;
//     await player.seekToTimeMs(time: _position.inMilliseconds.toDouble());
//     _play();
//   }

//   String _format(Duration d) {
//     String two(int n) => n.toString().padLeft(2, '0');
//     final h = d.inHours;
//     final m = d.inMinutes.remainder(60);
//     final s = d.inSeconds.remainder(60);
//     return h > 0 ? '$h:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
//   }

//   // ---- upload ---------------------------------------------------------------

//   Future<void> initUploadState() async {
//     EnvOptions options = EnvOptions(
//       appID: AppConstant.appId,
//       appChannel: AppConstant.appChannel,
//       appVersion: AppConstant.appVersion,
//       appName: AppConstant.appName,
//       openAppLog: true,
//       autoStartAppLog: true,
//       debugLogLevel: true,
//       enableLocalLogPrint: true,
//       enableLogCallback: true,
//     );
//     await initEnv(options);
//   }

//   Future<void> uploadVd() async {
//     // Depending on SDK/Android version you may need READ_MEDIA_VIDEO or storage permission mapping
//     await [Permission.videos].request();
//     final XFile? file = await picker.pickVideo(source: ImageSource.gallery);
//     if (file == null) return;

//     video = file.path;
//     filename = file.path.split('/').last;

//     final options = VideoUploaderOptions(
//       accessKey: AppConstant.accessKey,
//       secretKey: AppConstant.secretKey,
//       sessionToken: AppConstant.sessionToken,
//       serviceID: AppConstant.serviceId,
//       filePaths: [video],
//     );

//     final BDVideoUploader uploader = await initVideoUploader(options);
//     await uploader.start();
//     await _seeProgress(uploader);
//   }

//   Future<void> _seeProgress(BDVideoUploader uploader) async {
//     await uploader.setListener(
//       VideoUploaderInfoCallback(
//         onUploadSuccess: (uploadInfo) async {
//           log.d('--- onUploadSuccess: ${jsonEncode(uploadInfo)}');

//           await uploader.close();
//         },
//         onUploadFail: (errorCode, errorMsg, uploadInfo) async {
//           log.d(
//             '--- onUploadFail: $errorCode, $errorMsg, ${jsonEncode(uploadInfo)}',
//           );

//           await uploader.close();
//         },
//         onUpdateProgress: (progress) {
//           log.d('--- progress: $progress');
//         },
//       ),
//     );
//   }

//   // ---- UI --------------------------------------------------------------------

//   @override
//   Widget build(BuildContext context) {
//     final view = playerView ?? const SizedBox.shrink();

//     return Scaffold(
//       backgroundColor: Colors.black,
//       // We manage insets manually for perfect fullscreen
//       body: OrientationBuilder(
//         builder: (context, orientation) {
//           final mq = MediaQuery.of(context);
//           final bool isLandscape = orientation == Orientation.landscape;

//           // In landscape, safe areas on sides may appear (notches); keep a tiny inset
//           final double sidePad = isLandscape ? 12 : 16;
//           final double bottomPad = isLandscape ? widget.bottomSeek : 10;

//           final double pos = _position.inMilliseconds.toDouble();
//           final double dur =
//               _duration.inMilliseconds == 0
//                   ? 1.0
//                   : _duration.inMilliseconds.toDouble();
//           final double progress = (pos / dur).clamp(0.0, 1.0);

//           return Stack(
//             fit: StackFit.expand,
//             children: [
//               // Video surface
//               view,

//               // Gesture layer
//               GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: _togglePlayPause, // single tap = toggle
//                 onDoubleTapDown: (details) {
//                   final dx = details.localPosition.dx;
//                   final leftHalf = dx < mq.size.width / 2;
//                   _seekRelative(leftHalf ? -10000 : 10000); // ±10s
//                 },
//                 onHorizontalDragStart:
//                     (d) => _onDragStart(d, BoxConstraints.tight(mq.size)),
//                 onHorizontalDragUpdate:
//                     (d) => _onDragUpdate(d, BoxConstraints.tight(mq.size)),
//                 onHorizontalDragEnd: (_) => _onDragEnd(),
//               ),

//               // Overlays
//               if (_showOverlay) ...[
//                 // center play/pause glyph
//                 Center(
//                   child: AnimatedOpacity(
//                     duration: const Duration(milliseconds: 120),
//                     opacity: 1,
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: const BoxDecoration(
//                         color: Colors.black54,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         _isPlaying
//                             ? Icons.pause_rounded
//                             : Icons.play_arrow_rounded,
//                         size: 64,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Bottom scrub bar + time (adapts to orientation)
//                 Positioned(
//                   left: sidePad,
//                   right: sidePad,
//                   bottom: bottomPad + mq.padding.bottom, // respect bottom inset
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       SliderTheme(
//                         data: SliderTheme.of(context).copyWith(
//                           trackHeight: isLandscape ? 2.0 : 2.5,
//                           thumbShape: const RoundSliderThumbShape(
//                             enabledThumbRadius: 6,
//                           ),
//                           overlayShape: SliderComponentShape.noOverlay,
//                         ),
//                         child: Slider(
//                           value: progress.isNaN ? 0 : progress,
//                           onChanged: (v) {
//                             setState(() {
//                               _isDragging = true;
//                               _position = Duration(
//                                 milliseconds:
//                                     (v * _duration.inMilliseconds).toInt(),
//                               );
//                             });
//                             _toggleOverlay(true);
//                           },
//                           onChangeStart: (_) {
//                             _pause();
//                             _isDragging = true;
//                           },
//                           onChangeEnd: (v) async {
//                             _isDragging = false;
//                             final int target =
//                                 (v * _duration.inMilliseconds).toInt();
//                             await player.seekToTimeMs(time: target.toDouble());
//                             _play();
//                           },
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             _format(_position),
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Text(
//                             _format(_duration),
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Top back + upload (respect notches)
//                 // Positioned(
//                 //   top: mq.padding.top + 8,
//                 //   left: 8,
//                 //   right: 8,
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //     children: [
//                 // ChromeButton(
//                 //   icon: Icons.arrow_back_ios_new_rounded,
//                 //   onTap: () {
//                 //     _pause();
//                 //     Navigator.of(context).maybePop();
//                 //   },
//                 // ),
//                 //       Row(
//                 //         children: [
//                 //           ChromeButton(
//                 //             icon: Icons.file_upload_outlined,
//                 //             onTap: uploadVd,
//                 //           ),
//                 //         ],
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//               ],
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class ChromeButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;
//   const ChromeButton({super.key, required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black45,
//       shape: const StadiumBorder(),
//       child: InkWell(
//         onTap: onTap,
//         customBorder: const StadiumBorder(),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           child: Icon(icon, color: Colors.white, size: 18),
//         ),
//       ),
//     );
//   }
// }

// class VodSource {
//   VodSource(this.url, {this.cacheKey});
//   final String url;
//   final String? cacheKey;
// }

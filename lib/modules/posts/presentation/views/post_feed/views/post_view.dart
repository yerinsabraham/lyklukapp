import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../../../data/model/post_model.dart';
import '../widgets/post_feed.dart';


class PostView extends StatefulWidget {
  final PostModel reel;
  const PostView({super.key, required this.reel});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.reel.url));
    controller.initialize().then((_) {
       controller.setLooping(true);
      controller.play();
      setState(() {});
    });
    controller.setLooping(true);
    controller.play();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(bottom: 50.h),
            child: PostReel(
              reel: widget.reel,
              controller: controller,
            ),
          ),

          Positioned(
            top: 60.h,
            left: 20.w,
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.grey.withValues(alpha: 0.5),
                ),
              ),

              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.close, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class ImageContainer extends StatelessWidget {
  final Widget? placeholder;
  final Widget? errorWidget;
  final double height;
  final double width;
  final String? url;
  final double radius;
  const ImageContainer({
    super.key,
    this.errorWidget,
    this.placeholder,
    this.url,
    this.height = 50,
    this.width = 50,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return placeholder?? Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
           border: Border.all(color: context.colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(radius),
          // color: context.colorScheme.onSecondary,
        ),
        child: Center(
          child: Icon(Icons.image_not_supported, 
          color: context.colorScheme.primary,
           size: height/2,),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: url??"",
      errorWidget: (c, __, ___) => errorWidget ?? Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(radius),
          // color: context.colorScheme.onSecondary,
        ),
        child: Icon(Icons.image_not_supported, 
        color: context.colorScheme.primary,
         size: height/2,),
      ),
      // placeholder: (context, url) => placeholder ?? SizedBox.shrink(),
      progressIndicatorBuilder:
          (context, url, progress) => SizedBox(
            height: 30.h,
            width: 30.w,
            child: Center(
              child: CircularProgressIndicator(
                value: progress.progress,
                color: context.colorScheme.primary,
              ),
            ),
          ),
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,

          decoration: BoxDecoration(
            color: context.colorScheme.secondary  ,
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              fit: BoxFit.cover

              ,image: imageProvider),
          ),
        );
      },
    );
  }
}

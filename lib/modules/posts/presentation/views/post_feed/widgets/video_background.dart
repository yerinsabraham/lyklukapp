import 'package:flutter/material.dart';

class VideoBackground extends StatelessWidget {
  final List<Color> colors;
  final List<double> stops;
  final Widget? child;

  const VideoBackground({
    super.key,
    this.colors = const [Colors.black54, Colors.black87],
    this.stops = const [0.0, 1.0],
    this.child,
  }) : assert(
         colors.length == stops.length,
         'Stops and colors must be same length',
       );

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            stops: stops,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}

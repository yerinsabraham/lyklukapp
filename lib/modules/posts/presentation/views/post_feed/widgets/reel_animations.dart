// ignore_for_file: unused_field

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';


mixin ReelAnimations implements TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _likeAnimationController;
  late Animation<double> _likeAnimation;
  final ValueNotifier<bool> _isLiked = ValueNotifier(false);

  // for swipe up and down to dismiss
  final double _dragDistance = 0.0;
  late AnimationController _dismissAnimationController;
  late Animation<double> _dismissAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _backgroundAnimation;

  void initControllers() {
    _likeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _likeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_likeAnimationController);

    _dismissAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _dismissAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_dismissAnimationController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop();
      }
    });
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(_dismissAnimationController);
    _backgroundAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.black.withValues(alpha:.5),
    ).animate(_dismissAnimationController);
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    _dismissAnimationController.dispose();
    _isLiked.dispose();
    // super.dispose();
  }

  /// getters
  double get dragDistance => _dragDistance;
    AnimationController get  dismissAnimationController => _dismissAnimationController;
}

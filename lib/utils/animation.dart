import 'package:flutter/material.dart';

Widget slideFromTop({
  required Widget child,
  required AnimationController controller,
  Curve curve = Curves.elasticOut,
  Duration duration = const Duration(milliseconds: 800),
}) {
  final Animation<Offset> slideAnimation = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: controller, curve: curve));

  return SlideTransition(
    position: slideAnimation,
    child: child,
  );
}

Widget slideFromLeft({
  required Widget child,
  required AnimationController controller,
  Curve curve = Curves.easeInOut,
  Duration duration = const Duration(milliseconds: 800),
}) {
  final Animation<Offset> slideAnimation = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: controller, curve: curve));

  return SlideTransition(
    position: slideAnimation,
    child: child,
  );
}

Widget slideFromRight({
  required Widget child,
  required AnimationController controller,
  Curve curve = Curves.bounceInOut,
  Duration duration = const Duration(milliseconds: 800),
}) {
  final Animation<Offset> slideAnimation = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: controller, curve: curve));

  return SlideTransition(
    position: slideAnimation,
    child: child,
  );
}

Widget customAnimatedPositioned({
  required bool isVisible,
  required Widget child,
  Duration duration = const Duration(seconds: 3),
  Curve curve = Curves.elasticOut,
  required double initialLeft,
  required double finalLeft,
  required double initialRight,
  required double finalRight,
  required double initialBottom,
  required double finalBottom,
}) {
  return AnimatedPositioned(
    duration: duration,
    curve: curve,
    left: isVisible ? finalLeft : initialLeft,
    right: isVisible ? finalRight : initialRight,
    bottom: isVisible ? finalBottom : initialBottom,
    child: child,
  );
}

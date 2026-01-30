import 'package:flutter/material.dart';

import 'overlay_animation_builder.dart';

/// Preset animation builders for overlays.
@immutable
abstract class OverlayAnimations {
  const OverlayAnimations._();

  /// Slide from top with fade.
  static OverlayAnimationBuilder slideFromTop({
    Curve curve = Curves.easeOutCubic,
  }) {
    return (context, animation, alignment, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }

  /// Slide from bottom with fade.
  static OverlayAnimationBuilder slideFromBottom({
    Curve curve = Curves.easeOutCubic,
  }) {
    return (context, animation, alignment, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }

  /// Slide from left with fade.
  static OverlayAnimationBuilder slideFromLeft({
    Curve curve = Curves.easeOutCubic,
  }) {
    return (context, animation, alignment, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }

  /// Slide from right with fade.
  static OverlayAnimationBuilder slideFromRight({
    Curve curve = Curves.easeOutCubic,
  }) {
    return (context, animation, alignment, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }

  /// Fade in/out animation.
  static OverlayAnimationBuilder fade({
    Curve curve = Curves.easeInOut,
  }) {
    return (context, animation, alignment, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: curve),
        child: child,
      );
    };
  }

  /// Scale with fade animation.
  static OverlayAnimationBuilder scale({
    Curve curve = Curves.easeOutBack,
    double beginScale = 0.8,
  }) {
    return (context, animation, alignment, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: beginScale, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }

  /// Bounce effect animation.
  static OverlayAnimationBuilder bounce({
    Curve curve = Curves.bounceOut,
  }) {
    return (context, animation, alignment, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: curve)),
        child: child,
      );
    };
  }

  /// Elastic effect animation.
  static OverlayAnimationBuilder elastic({
    Curve curve = Curves.elasticOut,
  }) {
    return (context, animation, alignment, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }

  /// No animation (instant).
  static OverlayAnimationBuilder none() {
    return (context, animation, alignment, child) => child;
  }

  /// Position-aware slide animation.
  /// Slides from the direction based on the alignment.
  static OverlayAnimationBuilder slideFromPosition({
    Curve curve = Curves.easeOutCubic,
  }) {
    return (context, animation, alignment, child) {
      Offset begin;
      if (alignment == Alignment.topCenter ||
          alignment == Alignment.topLeft ||
          alignment == Alignment.topRight) {
        begin = const Offset(0, -1);
      } else if (alignment == Alignment.bottomCenter ||
          alignment == Alignment.bottomLeft ||
          alignment == Alignment.bottomRight) {
        begin = const Offset(0, 1);
      } else if (alignment == Alignment.centerLeft) {
        begin = const Offset(-1, 0);
      } else if (alignment == Alignment.centerRight) {
        begin = const Offset(1, 0);
      } else {
        begin = const Offset(0, 0.2);
      }

      return SlideTransition(
        position: Tween<Offset>(
          begin: begin,
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }
}

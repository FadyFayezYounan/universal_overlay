import 'package:flutter/material.dart';

/// Builder type for overlay animations.
///
/// The builder receives:
/// - [context]: The build context
/// - [animation]: Animation controller (0.0 to 1.0)
/// - [alignment]: The alignment of the overlay
/// - [child]: The overlay widget to animate
typedef OverlayAnimationBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  AlignmentGeometry alignment,
  Widget child,
);

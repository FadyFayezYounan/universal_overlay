import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../shared/animations/overlay_animation_builder.dart';
import '../shared/enums/dismissal_reason.dart';
import '../shared/enums/loading_style.dart';

/// Configuration for loading overlay behavior.
@immutable
class LoadingConfig extends Equatable {
  /// Creates a loading configuration.
  const LoadingConfig({
    this.style = LoadingStyle.adaptive,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = false,
    this.blockInteraction = true,
    this.blockInteractionMode = BlockInteractionMode.full,
    this.allowBackButton = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationBuilder,
    this.onDismissed,
    this.onShow,
  });

  /// Loading indicator style
  final LoadingStyle style;

  /// Barrier color (background)
  final Color? barrierColor;

  /// Whether tapping the barrier dismisses the overlay
  final bool barrierDismissible;

  /// Whether to block user interaction
  final bool blockInteraction;

  /// Mode for blocking interaction
  final BlockInteractionMode blockInteractionMode;

  /// Whether to allow back button to dismiss
  final bool allowBackButton;

  /// Duration of enter/exit animations
  final Duration animationDuration;

  /// Animation builder
  final OverlayAnimationBuilder? animationBuilder;

  /// Callback when loading is dismissed
  final void Function(DismissalReason reason)? onDismissed;

  /// Callback when loading becomes visible
  final VoidCallback? onShow;

  /// Creates a copy with the given fields replaced.
  LoadingConfig copyWith({
    LoadingStyle? style,
    Color? barrierColor,
    bool? barrierDismissible,
    bool? blockInteraction,
    BlockInteractionMode? blockInteractionMode,
    bool? allowBackButton,
    Duration? animationDuration,
    OverlayAnimationBuilder? animationBuilder,
    void Function(DismissalReason reason)? onDismissed,
    VoidCallback? onShow,
  }) {
    return LoadingConfig(
      style: style ?? this.style,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      blockInteraction: blockInteraction ?? this.blockInteraction,
      blockInteractionMode: blockInteractionMode ?? this.blockInteractionMode,
      allowBackButton: allowBackButton ?? this.allowBackButton,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      onDismissed: onDismissed ?? this.onDismissed,
      onShow: onShow ?? this.onShow,
    );
  }

  @override
  List<Object?> get props => [
        style,
        barrierColor,
        barrierDismissible,
        blockInteraction,
        blockInteractionMode,
        allowBackButton,
        animationDuration,
      ];
}

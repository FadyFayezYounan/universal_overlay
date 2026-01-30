import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../shared/animations/overlay_animation_builder.dart';
import '../shared/enums/dismissal_reason.dart';
import '../shared/enums/dismissal_type.dart';
import '../shared/enums/overlay_position.dart';
import '../shared/enums/toast_display_mode.dart';
import '../shared/models/barrier_config.dart';

/// Configuration for toast display behavior.
@immutable
class ToastConfig extends Equatable {
  /// Creates a toast configuration.
  const ToastConfig({
    this.duration = const Duration(seconds: 4),
    this.position = OverlayPosition.bottom,
    this.displayMode = ToastDisplayMode.queue,
    this.dismissalTypes = const {
      DismissalType.timer,
      DismissalType.swipe,
    },
    this.swipeDismissDirection,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationBuilder,
    this.enterAnimationBuilder,
    this.exitAnimationBuilder,
    this.barrier,
    this.onDismissed,
    this.onTap,
    this.onActionPressed,
    this.onShow,
  });

  /// Duration before auto-dismiss (when timer dismissal is enabled)
  final Duration duration;

  /// Position of the toast on screen
  final OverlayPosition position;

  /// Display mode for multiple toasts
  final ToastDisplayMode displayMode;

  /// Allowed dismissal types
  final Set<DismissalType> dismissalTypes;

  /// Direction for swipe dismissal (null = auto based on position)
  final DismissDirection? swipeDismissDirection;

  /// Duration of enter/exit animations
  final Duration animationDuration;

  /// Animation builder for both enter and exit
  final OverlayAnimationBuilder? animationBuilder;

  /// Animation builder for enter only
  final OverlayAnimationBuilder? enterAnimationBuilder;

  /// Animation builder for exit only
  final OverlayAnimationBuilder? exitAnimationBuilder;

  /// Optional barrier configuration
  final BarrierConfig? barrier;

  /// Callback when toast is dismissed
  final void Function(DismissalReason reason)? onDismissed;

  /// Callback when toast is tapped
  final VoidCallback? onTap;

  /// Callback when action button is pressed
  final VoidCallback? onActionPressed;

  /// Callback when toast becomes visible
  final VoidCallback? onShow;

  /// Creates a copy with the given fields replaced.
  ToastConfig copyWith({
    Duration? duration,
    OverlayPosition? position,
    ToastDisplayMode? displayMode,
    Set<DismissalType>? dismissalTypes,
    DismissDirection? swipeDismissDirection,
    Duration? animationDuration,
    OverlayAnimationBuilder? animationBuilder,
    OverlayAnimationBuilder? enterAnimationBuilder,
    OverlayAnimationBuilder? exitAnimationBuilder,
    BarrierConfig? barrier,
    void Function(DismissalReason reason)? onDismissed,
    VoidCallback? onTap,
    VoidCallback? onActionPressed,
    VoidCallback? onShow,
  }) {
    return ToastConfig(
      duration: duration ?? this.duration,
      position: position ?? this.position,
      displayMode: displayMode ?? this.displayMode,
      dismissalTypes: dismissalTypes ?? this.dismissalTypes,
      swipeDismissDirection:
          swipeDismissDirection ?? this.swipeDismissDirection,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      enterAnimationBuilder:
          enterAnimationBuilder ?? this.enterAnimationBuilder,
      exitAnimationBuilder: exitAnimationBuilder ?? this.exitAnimationBuilder,
      barrier: barrier ?? this.barrier,
      onDismissed: onDismissed ?? this.onDismissed,
      onTap: onTap ?? this.onTap,
      onActionPressed: onActionPressed ?? this.onActionPressed,
      onShow: onShow ?? this.onShow,
    );
  }

  @override
  List<Object?> get props => [
        duration,
        position,
        displayMode,
        dismissalTypes,
        swipeDismissDirection,
        animationDuration,
        animationBuilder,
        enterAnimationBuilder,
        exitAnimationBuilder,
        barrier,
      ];
}

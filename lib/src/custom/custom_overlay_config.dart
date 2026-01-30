import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../shared/animations/overlay_animation_builder.dart';
import '../shared/enums/dismissal_reason.dart';
import '../shared/enums/dismissal_type.dart';
import '../shared/enums/overlay_position.dart';
import '../shared/models/barrier_config.dart';

/// Configuration for custom overlay behavior.
@immutable
class CustomOverlayConfig extends Equatable {
  /// Creates a custom overlay configuration.
  const CustomOverlayConfig({
    this.position = OverlayPosition.center,
    this.dismissalTypes = const {DismissalType.programmatic},
    this.barrier,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationBuilder,
    this.enterAnimationBuilder,
    this.exitAnimationBuilder,
    this.onDismissed,
    this.onShow,
  });

  /// Position of the overlay on screen
  final OverlayPosition position;

  /// Allowed dismissal types
  final Set<DismissalType> dismissalTypes;

  /// Optional barrier configuration
  final BarrierConfig? barrier;

  /// Duration of enter/exit animations
  final Duration animationDuration;

  /// Animation builder for both enter and exit
  final OverlayAnimationBuilder? animationBuilder;

  /// Animation builder for enter only
  final OverlayAnimationBuilder? enterAnimationBuilder;

  /// Animation builder for exit only
  final OverlayAnimationBuilder? exitAnimationBuilder;

  /// Callback when overlay is dismissed
  final void Function(DismissalReason reason)? onDismissed;

  /// Callback when overlay becomes visible
  final VoidCallback? onShow;

  /// Creates a copy with the given fields replaced.
  CustomOverlayConfig copyWith({
    OverlayPosition? position,
    Set<DismissalType>? dismissalTypes,
    BarrierConfig? barrier,
    Duration? animationDuration,
    OverlayAnimationBuilder? animationBuilder,
    OverlayAnimationBuilder? enterAnimationBuilder,
    OverlayAnimationBuilder? exitAnimationBuilder,
    void Function(DismissalReason reason)? onDismissed,
    VoidCallback? onShow,
  }) {
    return CustomOverlayConfig(
      position: position ?? this.position,
      dismissalTypes: dismissalTypes ?? this.dismissalTypes,
      barrier: barrier ?? this.barrier,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      enterAnimationBuilder:
          enterAnimationBuilder ?? this.enterAnimationBuilder,
      exitAnimationBuilder: exitAnimationBuilder ?? this.exitAnimationBuilder,
      onDismissed: onDismissed ?? this.onDismissed,
      onShow: onShow ?? this.onShow,
    );
  }

  @override
  List<Object?> get props => [
        position,
        dismissalTypes,
        barrier,
        animationDuration,
      ];
}

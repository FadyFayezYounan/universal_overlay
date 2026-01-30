import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../shared/animations/overlay_animation_builder.dart';
import '../shared/enums/dismissal_type.dart';
import '../shared/enums/overlay_position.dart';
import '../shared/models/barrier_config.dart';

/// Theme data for custom overlay styling.
@immutable
class CustomOverlayThemeData extends Equatable {
  /// Creates a custom overlay theme.
  const CustomOverlayThemeData({
    this.position = OverlayPosition.center,
    this.dismissalTypes = const {DismissalType.programmatic},
    this.barrier,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationBuilder,
    this.enterAnimationBuilder,
    this.exitAnimationBuilder,
  });

  /// Position of the overlay on screen
  final OverlayPosition position;

  /// Allowed dismissal types
  final Set<DismissalType> dismissalTypes;

  /// Optional barrier configuration
  final BarrierConfig? barrier;

  /// Duration of animations
  final Duration animationDuration;

  /// Animation builder for both enter and exit
  final OverlayAnimationBuilder? animationBuilder;

  /// Animation builder for enter only
  final OverlayAnimationBuilder? enterAnimationBuilder;

  /// Animation builder for exit only
  final OverlayAnimationBuilder? exitAnimationBuilder;

  /// Creates a copy with the given fields replaced.
  CustomOverlayThemeData copyWith({
    OverlayPosition? position,
    Set<DismissalType>? dismissalTypes,
    BarrierConfig? barrier,
    Duration? animationDuration,
    OverlayAnimationBuilder? animationBuilder,
    OverlayAnimationBuilder? enterAnimationBuilder,
    OverlayAnimationBuilder? exitAnimationBuilder,
  }) {
    return CustomOverlayThemeData(
      position: position ?? this.position,
      dismissalTypes: dismissalTypes ?? this.dismissalTypes,
      barrier: barrier ?? this.barrier,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      enterAnimationBuilder:
          enterAnimationBuilder ?? this.enterAnimationBuilder,
      exitAnimationBuilder: exitAnimationBuilder ?? this.exitAnimationBuilder,
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

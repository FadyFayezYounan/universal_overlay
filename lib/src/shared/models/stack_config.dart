import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../enums/stack_direction.dart';

/// Configuration for stacked overlay display.
@immutable
class StackConfig extends Equatable {
  /// Creates a stack configuration.
  const StackConfig({
    this.maxVisible = 3,
    this.spacing = 8.0,
    this.direction = StackDirection.up,
    this.overflowBehavior = StackOverflowBehavior.queue,
  });

  /// Maximum number of visible toasts
  final int maxVisible;

  /// Spacing between stacked toasts
  final double spacing;

  /// Direction new toasts push existing ones
  final StackDirection direction;

  /// Behavior when maxVisible is exceeded
  final StackOverflowBehavior overflowBehavior;

  /// Creates a copy with the given fields replaced.
  StackConfig copyWith({
    int? maxVisible,
    double? spacing,
    StackDirection? direction,
    StackOverflowBehavior? overflowBehavior,
  }) {
    return StackConfig(
      maxVisible: maxVisible ?? this.maxVisible,
      spacing: spacing ?? this.spacing,
      direction: direction ?? this.direction,
      overflowBehavior: overflowBehavior ?? this.overflowBehavior,
    );
  }

  @override
  List<Object?> get props => [maxVisible, spacing, direction, overflowBehavior];
}

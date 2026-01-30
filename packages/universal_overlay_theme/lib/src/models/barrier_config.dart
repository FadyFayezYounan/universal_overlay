import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration for overlay barrier (background).
@immutable
class BarrierConfig extends Equatable {
  /// Creates a barrier configuration.
  const BarrierConfig({
    this.color = Colors.black54,
    this.dismissible = false,
    this.label,
  });

  /// Barrier color
  final Color color;

  /// Whether tapping the barrier dismisses the overlay
  final bool dismissible;

  /// Semantic label for accessibility
  final String? label;

  /// Creates a copy with the given fields replaced.
  BarrierConfig copyWith({
    Color? color,
    bool? dismissible,
    String? label,
  }) {
    return BarrierConfig(
      color: color ?? this.color,
      dismissible: dismissible ?? this.dismissible,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [color, dismissible, label];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Progress indicator configuration for toasts.
@immutable
class ToastProgress extends Equatable {
  /// Creates a toast progress configuration.
  const ToastProgress({
    this.value,
    this.color,
    this.backgroundColor,
  });

  /// Progress value (0.0 to 1.0). Null for indeterminate.
  final double? value;

  /// Progress indicator color
  final Color? color;

  /// Progress track color
  final Color? backgroundColor;

  /// Creates a copy with the given fields replaced.
  ToastProgress copyWith({
    double? value,
    Color? color,
    Color? backgroundColor,
  }) {
    return ToastProgress(
      value: value ?? this.value,
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  List<Object?> get props => [value, color, backgroundColor];
}

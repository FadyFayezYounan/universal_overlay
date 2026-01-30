import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Action button configuration for toasts.
@immutable
class ToastAction extends Equatable {
  /// Creates a toast action.
  const ToastAction({
    required this.label,
    required this.onPressed,
    this.textStyle,
  });

  /// The action button label
  final String label;

  /// Callback when the action is pressed
  final VoidCallback onPressed;

  /// Optional text style for the action
  final TextStyle? textStyle;

  /// Creates a copy with the given fields replaced.
  ToastAction copyWith({
    String? label,
    VoidCallback? onPressed,
    TextStyle? textStyle,
  }) {
    return ToastAction(
      label: label ?? this.label,
      onPressed: onPressed ?? this.onPressed,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  List<Object?> get props => [label, textStyle];
}

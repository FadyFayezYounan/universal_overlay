import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'toast_action.dart';
import 'toast_progress.dart';

/// Content configuration for a toast.
@immutable
class ToastContent extends Equatable {
  /// Creates toast content.
  const ToastContent({
    required this.message,
    this.leading,
    this.trailing,
    this.action,
    this.progress,
  });

  /// The main message text
  final String message;

  /// Leading widget (typically an icon)
  final Widget? leading;

  /// Trailing widget (typically a close icon)
  final Widget? trailing;

  /// Action button configuration
  final ToastAction? action;

  /// Optional progress indicator
  final ToastProgress? progress;

  /// Creates a copy with the given fields replaced.
  ToastContent copyWith({
    String? message,
    Widget? leading,
    Widget? trailing,
    ToastAction? action,
    ToastProgress? progress,
  }) {
    return ToastContent(
      message: message ?? this.message,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      action: action ?? this.action,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [message, leading, trailing, action, progress];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../shared/enums/dismissal_reason.dart';

/// Callbacks for toast events.
///
/// Contains only runtime callbacks. For behavior and styling configuration,
/// use [ToastThemeData] from the universal_overlay_theme package.
@immutable
class ToastCallbacks extends Equatable {
  /// Creates toast callbacks.
  const ToastCallbacks({
    this.onDismissed,
    this.onTap,
    this.onActionPressed,
    this.onShow,
  });

  /// Callback when toast is dismissed
  final void Function(DismissalReason reason)? onDismissed;

  /// Callback when toast is tapped
  final VoidCallback? onTap;

  /// Callback when action button is pressed
  final VoidCallback? onActionPressed;

  /// Callback when toast becomes visible
  final VoidCallback? onShow;

  /// Creates a copy with the given fields replaced.
  ToastCallbacks copyWith({
    void Function(DismissalReason reason)? onDismissed,
    VoidCallback? onTap,
    VoidCallback? onActionPressed,
    VoidCallback? onShow,
  }) {
    return ToastCallbacks(
      onDismissed: onDismissed ?? this.onDismissed,
      onTap: onTap ?? this.onTap,
      onActionPressed: onActionPressed ?? this.onActionPressed,
      onShow: onShow ?? this.onShow,
    );
  }

  @override
  List<Object?> get props => [];
}

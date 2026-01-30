import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../shared/enums/dismissal_reason.dart';

/// Callbacks for loading overlay events.
///
/// Contains only runtime callbacks. For behavior and styling configuration,
/// use [LoadingThemeData] from the universal_overlay_theme package.
@immutable
class LoadingCallbacks extends Equatable {
  /// Creates loading callbacks.
  const LoadingCallbacks({
    this.onDismissed,
    this.onShow,
  });

  /// Callback when loading is dismissed
  final void Function(DismissalReason reason)? onDismissed;

  /// Callback when loading becomes visible
  final VoidCallback? onShow;

  /// Creates a copy with the given fields replaced.
  LoadingCallbacks copyWith({
    void Function(DismissalReason reason)? onDismissed,
    VoidCallback? onShow,
  }) {
    return LoadingCallbacks(
      onDismissed: onDismissed ?? this.onDismissed,
      onShow: onShow ?? this.onShow,
    );
  }

  @override
  List<Object?> get props => [];
}

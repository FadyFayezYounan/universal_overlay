import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../shared/enums/dismissal_reason.dart';

/// Callbacks for custom overlay events.
///
/// Contains only runtime callbacks. For behavior and styling configuration,
/// use [CustomOverlayThemeData] from the universal_overlay_theme package.
@immutable
class CustomOverlayCallbacks extends Equatable {
  /// Creates custom overlay callbacks.
  const CustomOverlayCallbacks({
    this.onDismissed,
    this.onShow,
  });

  /// Callback when overlay is dismissed
  final void Function(DismissalReason reason)? onDismissed;

  /// Callback when overlay becomes visible
  final VoidCallback? onShow;

  /// Creates a copy with the given fields replaced.
  CustomOverlayCallbacks copyWith({
    void Function(DismissalReason reason)? onDismissed,
    VoidCallback? onShow,
  }) {
    return CustomOverlayCallbacks(
      onDismissed: onDismissed ?? this.onDismissed,
      onShow: onShow ?? this.onShow,
    );
  }

  @override
  List<Object?> get props => [];
}

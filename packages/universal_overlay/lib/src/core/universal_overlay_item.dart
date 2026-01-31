import 'dart:async';

import '../shared/enums/dismissal_reason.dart';

/// Controller for an individual overlay item.
///
/// Returned when showing an overlay, allows control over that specific overlay.
abstract final class UniversalOverlayItem {
  /// Unique identifier (UUID v4)
  String get id;

  /// Dismiss this overlay
  void dismiss();

  /// Whether this overlay is waiting in queue
  bool get isPending;

  /// Whether this overlay is currently visible
  bool get isVisible;

  /// Future that completes when the overlay is dismissed
  Future<DismissalReason> get onDismissed;
}

/// Internal implementation of [UniversalOverlayItem].
final class UniversalOverlayItemImpl implements UniversalOverlayItem {
  /// Creates an overlay item implementation.
  UniversalOverlayItemImpl({
    required this.id,
    required void Function() onDismiss,
  }) : _onDismiss = onDismiss;

  @override
  final String id;

  final void Function() _onDismiss;

  bool _isPending = true;
  bool _isVisible = false;
  bool _isDismissed = false;

  DismissalReason? _dismissalReason;

  final Completer<DismissalReason> _dismissalCompleter =
      Completer<DismissalReason>();

  final List<void Function(DismissalReason)> _dismissalCallbacks = [];

  @override
  void dismiss() {
    if (!_isDismissed) {
      _onDismiss();
    }
  }

  @override
  bool get isPending => _isPending && !_isDismissed;

  @override
  bool get isVisible => _isVisible && !_isDismissed;

  @override
  Future<DismissalReason> get onDismissed {
    if (_dismissalReason != null) {
      return Future.value(_dismissalReason);
    }

    return _dismissalCompleter.future;
  }

  /// Mark the item as shown (no longer pending).
  void markShown() {
    _isPending = false;
    _isVisible = true;
  }

  /// Mark the item as dismissed.
  void markDismissed(DismissalReason reason) {
    _isVisible = false;
    _isPending = false;
    _isDismissed = true;
    _dismissalReason = reason;
    if (!_dismissalCompleter.isCompleted) {
      _dismissalCompleter.complete(reason);
    }
    for (final callback in _dismissalCallbacks) {
      callback(reason);
    }
    _dismissalCallbacks.clear();
  }

  /// Add a callback to be notified when dismissed.
  void addDismissalCallback(void Function(DismissalReason) callback) {
    if (_dismissalReason != null) {
      callback(_dismissalReason!);
    } else {
      _dismissalCallbacks.add(callback);
    }
  }
}

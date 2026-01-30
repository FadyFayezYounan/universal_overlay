import 'package:flutter_test/flutter_test.dart';

import '../core/universal_overlay_controller.dart';
import '../core/universal_overlay_scope.dart';

/// Helper class for testing overlays.
class UniversalOverlayTester {
  UniversalOverlayTester._(this._controller);

  final UniversalOverlayController _controller;

  /// Gets a tester from widget tester.
  static UniversalOverlayTester of(WidgetTester tester) {
    final element = tester.element(find.byType(UniversalOverlayScope));
    final controller = UniversalOverlayAccess.of(element);
    return UniversalOverlayTester._(controller);
  }

  /// Whether a loading overlay is visible.
  bool get isLoadingVisible => _controller.isLoadingVisible;

  /// Number of active toasts.
  int get activeToastCount => _controller.activeToastCount;

  /// Whether any overlay is active.
  bool get hasActiveOverlays => _controller.hasActiveOverlays;

  /// Dismisses all overlays.
  void dismissAll() => _controller.dismissAll();

  /// Dismisses all toasts.
  void dismissAllToasts() => _controller.dismissAllToasts();

  /// Dismisses all loading overlays.
  void dismissAllLoading() => _controller.dismissAllLoading();

  /// Dismisses all custom overlays.
  void dismissAllCustom() => _controller.dismissAllCustom();
}

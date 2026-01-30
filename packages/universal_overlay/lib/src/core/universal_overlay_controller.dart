import 'package:universal_overlay_theme/universal_overlay_theme.dart';

import '../custom/custom_overlay_builder.dart';
import '../custom/custom_overlay_callbacks.dart';
import '../loading/loading_callbacks.dart';
import '../toast/toast_callbacks.dart';
import '../toast/toast_content.dart';
import 'universal_overlay_item.dart';

/// Controller exposed via `UniversalOverlay.of(context)`.
///
/// Provides methods to show and dismiss overlays.
abstract class UniversalOverlayController {
  // Toast methods

  /// Shows a toast notification.
  ///
  /// Returns an [UniversalOverlayItem] to control the toast.
  UniversalOverlayItem showToast({
    required ToastContent content,
    ToastCallbacks? callbacks,
    ToastThemeData? theme,
  });

  // Loading methods

  /// Shows a loading indicator.
  ///
  /// Returns an [UniversalOverlayItem] to control the loading overlay.
  UniversalOverlayItem showLoading({
    String? message,
    LoadingCallbacks? callbacks,
    LoadingThemeData? theme,
  });

  // Custom overlay methods

  /// Shows a custom overlay.
  ///
  /// Returns an [UniversalOverlayItem] to control the overlay.
  UniversalOverlayItem showCustom({
    required CustomOverlayBuilder builder,
    CustomOverlayCallbacks? callbacks,
    CustomOverlayThemeData? theme,
  });

  // Dismissal methods

  /// Dismisses an overlay by its ID.
  void dismiss(String id);

  /// Dismisses all overlays.
  void dismissAll();

  /// Dismisses all toast overlays.
  void dismissAllToasts();

  /// Dismisses all loading overlays.
  void dismissAllLoading();

  /// Dismisses all custom overlays.
  void dismissAllCustom();

  // State getters

  /// Whether a loading overlay is currently visible.
  bool get isLoadingVisible;

  /// Number of active (visible + queued) toasts.
  int get activeToastCount;

  /// Whether any overlay is currently visible.
  bool get hasActiveOverlays;

  /// Gets an overlay item by its ID.
  UniversalOverlayItem? getOverlayById(String id);
}

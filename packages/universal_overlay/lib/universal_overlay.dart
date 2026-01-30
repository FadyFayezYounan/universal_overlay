/// A comprehensive Flutter overlay system for toasts, loading indicators,
/// and custom overlays using InheritedWidget pattern.
///
/// This package provides a unified, customizable overlay system that follows
/// Flutter's `ScaffoldMessenger` pattern, making it familiar and intuitive
/// for Flutter developers.
///
/// ## Getting Started
///
/// Optionally wrap your app with [UniversalOverlayTheme] for app-wide theming:
///
/// ```dart
/// UniversalOverlayTheme(
///   data: UniversalOverlayThemeData(
///     toastTheme: ToastThemeData(...),
///     loadingTheme: LoadingThemeData(...),
///   ),
///   child: MaterialApp(
///     builder: (context, child) {
///       return UniversalOverlay(
///         child: child!,
///       );
///     },
///     home: HomePage(),
///   ),
/// )
/// ```
///
/// Or use [UniversalOverlay] directly with theme configuration:
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) {
///     return UniversalOverlay(
///       toastTheme: ToastThemeData(...),
///       child: child!,
///     );
///   },
///   home: HomePage(),
/// )
/// ```
///
/// ## Showing Overlays
///
/// Use `UniversalOverlay.of(context)` to access the controller:
///
/// ```dart
/// // Show a toast
/// UniversalOverlay.of(context).showToast(
///   content: ToastContent(message: "Hello!"),
/// );
///
/// // Show loading
/// final loading = UniversalOverlay.of(context).showLoading(
///   message: "Processing...",
/// );
/// // Later: loading.dismiss();
///
/// // Show custom overlay
/// UniversalOverlay.of(context).showCustom(
///   builder: (context, item) => YourWidget(onClose: item.dismiss),
/// );
/// ```
library;

// Re-export theme package
export 'package:universal_overlay_theme/universal_overlay_theme.dart';

// Core
export 'src/core/universal_overlay_controller.dart';
export 'src/core/universal_overlay_item.dart' show UniversalOverlayItem;
// Exports UniversalOverlay and deprecated aliases for backward compatibility
export 'src/core/universal_overlay_scope.dart';

// Toast
export 'src/toast/toast_action.dart';
export 'src/toast/toast_callbacks.dart';
export 'src/toast/toast_content.dart';
export 'src/toast/toast_presets.dart';
export 'src/toast/toast_progress.dart';

// Loading
export 'src/loading/loading_callbacks.dart';

// Custom
export 'src/custom/custom_overlay_builder.dart';
export 'src/custom/custom_overlay_callbacks.dart';

// Shared - Enums (only those not in theme package)
export 'src/shared/enums/dismissal_reason.dart';

// Shared - Animations
export 'src/shared/animations/overlay_animations.dart';

// Note: Testing utilities are available via:
// import 'package:universal_overlay/universal_overlay_test.dart';

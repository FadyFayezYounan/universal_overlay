/// A comprehensive Flutter overlay system for toasts, loading indicators,
/// and custom overlays using InheritedWidget pattern.
///
/// This package provides a unified, customizable overlay system that follows
/// Flutter's `ScaffoldMessenger` pattern, making it familiar and intuitive
/// for Flutter developers.
///
/// ## Getting Started
///
/// Wrap your app with [UniversalOverlayScope]:
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) {
///     return UniversalOverlayScope(
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

// Core
export 'src/core/universal_overlay.dart';
export 'src/core/universal_overlay_controller.dart';
export 'src/core/universal_overlay_item.dart' show UniversalOverlayItem;
export 'src/core/universal_overlay_scope.dart'
    show UniversalOverlayScope, UniversalOverlayAccess;

// Toast
export 'src/toast/toast_action.dart';
export 'src/toast/toast_config.dart';
export 'src/toast/toast_content.dart';
export 'src/toast/toast_presets.dart';
export 'src/toast/toast_progress.dart';
export 'src/toast/toast_theme_data.dart';

// Loading
export 'src/loading/loading_config.dart';
export 'src/loading/loading_theme_data.dart';

// Custom
export 'src/custom/custom_overlay_builder.dart';
export 'src/custom/custom_overlay_config.dart';
export 'src/custom/custom_overlay_theme_data.dart';

// Shared - Enums
export 'src/shared/enums/dismissal_reason.dart';
export 'src/shared/enums/dismissal_type.dart';
export 'src/shared/enums/loading_style.dart';
export 'src/shared/enums/overlay_position.dart';
export 'src/shared/enums/stack_direction.dart';
export 'src/shared/enums/toast_display_mode.dart';

// Shared - Models
export 'src/shared/models/barrier_config.dart';
export 'src/shared/models/stack_config.dart';

// Shared - Animations
export 'src/shared/animations/overlay_animation_builder.dart';
export 'src/shared/animations/overlay_animations.dart';

// Note: Testing utilities are available via:
// import 'package:universal_overlay/universal_overlay_test.dart';

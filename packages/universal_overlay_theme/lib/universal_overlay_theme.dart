/// Theme data and InheritedTheme widget for universal_overlay package.
///
/// This package provides customizable theming for toasts, loading indicators,
/// and custom overlays.
///
/// ## Getting Started
///
/// Wrap your app with [UniversalOverlayTheme] to provide default theming:
///
/// ```dart
/// UniversalOverlayTheme(
///   data: UniversalOverlayThemeData(
///     toastTheme: ToastThemeData(
///       position: OverlayPosition.bottom,
///       displayMode: ToastDisplayMode.replace,
///     ),
///     loadingTheme: LoadingThemeData(
///       barrierColor: Colors.black54,
///     ),
///   ),
///   child: MaterialApp(
///     builder: (context, child) {
///       return UniversalOverlayScope(
///         child: child!,
///       );
///     },
///     home: HomePage(),
///   ),
/// )
/// ```
///
/// ## Accessing Theme
///
/// Use `UniversalOverlayTheme.of(context)` to access the theme data:
///
/// ```dart
/// final theme = UniversalOverlayTheme.of(context);
/// final toastTheme = theme.toastTheme;
/// ```
library;

// Theme
export 'src/theme/custom_overlay_theme_data.dart';
export 'src/theme/loading_theme_data.dart';
export 'src/theme/toast_theme_data.dart';
export 'src/theme/universal_overlay_theme.dart';
export 'src/theme/universal_overlay_theme_data.dart';

// Enums
export 'src/enums/dismissal_type.dart';
export 'src/enums/loading_style.dart';
export 'src/enums/overlay_position.dart';
export 'src/enums/stack_direction.dart';
export 'src/enums/toast_display_mode.dart';

// Models
export 'src/models/barrier_config.dart';
export 'src/models/stack_config.dart';

// Animations
export 'src/animations/overlay_animation_builder.dart';


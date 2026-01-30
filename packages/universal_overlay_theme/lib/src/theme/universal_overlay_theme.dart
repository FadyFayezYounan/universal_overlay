import 'package:flutter/foundation.dart'
    show DiagnosticPropertiesBuilder, DiagnosticsProperty;
import 'package:flutter/material.dart';

import 'universal_overlay_theme_data.dart';

/// A widget that provides theme data to its descendants.
///
/// Wrap your app with [UniversalOverlayTheme] to provide default theming
/// for all universal overlay widgets.
///
/// ```dart
/// UniversalOverlayTheme(
///   data: UniversalOverlayThemeData(
///     toastTheme: ToastThemeData(...),
///     loadingTheme: LoadingThemeData(...),
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
class UniversalOverlayTheme extends StatelessWidget {
  /// Creates an [UniversalOverlayTheme] widget.
  ///
  /// The [data] and [child] arguments must not be null.
  const UniversalOverlayTheme({
    super.key,
    required this.data,
    required this.child,
  });

  /// The theme data to use for descendant widgets.
  final UniversalOverlayThemeData data;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Retrieves the nearest [UniversalOverlayThemeData] instance from the given build context.
  ///
  /// If no [UniversalOverlayTheme] is found in the widget tree, it returns the default theme.
  static UniversalOverlayThemeData of(BuildContext context) {
    return maybeOf(context) ?? const UniversalOverlayThemeData();
  }

  /// Retrieves the nearest [UniversalOverlayThemeData] instance from the given build context.
  ///
  /// Returns null if no [UniversalOverlayTheme] is found in the widget tree.
  static UniversalOverlayThemeData? maybeOf(BuildContext context) {
    final _UniversalOverlayInheritedTheme? inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_UniversalOverlayInheritedTheme>();
    return inheritedTheme?.theme.data;
  }

  @override
  Widget build(BuildContext context) {
    return _UniversalOverlayInheritedTheme(
      theme: this,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<UniversalOverlayThemeData>('data', data,
          showName: false),
    );
  }
}

/// An inherited widget that defines the configuration for [UniversalOverlayTheme] widgets.
final class _UniversalOverlayInheritedTheme extends InheritedTheme {
  /// Creates an [_UniversalOverlayInheritedTheme].
  ///
  /// The [theme] and [child] arguments must not be null.
  const _UniversalOverlayInheritedTheme({
    required this.theme,
    required super.child,
  });

  /// The theme data provided by this inherited widget.
  final UniversalOverlayTheme theme;

  @override
  bool updateShouldNotify(
          covariant _UniversalOverlayInheritedTheme oldWidget) =>
      theme.data != oldWidget.theme.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return UniversalOverlayTheme(data: theme.data, child: child);
  }
}

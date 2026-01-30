import 'package:flutter/foundation.dart'
    show DiagnosticPropertiesBuilder, DiagnosticsProperty;
import 'package:flutter/material.dart';

import 'custom_overlay_theme_data.dart';
import 'loading_theme_data.dart';
import 'toast_theme_data.dart';
import 'universal_overlay_theme_data.dart';

/// A widget that provides theme data to its descendants.
///
/// Wrap your app with [UniversalOverlayTheme] to provide default theming
/// for all universal overlay widgets.
///
/// Querying using specific methods (for example, [UniversalOverlayTheme.toastOf]
/// or [UniversalOverlayTheme.loadingThemeOf]) is preferred over using [of] as it
/// provides better code readability and follows the same pattern as [MediaQuery].
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
///
/// To get specific theme data, use the "...Of" methods:
/// ```dart
/// final toastTheme = UniversalOverlayTheme.toastThemeOf(context);
/// final loadingTheme = UniversalOverlayTheme.loadingThemeOf(context);
/// final customTheme = UniversalOverlayTheme.customThemeOf(context);
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
  ///
  /// Prefer using the specific "...Of" methods like [toastOf], [loadingThemeOf],
  /// or [customThemeOf] when you only need a specific part of the theme data.
  ///
  /// See also:
  ///
  ///  * [toastOf], which returns only the toast theme.
  ///  * [loadingThemeOf], which returns only the loading theme.
  ///  * [customThemeOf], which returns only the custom overlay theme.
  static UniversalOverlayThemeData of(BuildContext context) {
    return maybeOf(context) ?? const UniversalOverlayThemeData();
  }

  /// Retrieves the nearest [UniversalOverlayThemeData] instance from the given build context.
  ///
  /// Returns null if no [UniversalOverlayTheme] is found in the widget tree.
  ///
  /// See also:
  ///
  ///  * [maybeToastThemeOf], which returns only the toast theme or null.
  ///  * [maybeLoadingThemeOf], which returns only the loading theme or null.
  ///  * [maybeCustomThemeOf], which returns only the custom overlay theme or null.
  static UniversalOverlayThemeData? maybeOf(BuildContext context) {
    final _UniversalOverlayInheritedTheme? inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_UniversalOverlayInheritedTheme>();
    return inheritedTheme?.theme.data;
  }

  // ---------------------------------------------------------------------------
  // Toast Theme
  // ---------------------------------------------------------------------------

  /// Returns the [ToastThemeData] from the closest [UniversalOverlayTheme] ancestor.
  ///
  /// If no [UniversalOverlayTheme] is found, returns the default [ToastThemeData].
  ///
  /// See also:
  ///
  ///  * [maybeToastOf], which returns null if no [UniversalOverlayTheme] is found.
  static ToastThemeData toastOf(BuildContext context) {
    return maybeToastOf(context) ?? const ToastThemeData();
  }

  /// Returns the [ToastThemeData] from the closest [UniversalOverlayTheme] ancestor,
  /// or null if no [UniversalOverlayTheme] is found.
  ///
  /// See also:
  ///
  ///  * [toastOf], which returns a default [ToastThemeData] if no ancestor is found.
  static ToastThemeData? maybeToastOf(BuildContext context) {
    return maybeOf(context)?.toastTheme;
  }

  // ---------------------------------------------------------------------------
  // Loading Theme
  // ---------------------------------------------------------------------------

  /// Returns the [LoadingThemeData] from the closest [UniversalOverlayTheme] ancestor.
  ///
  /// If no [UniversalOverlayTheme] is found, returns the default [LoadingThemeData].
  ///
  /// See also:
  ///
  ///  * [maybeLoadingOf], which returns null if no [UniversalOverlayTheme] is found.
  static LoadingThemeData loadingOf(BuildContext context) {
    return maybeLoadingOf(context) ?? const LoadingThemeData();
  }

  /// Returns the [LoadingThemeData] from the closest [UniversalOverlayTheme] ancestor,
  /// or null if no [UniversalOverlayTheme] is found.
  ///
  /// See also:
  ///
  ///  * [loadingOf], which returns a default [LoadingThemeData] if no ancestor is found.
  static LoadingThemeData? maybeLoadingOf(BuildContext context) {
    return maybeOf(context)?.loadingTheme;
  }

  // ---------------------------------------------------------------------------
  // Custom Overlay Theme
  // ---------------------------------------------------------------------------

  /// Returns the [CustomOverlayThemeData] from the closest [UniversalOverlayTheme] ancestor.
  ///
  /// If no [UniversalOverlayTheme] is found, returns the default [CustomOverlayThemeData].
  ///
  /// See also:
  ///
  ///  * [maybeCustomOf], which returns null if no [UniversalOverlayTheme] is found.
  static CustomOverlayThemeData customOf(BuildContext context) {
    return maybeCustomOf(context) ?? const CustomOverlayThemeData();
  }

  /// Returns the [CustomOverlayThemeData] from the closest [UniversalOverlayTheme] ancestor,
  /// or null if no [UniversalOverlayTheme] is found.
  ///
  /// See also:
  ///
  ///  * [customOf], which returns a default [CustomOverlayThemeData] if no ancestor is found.
  static CustomOverlayThemeData? maybeCustomOf(BuildContext context) {
    return maybeOf(context)?.customTheme;
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

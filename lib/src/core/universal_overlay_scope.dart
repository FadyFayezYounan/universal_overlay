import 'package:flutter/material.dart';

import '../custom/custom_overlay_theme_data.dart';
import '../loading/loading_theme_data.dart';
import '../toast/toast_theme_data.dart';
import 'overlay_manager.dart';
import 'universal_overlay_controller.dart';

/// The root widget that provides overlay functionality to the widget tree.
///
/// Wrap your app content with [UniversalOverlayScope] to enable overlay features.
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
@immutable
class UniversalOverlayScope extends StatefulWidget {
  /// Creates a universal overlay scope.
  const UniversalOverlayScope({
    super.key,
    required this.child,
    this.toastTheme,
    this.loadingTheme,
    this.customTheme,
  });

  /// The child widget tree.
  final Widget child;

  /// Default theme for toast overlays.
  final ToastThemeData? toastTheme;

  /// Default theme for loading overlays.
  final LoadingThemeData? loadingTheme;

  /// Default theme for custom overlays.
  final CustomOverlayThemeData? customTheme;

  @override
  State<UniversalOverlayScope> createState() => _UniversalOverlayScopeState();
}

class _UniversalOverlayScopeState extends State<UniversalOverlayScope>
    with TickerProviderStateMixin {
  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();
  OverlayManager? _manager;

  @override
  void dispose() {
    _manager?.dispose();
    super.dispose();
  }

  void _ensureManager() {
    if (_manager == null) {
      final overlayState = _overlayKey.currentState;
      if (overlayState != null) {
        _manager = OverlayManager(
          overlayState: overlayState,
          vsync: this,
          defaultToastTheme: widget.toastTheme ?? const ToastThemeData(),
          defaultLoadingTheme: widget.loadingTheme ?? const LoadingThemeData(),
          defaultCustomTheme:
              widget.customTheme ?? const CustomOverlayThemeData(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _UniversalOverlayInherited(
      getController: () {
        _ensureManager();
        return _manager!;
      },
      toastTheme: widget.toastTheme ?? const ToastThemeData(),
      loadingTheme: widget.loadingTheme ?? const LoadingThemeData(),
      customTheme: widget.customTheme ?? const CustomOverlayThemeData(),
      child: Overlay(
        key: _overlayKey,
        initialEntries: [
          OverlayEntry(
            builder: (context) => widget.child,
          ),
        ],
      ),
    );
  }
}

/// InheritedWidget for providing overlay functionality.
class _UniversalOverlayInherited extends InheritedWidget {
  const _UniversalOverlayInherited({
    required super.child,
    required this.getController,
    required this.toastTheme,
    required this.loadingTheme,
    required this.customTheme,
  });

  final UniversalOverlayController Function() getController;
  final ToastThemeData toastTheme;
  final LoadingThemeData loadingTheme;
  final CustomOverlayThemeData customTheme;

  static _UniversalOverlayInherited? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_UniversalOverlayInherited>();
  }

  static _UniversalOverlayInherited of(BuildContext context) {
    final inherited = maybeOf(context);
    assert(
      inherited != null,
      'No UniversalOverlayScope found in context. '
      'Wrap your app with UniversalOverlayScope.',
    );
    return inherited!;
  }

  @override
  bool updateShouldNotify(_UniversalOverlayInherited oldWidget) {
    return toastTheme != oldWidget.toastTheme ||
        loadingTheme != oldWidget.loadingTheme ||
        customTheme != oldWidget.customTheme;
  }
}

/// Internal access helper for UniversalOverlay.
class UniversalOverlayAccess {
  UniversalOverlayAccess._();

  /// Gets the [UniversalOverlayController] from the given [context].
  static UniversalOverlayController of(BuildContext context) {
    final scope = _UniversalOverlayInherited.of(context);
    return scope.getController();
  }

  /// Gets the [UniversalOverlayController] from the given [context],
  /// or null if no [UniversalOverlayScope] is found.
  static UniversalOverlayController? maybeOf(BuildContext context) {
    final scope = _UniversalOverlayInherited.maybeOf(context);
    return scope?.getController();
  }
}

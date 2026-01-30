import 'package:flutter/material.dart';
import 'package:universal_overlay_theme/universal_overlay_theme.dart';

import 'overlay_manager.dart';
import 'universal_overlay_controller.dart';

/// The root widget that provides overlay functionality to the widget tree.
///
/// Wrap your app content with [UniversalOverlay] to enable overlay features.
///
/// You can also wrap your app with [UniversalOverlayTheme] for app-wide theming:
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
/// Or configure theme directly on [UniversalOverlay]:
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
/// ## Accessing the Controller
///
/// Use `UniversalOverlay.of(context)` to access the controller:
///
/// ```dart
/// UniversalOverlay.of(context).showToast(
///   content: ToastContent(message: "Hello!"),
/// );
/// ```
@immutable
class UniversalOverlay extends StatefulWidget {
  /// Creates a universal overlay.
  const UniversalOverlay({
    super.key,
    required this.child,
    this.toastTheme,
    this.loadingTheme,
    this.customTheme,
  });

  /// The child widget tree.
  final Widget child;

  /// Default theme for toast overlays.
  /// If not provided, will try to use [UniversalOverlayTheme] from context.
  final ToastThemeData? toastTheme;

  /// Default theme for loading overlays.
  /// If not provided, will try to use [UniversalOverlayTheme] from context.
  final LoadingThemeData? loadingTheme;

  /// Default theme for custom overlays.
  /// If not provided, will try to use [UniversalOverlayTheme] from context.
  final CustomOverlayThemeData? customTheme;

  /// Gets the [UniversalOverlayController] from the given [context].
  ///
  /// Throws an assertion error if no [UniversalOverlay] is found or if
  /// the overlay is not yet initialized.
  static UniversalOverlayController of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_UniversalOverlayInherited>();
    assert(
      inherited != null,
      'No UniversalOverlay found in context. '
      'Wrap your app with UniversalOverlay.',
    );
    assert(
      inherited!.controller != null,
      'UniversalOverlay is not yet initialized. '
      'Make sure you are not calling UniversalOverlay.of() during build '
      'of the same widget that contains UniversalOverlay.',
    );
    return inherited!.controller!;
  }

  /// Gets the [UniversalOverlayController] from the given [context],
  /// or null if no [UniversalOverlay] is found or not yet initialized.
  static UniversalOverlayController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_UniversalOverlayInherited>()
        ?.controller;
  }

  @override
  State<UniversalOverlay> createState() => _UniversalOverlayState();
}

class _UniversalOverlayState extends State<UniversalOverlay>
    with TickerProviderStateMixin {
  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();
  OverlayManager? _manager;

  @override
  void initState() {
    super.initState();
    // Schedule manager creation after the first frame when Overlay is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeManager();
    });
  }

  void _initializeManager() {
    if (_manager != null) return;

    final overlayState = _overlayKey.currentState;
    if (overlayState == null) {
      // This should not happen if used correctly
      throw StateError(
        'Overlay not found. This is an internal error in UniversalOverlay.',
      );
    }

    final inheritedTheme = UniversalOverlayTheme.of(context);
    _manager = OverlayManager(
      overlayState: overlayState,
      vsync: this,
      defaultToastTheme: widget.toastTheme ?? inheritedTheme.toastTheme,
      defaultLoadingTheme: widget.loadingTheme ?? inheritedTheme.loadingTheme,
      defaultCustomTheme: widget.customTheme ?? inheritedTheme.customTheme,
    );

    // Trigger rebuild to provide the initialized manager
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _manager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Try to get theme from UniversalOverlayTheme if available
    final inheritedTheme = UniversalOverlayTheme.of(context);

    // Resolve final themes (widget props take precedence over inherited theme)
    final toastTheme = widget.toastTheme ?? inheritedTheme.toastTheme;
    final loadingTheme = widget.loadingTheme ?? inheritedTheme.loadingTheme;
    final customTheme = widget.customTheme ?? inheritedTheme.customTheme;

    return _UniversalOverlayInherited(
      controller: _manager,
      toastTheme: toastTheme,
      loadingTheme: loadingTheme,
      customTheme: customTheme,
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
    required this.controller,
    required this.toastTheme,
    required this.loadingTheme,
    required this.customTheme,
  });

  final UniversalOverlayController? controller;
  final ToastThemeData toastTheme;
  final LoadingThemeData loadingTheme;
  final CustomOverlayThemeData customTheme;

  @override
  bool updateShouldNotify(_UniversalOverlayInherited oldWidget) {
    return controller != oldWidget.controller ||
        toastTheme != oldWidget.toastTheme ||
        loadingTheme != oldWidget.loadingTheme ||
        customTheme != oldWidget.customTheme;
  }
}

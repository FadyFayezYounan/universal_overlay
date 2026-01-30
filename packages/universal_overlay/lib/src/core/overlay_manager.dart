import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:universal_overlay_theme/universal_overlay_theme.dart';

import '../custom/custom_overlay_builder.dart';
import '../custom/custom_overlay_callbacks.dart';
import '../custom/custom_overlay_widget.dart';
import '../loading/loading_callbacks.dart';
import '../loading/loading_widget.dart';
import '../shared/enums/dismissal_reason.dart';
import '../shared/utils/id_generator.dart';
import '../toast/toast_callbacks.dart';
import '../toast/toast_content.dart';
import '../toast/toast_widget.dart';
import 'universal_overlay_controller.dart';
import 'universal_overlay_item.dart';

/// Pending toast entry waiting in queue.
class _PendingToast {
  _PendingToast({
    required this.item,
    required this.content,
    required this.callbacks,
    required this.theme,
  });

  final UniversalOverlayItemImpl item;
  final ToastContent content;
  final ToastCallbacks callbacks;
  final ToastThemeData theme;
}

/// Active overlay entry.
class _ActiveOverlay {
  _ActiveOverlay({
    required this.item,
    required this.entry,
    required this.controller,
    required this.type,
  });

  final UniversalOverlayItemImpl item;
  final OverlayEntry entry;
  final AnimationController controller;
  final _OverlayType type;
  bool isDisposed = false;
}

enum _OverlayType { toast, loading, custom }

/// Internal overlay manager.
class OverlayManager implements UniversalOverlayController {
  OverlayManager({
    required this.overlayState,
    required this.vsync,
    required this.defaultToastTheme,
    required this.defaultLoadingTheme,
    required this.defaultCustomTheme,
  });

  final OverlayState overlayState;
  final TickerProvider vsync;
  final ToastThemeData defaultToastTheme;
  final LoadingThemeData defaultLoadingTheme;
  final CustomOverlayThemeData defaultCustomTheme;

  final Map<String, _ActiveOverlay> _activeOverlays = {};
  final Queue<_PendingToast> _toastQueue = Queue<_PendingToast>();
  final List<_ActiveOverlay> _visibleToasts = [];

  bool _isShowingLoading = false;

  @override
  UniversalOverlayItem showToast({
    required ToastContent content,
    ToastCallbacks? callbacks,
    ToastThemeData? theme,
  }) {
    final mergedTheme = defaultToastTheme.merge(theme);
    final mergedCallbacks = callbacks ?? const ToastCallbacks();

    final id = IdGenerator.generate();
    late final UniversalOverlayItemImpl item;
    item = UniversalOverlayItemImpl(
      id: id,
      onDismiss: () => _dismissToast(id, DismissalReason.programmatic),
    );

    final displayMode = mergedTheme.displayMode;

    switch (displayMode) {
      case ToastDisplayMode.queue:
        if (_visibleToasts.isEmpty) {
          _showToastImmediately(item, content, mergedCallbacks, mergedTheme);
        } else {
          _toastQueue.add(_PendingToast(
            item: item,
            content: content,
            callbacks: mergedCallbacks,
            theme: mergedTheme,
          ));
        }
        break;

      case ToastDisplayMode.stack:
        final stackConfig = mergedTheme.stackConfig;
        final maxVisible = stackConfig?.maxVisible ?? 3;

        if (_visibleToasts.length >= maxVisible) {
          final overflowBehavior =
              stackConfig?.overflowBehavior ?? StackOverflowBehavior.queue;
          if (overflowBehavior == StackOverflowBehavior.dismissOldest) {
            final oldest = _visibleToasts.first;
            _dismissToast(oldest.item.id, DismissalReason.replaced);
          } else {
            _toastQueue.add(_PendingToast(
              item: item,
              content: content,
              callbacks: mergedCallbacks,
              theme: mergedTheme,
            ));
            return item;
          }
        }
        _showToastImmediately(item, content, mergedCallbacks, mergedTheme);
        break;

      case ToastDisplayMode.replace:
        // Dismiss all current toasts
        for (final toast in List.from(_visibleToasts)) {
          _dismissToast(toast.item.id, DismissalReason.replaced);
        }
        _showToastImmediately(item, content, mergedCallbacks, mergedTheme);
        break;
    }

    return item;
  }

  void _showToastImmediately(
    UniversalOverlayItemImpl item,
    ToastContent content,
    ToastCallbacks callbacks,
    ToastThemeData theme,
  ) {
    final controller = AnimationController(
      vsync: vsync,
      duration: theme.animationDuration,
    );

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => ToastWidget(
        content: content,
        callbacks: callbacks,
        theme: theme,
        item: item,
        onDismiss: (reason) => _dismissToast(item.id, reason),
        animationController: controller,
      ),
    );

    final activeOverlay = _ActiveOverlay(
      item: item,
      entry: entry,
      controller: controller,
      type: _OverlayType.toast,
    );

    _activeOverlays[item.id] = activeOverlay;
    _visibleToasts.add(activeOverlay);
    item.markShown();

    overlayState.insert(entry);
    controller.forward();

    callbacks.onShow?.call();
  }

  void _dismissToast(String id, DismissalReason reason) {
    final overlay = _activeOverlays[id];
    if (overlay == null || overlay.type != _OverlayType.toast) return;
    if (overlay.isDisposed) return;
    overlay.isDisposed = true;

    _activeOverlays.remove(id);
    _visibleToasts.removeWhere((t) => t.item.id == id);

    overlay.controller.reverse().then((_) {
      overlay.entry.remove();
      overlay.controller.dispose();
      overlay.item.markDismissed(reason);

      // Show next queued toast
      _showNextQueuedToast();
    });
  }

  void _showNextQueuedToast() {
    if (_toastQueue.isEmpty) return;

    final pending = _toastQueue.removeFirst();
    _showToastImmediately(
      pending.item,
      pending.content,
      pending.callbacks,
      pending.theme,
    );
  }

  @override
  UniversalOverlayItem showLoading({
    String? message,
    LoadingCallbacks? callbacks,
    LoadingThemeData? theme,
  }) {
    final mergedTheme = defaultLoadingTheme.merge(theme);
    final mergedCallbacks = callbacks ?? const LoadingCallbacks();

    final id = IdGenerator.generate();
    late final UniversalOverlayItemImpl item;
    item = UniversalOverlayItemImpl(
      id: id,
      onDismiss: () => _dismissLoading(id, DismissalReason.programmatic),
    );

    final controller = AnimationController(
      vsync: vsync,
      duration: mergedTheme.animationDuration,
    );

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => LoadingOverlayWidget(
        message: message,
        callbacks: mergedCallbacks,
        theme: mergedTheme,
        item: item,
        onDismiss: (reason) => _dismissLoading(id, reason),
        animationController: controller,
      ),
    );

    final activeOverlay = _ActiveOverlay(
      item: item,
      entry: entry,
      controller: controller,
      type: _OverlayType.loading,
    );

    _activeOverlays[id] = activeOverlay;
    _isShowingLoading = true;
    item.markShown();

    overlayState.insert(entry);
    controller.forward();

    mergedCallbacks.onShow?.call();

    return item;
  }

  void _dismissLoading(String id, DismissalReason reason) {
    final overlay = _activeOverlays[id];
    if (overlay == null || overlay.type != _OverlayType.loading) return;
    if (overlay.isDisposed) return;
    overlay.isDisposed = true;

    _activeOverlays.remove(id);
    _isShowingLoading =
        _activeOverlays.values.any((o) => o.type == _OverlayType.loading);

    overlay.controller.reverse().then((_) {
      overlay.entry.remove();
      overlay.controller.dispose();
      overlay.item.markDismissed(reason);
    });
  }

  @override
  UniversalOverlayItem showCustom({
    required CustomOverlayBuilder builder,
    CustomOverlayCallbacks? callbacks,
    CustomOverlayThemeData? theme,
  }) {
    final mergedTheme = theme ?? defaultCustomTheme;
    final mergedCallbacks = callbacks ?? const CustomOverlayCallbacks();

    final id = IdGenerator.generate();
    late final UniversalOverlayItemImpl item;
    item = UniversalOverlayItemImpl(
      id: id,
      onDismiss: () => _dismissCustom(id, DismissalReason.programmatic),
    );

    final controller = AnimationController(
      vsync: vsync,
      duration: mergedTheme.animationDuration,
    );

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => CustomOverlayWidget(
        builder: builder,
        callbacks: mergedCallbacks,
        theme: mergedTheme,
        item: item,
        onDismiss: (reason) => _dismissCustom(id, reason),
        animationController: controller,
      ),
    );

    final activeOverlay = _ActiveOverlay(
      item: item,
      entry: entry,
      controller: controller,
      type: _OverlayType.custom,
    );

    _activeOverlays[id] = activeOverlay;
    item.markShown();

    overlayState.insert(entry);
    controller.forward();

    mergedCallbacks.onShow?.call();

    return item;
  }

  void _dismissCustom(String id, DismissalReason reason) {
    final overlay = _activeOverlays[id];
    if (overlay == null || overlay.type != _OverlayType.custom) return;
    if (overlay.isDisposed) return;

    overlay.isDisposed = true;
    final controller = overlay.controller;
    final entry = overlay.entry;
    final item = overlay.item;
    _activeOverlays.remove(id);

    controller.reverse().then((_) {
      entry.remove();
      controller.dispose();
      item.markDismissed(reason);
    });
  }

  @override
  void dismiss(String id) {
    final overlay = _activeOverlays[id];
    if (overlay == null) {
      // Check if it's in the queue
      _toastQueue.removeWhere((p) {
        if (p.item.id == id) {
          p.item.markDismissed(DismissalReason.programmatic);
          return true;
        }
        return false;
      });
      return;
    }

    switch (overlay.type) {
      case _OverlayType.toast:
        _dismissToast(id, DismissalReason.programmatic);
        break;
      case _OverlayType.loading:
        _dismissLoading(id, DismissalReason.programmatic);
        break;
      case _OverlayType.custom:
        _dismissCustom(id, DismissalReason.programmatic);
        break;
    }
  }

  @override
  void dismissAll() {
    for (final id in List.from(_activeOverlays.keys)) {
      dismiss(id);
    }
    for (final pending in _toastQueue) {
      pending.item.markDismissed(DismissalReason.programmatic);
    }
    _toastQueue.clear();
  }

  @override
  void dismissAllToasts() {
    for (final overlay in List<_ActiveOverlay>.from(_activeOverlays.values)) {
      if (overlay.type == _OverlayType.toast) {
        _dismissToast(overlay.item.id, DismissalReason.programmatic);
      }
    }
    for (final pending in _toastQueue) {
      pending.item.markDismissed(DismissalReason.programmatic);
    }
    _toastQueue.clear();
  }

  @override
  void dismissAllLoading() {
    for (final overlay in List<_ActiveOverlay>.from(_activeOverlays.values)) {
      if (overlay.type == _OverlayType.loading) {
        _dismissLoading(overlay.item.id, DismissalReason.programmatic);
      }
    }
  }

  @override
  void dismissAllCustom() {
    for (final overlay in List<_ActiveOverlay>.from(_activeOverlays.values)) {
      if (overlay.type == _OverlayType.custom) {
        _dismissCustom(overlay.item.id, DismissalReason.programmatic);
      }
    }
  }

  @override
  bool get isLoadingVisible => _isShowingLoading;

  @override
  int get activeToastCount => _visibleToasts.length + _toastQueue.length;

  @override
  bool get hasActiveOverlays => _activeOverlays.isNotEmpty;

  @override
  UniversalOverlayItem? getOverlayById(String id) {
    final overlay = _activeOverlays[id];
    if (overlay != null) return overlay.item;

    for (final pending in _toastQueue) {
      if (pending.item.id == id) return pending.item;
    }

    return null;
  }

  /// Dispose all resources.
  void dispose() {
    // Dispose all active overlays synchronously without animation
    for (final overlay in _activeOverlays.values.toList()) {
      if (!overlay.isDisposed) {
        overlay.isDisposed = true;
        overlay.controller.stop();
        try {
          overlay.entry.remove();
        } catch (_) {
          // Entry might already be removed
        }
        overlay.controller.dispose();
      }
    }
    _activeOverlays.clear();
    _toastQueue.clear();
    _visibleToasts.clear();
  }
}

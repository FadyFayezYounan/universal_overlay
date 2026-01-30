import 'package:flutter/material.dart';
import 'package:universal_overlay_theme/universal_overlay_theme.dart';

import '../core/universal_overlay_item.dart';
import '../shared/animations/overlay_animations.dart';
import '../shared/enums/dismissal_reason.dart';
import 'custom_overlay_builder.dart';
import 'custom_overlay_callbacks.dart';

/// Internal widget for rendering a custom overlay.
class CustomOverlayWidget extends StatelessWidget {
  /// Creates a custom overlay widget.
  const CustomOverlayWidget({
    super.key,
    required this.builder,
    required this.callbacks,
    required this.theme,
    required this.item,
    required this.onDismiss,
    required this.animationController,
  });

  /// Builder for the custom content
  final CustomOverlayBuilder builder;

  /// Custom overlay callbacks
  final CustomOverlayCallbacks callbacks;

  /// Custom overlay theme (behavior + styling)
  final CustomOverlayThemeData theme;

  /// The overlay item controller
  final UniversalOverlayItem item;

  /// Callback to dismiss the overlay
  final void Function(DismissalReason reason) onDismiss;

  /// Animation controller
  final AnimationController animationController;

  Alignment _getAlignment() {
    switch (theme.position) {
      case OverlayPosition.top:
        return Alignment.topCenter;
      case OverlayPosition.topLeft:
        return Alignment.topLeft;
      case OverlayPosition.topRight:
        return Alignment.topRight;
      case OverlayPosition.center:
        return Alignment.center;
      case OverlayPosition.centerLeft:
        return Alignment.centerLeft;
      case OverlayPosition.centerRight:
        return Alignment.centerRight;
      case OverlayPosition.bottom:
        return Alignment.bottomCenter;
      case OverlayPosition.bottomLeft:
        return Alignment.bottomLeft;
      case OverlayPosition.bottomRight:
        return Alignment.bottomRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final alignment = _getAlignment();

    final enterBuilder = theme.enterAnimationBuilder ??
        theme.animationBuilder ??
        OverlayAnimations.scale();

    Widget content = builder(context, item);

    // Wrap with tap handler if tap overlay dismissal is enabled
    if (theme.dismissalTypes.contains(DismissalType.tapOverlay)) {
      content = GestureDetector(
        onTap: () => onDismiss(DismissalReason.tapOverlay),
        child: content,
      );
    }

    content = enterBuilder(
      context,
      animationController,
      alignment,
      content,
    );

    final barrier = theme.barrier;

    Widget result;
    if (barrier != null) {
      final barrierWidget = GestureDetector(
        onTap: theme.dismissalTypes.contains(DismissalType.tapOutside) ||
                barrier.dismissible
            ? () => onDismiss(DismissalReason.tapOutside)
            : null,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Container(
              color: barrier.color.withValues(
                alpha: barrier.color.a * animationController.value,
              ),
            );
          },
        ),
      );

      result = Stack(
        children: [
          Positioned.fill(child: barrierWidget),
          Align(
            alignment: alignment,
            child: SafeArea(child: content),
          ),
        ],
      );
    } else {
      result = Align(
        alignment: alignment,
        child: SafeArea(child: content),
      );
    }

    // Handle back button
    if (theme.dismissalTypes.contains(DismissalType.backButton)) {
      result = PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            onDismiss(DismissalReason.backButton);
          }
        },
        child: result,
      );
    }

    return result;
  }
}

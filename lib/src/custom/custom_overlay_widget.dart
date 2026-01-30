import 'package:flutter/material.dart';

import '../core/universal_overlay_item.dart';
import '../shared/animations/overlay_animations.dart';
import '../shared/enums/dismissal_reason.dart';
import '../shared/enums/dismissal_type.dart';
import '../shared/enums/overlay_position.dart';
import 'custom_overlay_builder.dart';
import 'custom_overlay_config.dart';
import 'custom_overlay_theme_data.dart';

/// Internal widget for rendering a custom overlay.
class CustomOverlayWidget extends StatelessWidget {
  /// Creates a custom overlay widget.
  const CustomOverlayWidget({
    super.key,
    required this.builder,
    required this.config,
    required this.theme,
    required this.item,
    required this.onDismiss,
    required this.animationController,
  });

  /// Builder for the custom content
  final CustomOverlayBuilder builder;

  /// Custom overlay configuration
  final CustomOverlayConfig config;

  /// Custom overlay theme
  final CustomOverlayThemeData theme;

  /// The overlay item controller
  final UniversalOverlayItem item;

  /// Callback to dismiss the overlay
  final void Function(DismissalReason reason) onDismiss;

  /// Animation controller
  final AnimationController animationController;

  Alignment _getAlignment() {
    switch (config.position) {
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

    final enterBuilder = config.enterAnimationBuilder ??
        config.animationBuilder ??
        theme.enterAnimationBuilder ??
        theme.animationBuilder ??
        OverlayAnimations.scale();

    Widget content = builder(context, item);

    // Wrap with tap handler if tap overlay dismissal is enabled
    if (config.dismissalTypes.contains(DismissalType.tapOverlay)) {
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

    final barrier = config.barrier ?? theme.barrier;

    Widget result;
    if (barrier != null) {
      final barrierWidget = GestureDetector(
        onTap: config.dismissalTypes.contains(DismissalType.tapOutside) ||
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
    if (config.dismissalTypes.contains(DismissalType.backButton)) {
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

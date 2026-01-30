import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../core/universal_overlay_item.dart';
import '../shared/animations/overlay_animations.dart';
import '../shared/enums/dismissal_reason.dart';
import '../shared/enums/loading_style.dart';
import 'loading_config.dart';
import 'loading_theme_data.dart';

/// Internal widget for rendering a loading overlay.
class LoadingOverlayWidget extends StatelessWidget {
  /// Creates a loading overlay widget.
  const LoadingOverlayWidget({
    super.key,
    this.message,
    required this.config,
    required this.theme,
    required this.item,
    required this.onDismiss,
    required this.animationController,
  });

  /// Optional message to display
  final String? message;

  /// Loading configuration
  final LoadingConfig config;

  /// Loading theme
  final LoadingThemeData theme;

  /// The overlay item controller
  final UniversalOverlayItem item;

  /// Callback to dismiss the loading overlay
  final void Function(DismissalReason reason) onDismiss;

  /// Animation controller
  final AnimationController animationController;

  Widget _buildIndicator(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final resolvedTheme = theme.resolve(
      isDark ? Brightness.dark : Brightness.light,
    );

    final indicatorSize = resolvedTheme.indicatorSize ?? 40;
    final indicatorColor =
        resolvedTheme.indicatorColor ?? Theme.of(context).colorScheme.primary;
    final strokeWidth = resolvedTheme.indicatorStrokeWidth ?? 4;

    final effectiveStyle = resolvedTheme.style;

    switch (effectiveStyle) {
      case LoadingStyle.material:
        return SizedBox(
          width: indicatorSize,
          height: indicatorSize,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation(indicatorColor),
          ),
        );

      case LoadingStyle.cupertino:
        return SizedBox(
          width: indicatorSize,
          height: indicatorSize,
          child: CupertinoActivityIndicator(
            radius: indicatorSize / 2,
            color: indicatorColor,
          ),
        );

      case LoadingStyle.custom:
        if (resolvedTheme.builder != null) {
          return resolvedTheme.builder!(context);
        }
        // Fall back to adaptive
        return _buildAdaptiveIndicator(
          context,
          indicatorSize,
          indicatorColor,
          strokeWidth,
        );

      case LoadingStyle.adaptive:
        return _buildAdaptiveIndicator(
          context,
          indicatorSize,
          indicatorColor,
          strokeWidth,
        );
    }
  }

  Widget _buildAdaptiveIndicator(
    BuildContext context,
    double size,
    Color color,
    double strokeWidth,
  ) {
    // Use Cupertino on iOS/macOS, Material elsewhere
    final bool useCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

    if (useCupertino) {
      return SizedBox(
        width: size,
        height: size,
        child: CupertinoActivityIndicator(
          radius: size / 2,
          color: color,
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final resolvedTheme = theme.resolve(
      isDark ? Brightness.dark : Brightness.light,
    );

    final backgroundColor = resolvedTheme.backgroundColor ??
        (isDark ? const Color(0xFF424242) : Colors.white);
    final borderRadius =
        resolvedTheme.borderRadius ?? BorderRadius.circular(12);
    final elevation = resolvedTheme.elevation ?? 8;
    final padding = resolvedTheme.padding ?? const EdgeInsets.all(24);
    final minSize = resolvedTheme.minSize ?? const Size(100, 100);
    final messageTextStyle = resolvedTheme.messageTextStyle ??
        TextStyle(
          fontSize: 14,
          color: isDark ? Colors.white : Colors.black87,
        );
    final messageSpacing = resolvedTheme.messageSpacing ?? 16;
    final barrierColor = config.barrierColor ?? resolvedTheme.barrierColor;

    final animationBuilder = config.animationBuilder ??
        resolvedTheme.animationBuilder ??
        OverlayAnimations.scale();

    Widget content = Material(
      color: backgroundColor,
      elevation: elevation,
      borderRadius: borderRadius,
      child: Container(
        constraints: BoxConstraints(
          minWidth: minSize.width,
          minHeight: minSize.height,
        ),
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIndicator(context),
            if (message != null) ...[
              SizedBox(height: messageSpacing),
              Text(
                message!,
                style: messageTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );

    content = animationBuilder(
      context,
      animationController,
      Alignment.center,
      content,
    );

    Widget barrier = GestureDetector(
      onTap: config.barrierDismissible
          ? () => onDismiss(DismissalReason.tapOutside)
          : null,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Container(
            color: barrierColor?.withValues(
              alpha: (barrierColor.a) * animationController.value,
            ),
          );
        },
      ),
    );

    if (!config.allowBackButton) {
      barrier = PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop && config.barrierDismissible) {
            onDismiss(DismissalReason.backButton);
          }
        },
        child: barrier,
      );
    }

    return Stack(
      children: [
        Positioned.fill(child: barrier),
        Center(child: content),
      ],
    );
  }
}

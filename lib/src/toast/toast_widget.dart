import 'package:flutter/material.dart';

import '../core/universal_overlay_item.dart';
import '../shared/animations/overlay_animations.dart';
import '../shared/enums/dismissal_reason.dart';
import '../shared/enums/dismissal_type.dart';
import '../shared/enums/overlay_position.dart';
import 'toast_config.dart';
import 'toast_content.dart';
import 'toast_theme_data.dart';

/// Internal widget for rendering a toast.
class ToastWidget extends StatefulWidget {
  /// Creates a toast widget.
  const ToastWidget({
    super.key,
    required this.content,
    required this.config,
    required this.theme,
    required this.item,
    required this.onDismiss,
    required this.animationController,
  });

  /// Toast content
  final ToastContent content;

  /// Toast configuration
  final ToastConfig config;

  /// Toast theme
  final ToastThemeData theme;

  /// The overlay item controller
  final UniversalOverlayItem item;

  /// Callback to dismiss the toast
  final void Function(DismissalReason reason) onDismiss;

  /// Animation controller
  final AnimationController animationController;

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    if (widget.config.dismissalTypes.contains(DismissalType.timer)) {
      Future.delayed(widget.config.duration, () {
        if (mounted && widget.item.isVisible) {
          widget.onDismiss(DismissalReason.timer);
        }
      });
    }
  }

  DismissDirection _getSwipeDirection() {
    if (widget.config.swipeDismissDirection != null) {
      return widget.config.swipeDismissDirection!;
    }

    // Auto-determine based on position
    switch (widget.config.position) {
      case OverlayPosition.top:
      case OverlayPosition.topLeft:
      case OverlayPosition.topRight:
        return DismissDirection.up;
      case OverlayPosition.bottom:
      case OverlayPosition.bottomLeft:
      case OverlayPosition.bottomRight:
        return DismissDirection.down;
      case OverlayPosition.centerLeft:
        return DismissDirection.startToEnd;
      case OverlayPosition.centerRight:
        return DismissDirection.endToStart;
      default:
        return DismissDirection.horizontal;
    }
  }

  Alignment _getAlignment() {
    switch (widget.config.position) {
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

  Widget _buildToastContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final resolvedTheme = widget.theme.resolve(
      isDark ? Brightness.dark : Brightness.light,
    );

    final backgroundColor = resolvedTheme.backgroundColor ??
        (isDark ? const Color(0xFF323232) : const Color(0xFF323232));
    final textStyle = resolvedTheme.textStyle ??
        const TextStyle(color: Colors.white, fontSize: 14);
    final borderRadius = resolvedTheme.borderRadius ?? BorderRadius.circular(8);
    final elevation = resolvedTheme.elevation ?? 6;
    final padding = resolvedTheme.padding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    Widget toastContent = Container(
      constraints: BoxConstraints(
        maxWidth: resolvedTheme.maxWidth ?? 400,
        minHeight: resolvedTheme.minHeight ?? 0,
      ),
      child: Material(
        color: backgroundColor,
        elevation: elevation,
        shadowColor: resolvedTheme.shadowColor ?? Colors.black26,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: widget.config.dismissalTypes.contains(DismissalType.tapOverlay)
              ? () => widget.onDismiss(DismissalReason.tapOverlay)
              : widget.config.onTap,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: resolvedTheme.border,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.content.leading != null) ...[
                      IconTheme(
                        data: IconThemeData(
                          size: resolvedTheme.leadingIconSize ?? 24,
                          color:
                              resolvedTheme.leadingIconColor ?? textStyle.color,
                        ),
                        child: widget.content.leading!,
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Text(
                        widget.content.message,
                        style: textStyle,
                      ),
                    ),
                    if (widget.content.action != null) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          widget.content.action!.onPressed();
                          widget.config.onActionPressed?.call();
                          widget.onDismiss(DismissalReason.action);
                        },
                        style: TextButton.styleFrom(
                          padding: resolvedTheme.actionPadding ??
                              const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: Text(
                          widget.content.action!.label,
                          style: widget.content.action!.textStyle ??
                              resolvedTheme.actionTextStyle ??
                              textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                    if (widget.content.trailing != null) ...[
                      const SizedBox(width: 8),
                      IconTheme(
                        data: IconThemeData(
                          size: resolvedTheme.trailingIconSize ?? 20,
                          color: resolvedTheme.trailingIconColor ??
                              textStyle.color?.withValues(alpha: 0.7),
                        ),
                        child: widget.content.trailing!,
                      ),
                    ],
                  ],
                ),
                if (widget.content.progress != null) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      (resolvedTheme.progressHeight ?? 4) / 2,
                    ),
                    child: SizedBox(
                      height: resolvedTheme.progressHeight ?? 4,
                      child: LinearProgressIndicator(
                        value: widget.content.progress!.value,
                        backgroundColor:
                            widget.content.progress!.backgroundColor ??
                                resolvedTheme.progressBackgroundColor ??
                                textStyle.color?.withValues(alpha: 0.2),
                        valueColor: AlwaysStoppedAnimation(
                          widget.content.progress!.color ??
                              resolvedTheme.progressColor ??
                              textStyle.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    // Wrap with dismissible if swipe is enabled
    if (widget.config.dismissalTypes.contains(DismissalType.swipe)) {
      toastContent = Dismissible(
        key: ValueKey(widget.item.id),
        direction: _getSwipeDirection(),
        onDismissed: (_) => widget.onDismiss(DismissalReason.swipe),
        child: toastContent,
      );
    }

    return toastContent;
  }

  @override
  Widget build(BuildContext context) {
    final alignment = _getAlignment();
    final margin = widget.theme.margin ?? const EdgeInsets.all(16);

    final enterBuilder = widget.config.enterAnimationBuilder ??
        widget.config.animationBuilder ??
        widget.theme.enterAnimationBuilder ??
        widget.theme.animationBuilder ??
        OverlayAnimations.slideFromPosition();

    final child = SafeArea(
      child: Padding(
        padding: margin,
        child: _buildToastContent(context),
      ),
    );

    return Align(
      alignment: alignment,
      child: enterBuilder(
        context,
        widget.animationController,
        alignment,
        child,
      ),
    );
  }
}

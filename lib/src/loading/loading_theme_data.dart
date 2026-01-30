import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../shared/animations/overlay_animation_builder.dart';
import '../shared/enums/loading_style.dart';

/// Builder type for custom loading widget.
typedef LoadingWidgetBuilder = Widget Function(BuildContext context);

/// Theme data for loading overlay styling.
@immutable
class LoadingThemeData extends Equatable {
  /// Creates a loading theme.
  const LoadingThemeData({
    // Style
    this.style = LoadingStyle.adaptive,
    this.builder,

    // Barrier
    this.barrierColor = Colors.black54,
    this.barrierDismissible = false,
    this.blockInteraction = true,
    this.blockInteractionMode = BlockInteractionMode.full,
    this.allowBackButton = false,

    // Container
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.minSize,

    // Indicator
    this.indicatorSize,
    this.indicatorColor,
    this.indicatorStrokeWidth,

    // Message
    this.messageTextStyle,
    this.messageSpacing,

    // Animation
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationBuilder,

    // Dark theme
    this.darkBackgroundColor,
    this.darkIndicatorColor,
    this.darkMessageTextStyle,
  });

  // Style
  /// Loading indicator style
  final LoadingStyle style;

  /// Custom builder for loading widget
  final LoadingWidgetBuilder? builder;

  // Barrier
  /// Barrier color
  final Color? barrierColor;

  /// Whether barrier is dismissible
  final bool barrierDismissible;

  /// Whether to block interaction
  final bool blockInteraction;

  /// Mode for blocking interaction
  final BlockInteractionMode blockInteractionMode;

  /// Whether to allow back button
  final bool allowBackButton;

  // Container
  /// Background color of loading container
  final Color? backgroundColor;

  /// Border radius
  final BorderRadius? borderRadius;

  /// Elevation
  final double? elevation;

  /// Padding inside container
  final EdgeInsets? padding;

  /// Minimum size of container
  final Size? minSize;

  // Indicator
  /// Size of the indicator
  final double? indicatorSize;

  /// Color of the indicator
  final Color? indicatorColor;

  /// Stroke width of the indicator
  final double? indicatorStrokeWidth;

  // Message
  /// Text style for message
  final TextStyle? messageTextStyle;

  /// Spacing between indicator and message
  final double? messageSpacing;

  // Animation
  /// Duration of animations
  final Duration animationDuration;

  /// Animation builder
  final OverlayAnimationBuilder? animationBuilder;

  // Dark theme
  /// Background color in dark mode
  final Color? darkBackgroundColor;

  /// Indicator color in dark mode
  final Color? darkIndicatorColor;

  /// Message text style in dark mode
  final TextStyle? darkMessageTextStyle;

  /// Creates a copy with the given fields replaced.
  LoadingThemeData copyWith({
    LoadingStyle? style,
    LoadingWidgetBuilder? builder,
    Color? barrierColor,
    bool? barrierDismissible,
    bool? blockInteraction,
    BlockInteractionMode? blockInteractionMode,
    bool? allowBackButton,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double? elevation,
    EdgeInsets? padding,
    Size? minSize,
    double? indicatorSize,
    Color? indicatorColor,
    double? indicatorStrokeWidth,
    TextStyle? messageTextStyle,
    double? messageSpacing,
    Duration? animationDuration,
    OverlayAnimationBuilder? animationBuilder,
    Color? darkBackgroundColor,
    Color? darkIndicatorColor,
    TextStyle? darkMessageTextStyle,
  }) {
    return LoadingThemeData(
      style: style ?? this.style,
      builder: builder ?? this.builder,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      blockInteraction: blockInteraction ?? this.blockInteraction,
      blockInteractionMode: blockInteractionMode ?? this.blockInteractionMode,
      allowBackButton: allowBackButton ?? this.allowBackButton,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      minSize: minSize ?? this.minSize,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      indicatorStrokeWidth: indicatorStrokeWidth ?? this.indicatorStrokeWidth,
      messageTextStyle: messageTextStyle ?? this.messageTextStyle,
      messageSpacing: messageSpacing ?? this.messageSpacing,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      darkBackgroundColor: darkBackgroundColor ?? this.darkBackgroundColor,
      darkIndicatorColor: darkIndicatorColor ?? this.darkIndicatorColor,
      darkMessageTextStyle: darkMessageTextStyle ?? this.darkMessageTextStyle,
    );
  }

  /// Merges two themes, with [other] taking precedence.
  LoadingThemeData merge(LoadingThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: other.style,
      builder: other.builder,
      barrierColor: other.barrierColor,
      barrierDismissible: other.barrierDismissible,
      blockInteraction: other.blockInteraction,
      blockInteractionMode: other.blockInteractionMode,
      allowBackButton: other.allowBackButton,
      backgroundColor: other.backgroundColor,
      borderRadius: other.borderRadius,
      elevation: other.elevation,
      padding: other.padding,
      minSize: other.minSize,
      indicatorSize: other.indicatorSize,
      indicatorColor: other.indicatorColor,
      indicatorStrokeWidth: other.indicatorStrokeWidth,
      messageTextStyle: other.messageTextStyle,
      messageSpacing: other.messageSpacing,
      animationDuration: other.animationDuration,
      animationBuilder: other.animationBuilder,
      darkBackgroundColor: other.darkBackgroundColor,
      darkIndicatorColor: other.darkIndicatorColor,
      darkMessageTextStyle: other.darkMessageTextStyle,
    );
  }

  /// Resolves theme based on brightness.
  LoadingThemeData resolve(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return copyWith(
        backgroundColor: darkBackgroundColor ?? backgroundColor,
        indicatorColor: darkIndicatorColor ?? indicatorColor,
        messageTextStyle: darkMessageTextStyle ?? messageTextStyle,
      );
    }
    return this;
  }

  @override
  List<Object?> get props => [
        style,
        barrierColor,
        barrierDismissible,
        blockInteraction,
        blockInteractionMode,
        allowBackButton,
        backgroundColor,
        borderRadius,
        elevation,
        padding,
        minSize,
        indicatorSize,
        indicatorColor,
        indicatorStrokeWidth,
        messageTextStyle,
        messageSpacing,
        animationDuration,
        darkBackgroundColor,
        darkIndicatorColor,
        darkMessageTextStyle,
      ];
}

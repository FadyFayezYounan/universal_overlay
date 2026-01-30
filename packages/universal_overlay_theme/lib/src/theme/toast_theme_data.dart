import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../animations/overlay_animation_builder.dart';
import '../enums/dismissal_type.dart';
import '../enums/overlay_position.dart';
import '../enums/toast_display_mode.dart';
import '../models/barrier_config.dart';
import '../models/stack_config.dart';

/// Theme data for toast styling.
@immutable
final class ToastThemeData extends Equatable {
  /// Creates a toast theme.
  const ToastThemeData({
    // Display
    this.displayMode = ToastDisplayMode.queue,
    this.position = OverlayPosition.bottom,
    this.stackConfig,

    // Timing
    this.duration = const Duration(seconds: 4),
    this.animationDuration = const Duration(milliseconds: 300),

    // Animation
    this.animationBuilder,
    this.enterAnimationBuilder,
    this.exitAnimationBuilder,

    // Dismissal
    this.dismissalTypes = const {DismissalType.timer, DismissalType.swipe},
    this.swipeDismissDirection,

    // Light theme styling
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
    this.elevation,
    this.shadowColor,
    this.border,
    this.padding,
    this.margin,
    this.maxWidth,
    this.minHeight,

    // Dark theme styling
    this.darkBackgroundColor,
    this.darkTextStyle,
    this.darkShadowColor,
    this.darkBorder,

    // Icon styling
    this.leadingIconSize,
    this.leadingIconColor,
    this.trailingIconSize,
    this.trailingIconColor,

    // Action styling
    this.actionTextStyle,
    this.actionPadding,

    // Progress styling
    this.progressHeight,
    this.progressColor,
    this.progressBackgroundColor,

    // Barrier
    this.barrier,
  });

  // Display
  /// Display mode for multiple toasts
  final ToastDisplayMode displayMode;

  /// Position of the toast on screen
  final OverlayPosition position;

  /// Configuration for stacked toasts
  final StackConfig? stackConfig;

  // Timing
  /// Duration before auto-dismiss
  final Duration duration;

  /// Duration of animations
  final Duration animationDuration;

  // Animation
  /// Animation builder for both enter and exit
  final OverlayAnimationBuilder? animationBuilder;

  /// Animation builder for enter only
  final OverlayAnimationBuilder? enterAnimationBuilder;

  /// Animation builder for exit only
  final OverlayAnimationBuilder? exitAnimationBuilder;

  // Dismissal
  /// Allowed dismissal types
  final Set<DismissalType> dismissalTypes;

  /// Direction for swipe dismissal
  final DismissDirection? swipeDismissDirection;

  // Light theme styling
  /// Background color in light mode
  final Color? backgroundColor;

  /// Text style in light mode
  final TextStyle? textStyle;

  /// Border radius
  final BorderRadius? borderRadius;

  /// Elevation
  final double? elevation;

  /// Shadow color in light mode
  final Color? shadowColor;

  /// Border in light mode
  final BoxBorder? border;

  /// Padding inside the toast
  final EdgeInsets? padding;

  /// Margin around the toast
  final EdgeInsets? margin;

  /// Maximum width of the toast
  final double? maxWidth;

  /// Minimum height of the toast
  final double? minHeight;

  // Dark theme styling
  /// Background color in dark mode
  final Color? darkBackgroundColor;

  /// Text style in dark mode
  final TextStyle? darkTextStyle;

  /// Shadow color in dark mode
  final Color? darkShadowColor;

  /// Border in dark mode
  final BoxBorder? darkBorder;

  // Icon styling
  /// Leading icon size
  final double? leadingIconSize;

  /// Leading icon color
  final Color? leadingIconColor;

  /// Trailing icon size
  final double? trailingIconSize;

  /// Trailing icon color
  final Color? trailingIconColor;

  // Action styling
  /// Text style for action button
  final TextStyle? actionTextStyle;

  /// Padding around action button
  final EdgeInsets? actionPadding;

  // Progress styling
  /// Height of progress indicator
  final double? progressHeight;

  /// Color of progress indicator
  final Color? progressColor;

  /// Background color of progress track
  final Color? progressBackgroundColor;

  // Barrier
  /// Optional barrier configuration
  final BarrierConfig? barrier;

  /// Creates a copy with the given fields replaced.
  ToastThemeData copyWith({
    ToastDisplayMode? displayMode,
    OverlayPosition? position,
    StackConfig? stackConfig,
    Duration? duration,
    Duration? animationDuration,
    OverlayAnimationBuilder? animationBuilder,
    OverlayAnimationBuilder? enterAnimationBuilder,
    OverlayAnimationBuilder? exitAnimationBuilder,
    Set<DismissalType>? dismissalTypes,
    DismissDirection? swipeDismissDirection,
    Color? backgroundColor,
    TextStyle? textStyle,
    BorderRadius? borderRadius,
    double? elevation,
    Color? shadowColor,
    BoxBorder? border,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? maxWidth,
    double? minHeight,
    Color? darkBackgroundColor,
    TextStyle? darkTextStyle,
    Color? darkShadowColor,
    BoxBorder? darkBorder,
    double? leadingIconSize,
    Color? leadingIconColor,
    double? trailingIconSize,
    Color? trailingIconColor,
    TextStyle? actionTextStyle,
    EdgeInsets? actionPadding,
    double? progressHeight,
    Color? progressColor,
    Color? progressBackgroundColor,
    BarrierConfig? barrier,
  }) {
    return ToastThemeData(
      displayMode: displayMode ?? this.displayMode,
      position: position ?? this.position,
      stackConfig: stackConfig ?? this.stackConfig,
      duration: duration ?? this.duration,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      enterAnimationBuilder:
          enterAnimationBuilder ?? this.enterAnimationBuilder,
      exitAnimationBuilder: exitAnimationBuilder ?? this.exitAnimationBuilder,
      dismissalTypes: dismissalTypes ?? this.dismissalTypes,
      swipeDismissDirection:
          swipeDismissDirection ?? this.swipeDismissDirection,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      border: border ?? this.border,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      maxWidth: maxWidth ?? this.maxWidth,
      minHeight: minHeight ?? this.minHeight,
      darkBackgroundColor: darkBackgroundColor ?? this.darkBackgroundColor,
      darkTextStyle: darkTextStyle ?? this.darkTextStyle,
      darkShadowColor: darkShadowColor ?? this.darkShadowColor,
      darkBorder: darkBorder ?? this.darkBorder,
      leadingIconSize: leadingIconSize ?? this.leadingIconSize,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      trailingIconSize: trailingIconSize ?? this.trailingIconSize,
      trailingIconColor: trailingIconColor ?? this.trailingIconColor,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      actionPadding: actionPadding ?? this.actionPadding,
      progressHeight: progressHeight ?? this.progressHeight,
      progressColor: progressColor ?? this.progressColor,
      progressBackgroundColor:
          progressBackgroundColor ?? this.progressBackgroundColor,
      barrier: barrier ?? this.barrier,
    );
  }

  /// Merges two themes, with [other] taking precedence.
  ToastThemeData merge(ToastThemeData? other) {
    if (other == null) return this;
    return copyWith(
      displayMode: other.displayMode,
      position: other.position,
      stackConfig: other.stackConfig,
      duration: other.duration,
      animationDuration: other.animationDuration,
      animationBuilder: other.animationBuilder,
      enterAnimationBuilder: other.enterAnimationBuilder,
      exitAnimationBuilder: other.exitAnimationBuilder,
      dismissalTypes: other.dismissalTypes,
      swipeDismissDirection: other.swipeDismissDirection,
      backgroundColor: other.backgroundColor,
      textStyle: other.textStyle,
      borderRadius: other.borderRadius,
      elevation: other.elevation,
      shadowColor: other.shadowColor,
      border: other.border,
      padding: other.padding,
      margin: other.margin,
      maxWidth: other.maxWidth,
      minHeight: other.minHeight,
      darkBackgroundColor: other.darkBackgroundColor,
      darkTextStyle: other.darkTextStyle,
      darkShadowColor: other.darkShadowColor,
      darkBorder: other.darkBorder,
      leadingIconSize: other.leadingIconSize,
      leadingIconColor: other.leadingIconColor,
      trailingIconSize: other.trailingIconSize,
      trailingIconColor: other.trailingIconColor,
      actionTextStyle: other.actionTextStyle,
      actionPadding: other.actionPadding,
      progressHeight: other.progressHeight,
      progressColor: other.progressColor,
      progressBackgroundColor: other.progressBackgroundColor,
      barrier: other.barrier,
    );
  }

  /// Resolves theme based on brightness.
  ToastThemeData resolve(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return copyWith(
        backgroundColor: darkBackgroundColor ?? backgroundColor,
        textStyle: darkTextStyle ?? textStyle,
        shadowColor: darkShadowColor ?? shadowColor,
        border: darkBorder ?? border,
      );
    }
    return this;
  }

  @override
  List<Object?> get props => [
        displayMode,
        position,
        stackConfig,
        duration,
        animationDuration,
        dismissalTypes,
        swipeDismissDirection,
        backgroundColor,
        textStyle,
        borderRadius,
        elevation,
        shadowColor,
        border,
        padding,
        margin,
        maxWidth,
        minHeight,
        darkBackgroundColor,
        darkTextStyle,
        darkShadowColor,
        darkBorder,
        leadingIconSize,
        leadingIconColor,
        trailingIconSize,
        trailingIconColor,
        actionTextStyle,
        actionPadding,
        progressHeight,
        progressColor,
        progressBackgroundColor,
        barrier,
      ];
}

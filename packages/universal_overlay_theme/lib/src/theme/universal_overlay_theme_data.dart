import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'custom_overlay_theme_data.dart';
import 'loading_theme_data.dart';
import 'toast_theme_data.dart';

/// The theme data for universal overlay widgets.
///
/// This class holds all the theming data for toasts, loading indicators,
/// and custom overlays.
@immutable
class UniversalOverlayThemeData extends Equatable {
  /// Creates a universal overlay theme data.
  const UniversalOverlayThemeData({
    this.toastTheme = const ToastThemeData(),
    this.loadingTheme = const LoadingThemeData(),
    this.customTheme = const CustomOverlayThemeData(),
  });

  /// Default theme for toast overlays.
  final ToastThemeData toastTheme;

  /// Default theme for loading overlays.
  final LoadingThemeData loadingTheme;

  /// Default theme for custom overlays.
  final CustomOverlayThemeData customTheme;

  /// Creates a copy with the given fields replaced.
  UniversalOverlayThemeData copyWith({
    ToastThemeData? toastTheme,
    LoadingThemeData? loadingTheme,
    CustomOverlayThemeData? customTheme,
  }) {
    return UniversalOverlayThemeData(
      toastTheme: toastTheme ?? this.toastTheme,
      loadingTheme: loadingTheme ?? this.loadingTheme,
      customTheme: customTheme ?? this.customTheme,
    );
  }

  /// Merges two themes, with [other] taking precedence.
  UniversalOverlayThemeData merge(UniversalOverlayThemeData? other) {
    if (other == null) return this;
    return copyWith(
      toastTheme: toastTheme.merge(other.toastTheme),
      loadingTheme: loadingTheme.merge(other.loadingTheme),
      customTheme: other.customTheme,
    );
  }

  @override
  List<Object?> get props => [toastTheme, loadingTheme, customTheme];
}

/// Style options for loading indicators.
enum LoadingStyle {
  /// Uses platform-appropriate indicator
  adaptive,

  /// Material CircularProgressIndicator
  material,

  /// Cupertino activity indicator
  cupertino,

  /// Custom builder
  custom,
}

/// Mode for blocking interaction during loading.
enum BlockInteractionMode {
  /// Blocks entire screen
  full,

  /// Blocks only the area under the loading indicator
  partial,
}

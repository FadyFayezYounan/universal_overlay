/// Types of dismissal triggers for overlays.
enum DismissalType {
  /// Dismisses after duration expires
  timer,

  /// Dismisses on swipe gesture
  swipe,

  /// Dismisses when tapping the overlay
  tapOverlay,

  /// Dismisses when tapping outside the overlay
  tapOutside,

  /// Only dismisses via code (item.dismiss())
  programmatic,

  /// Dismisses on Android back button
  backButton,
}

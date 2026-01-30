/// Reason why an overlay was dismissed.
enum DismissalReason {
  /// Timer expired
  timer,

  /// User swiped
  swipe,

  /// User tapped overlay
  tapOverlay,

  /// User tapped outside
  tapOutside,

  /// Dismissed programmatically
  programmatic,

  /// Back button pressed
  backButton,

  /// Action button pressed
  action,

  /// Replaced by another overlay
  replaced,
}

/// Direction for stacked overlays.
enum StackDirection {
  /// New toasts push old ones up
  up,

  /// New toasts push old ones down
  down,
}

/// Behavior when max visible is exceeded.
enum StackOverflowBehavior {
  /// Queue excess toasts
  queue,

  /// Dismiss oldest toast
  dismissOldest,
}

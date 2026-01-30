/// Display modes for toast overlays.
enum ToastDisplayMode {
  /// Show one toast at a time, queue others
  queue,

  /// Show multiple toasts stacked vertically
  stack,

  /// New toast immediately replaces current one
  replace,
}

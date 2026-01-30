import 'package:flutter/widgets.dart';

import 'universal_overlay_controller.dart';
import 'universal_overlay_scope.dart';

/// Static accessor class providing the `of(context)` pattern.
///
/// Use `UniversalOverlay.of(context)` to access the overlay controller.
///
/// ```dart
/// UniversalOverlay.of(context).showToast(
///   content: ToastContent(message: "Hello!"),
/// );
/// ```
@immutable
class UniversalOverlay {
  const UniversalOverlay._();

  /// Gets the [UniversalOverlayController] from the given [context].
  ///
  /// Throws an assertion error if no [UniversalOverlayScope] is found.
  static UniversalOverlayController of(BuildContext context) {
    return UniversalOverlayAccess.of(context);
  }

  /// Gets the [UniversalOverlayController] from the given [context],
  /// or null if no [UniversalOverlayScope] is found.
  static UniversalOverlayController? maybeOf(BuildContext context) {
    return UniversalOverlayAccess.maybeOf(context);
  }
}

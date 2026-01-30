import 'package:flutter/widgets.dart';

import '../core/universal_overlay_item.dart';

/// Builder type for custom overlay widgets.
///
/// The builder receives:
/// - [context]: The build context
/// - [item]: The overlay item controller for dismissal
typedef CustomOverlayBuilder = Widget Function(
  BuildContext context,
  UniversalOverlayItem item,
);

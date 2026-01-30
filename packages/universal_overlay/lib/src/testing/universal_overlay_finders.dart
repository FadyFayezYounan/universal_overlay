import 'package:flutter_test/flutter_test.dart';

import '../loading/loading_widget.dart';
import '../toast/toast_widget.dart';
import '../custom/custom_overlay_widget.dart';

/// Extension on [CommonFinders] for finding overlay widgets.
extension UniversalOverlayFinders on CommonFinders {
  /// Finds toast overlays by message.
  Finder universalOverlayToast(String message) {
    return find.byWidgetPredicate(
      (widget) => widget is ToastWidget && widget.content.message == message,
    );
  }

  /// Finds any visible toast.
  Finder universalOverlayToastAny() {
    return find.byType(ToastWidget);
  }

  /// Finds loading overlay.
  Finder universalOverlayLoading() {
    return find.byType(LoadingOverlayWidget);
  }

  /// Finds loading overlay with message.
  Finder universalOverlayLoadingWithMessage(String message) {
    return find.byWidgetPredicate(
      (widget) => widget is LoadingOverlayWidget && widget.message == message,
    );
  }

  /// Finds custom overlay.
  Finder universalOverlayCustom() {
    return find.byType(CustomOverlayWidget);
  }
}

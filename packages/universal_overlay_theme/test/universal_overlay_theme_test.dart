import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universal_overlay_theme/universal_overlay_theme.dart';

void main() {
  group('UniversalOverlayThemeData', () {
    test('creates with default values', () {
      const themeData = UniversalOverlayThemeData();

      expect(themeData.toastTheme, const ToastThemeData());
      expect(themeData.loadingTheme, const LoadingThemeData());
      expect(themeData.customTheme, const CustomOverlayThemeData());
    });

    test('copyWith creates new instance with updated values', () {
      const original = UniversalOverlayThemeData();
      const newToastTheme = ToastThemeData(position: OverlayPosition.top);

      final updated = original.copyWith(toastTheme: newToastTheme);

      expect(updated.toastTheme.position, OverlayPosition.top);
      expect(updated.loadingTheme, original.loadingTheme);
    });
  });

  group('UniversalOverlayTheme', () {
    testWidgets('provides theme data to descendants', (tester) async {
      const themeData = UniversalOverlayThemeData(
        toastTheme: ToastThemeData(position: OverlayPosition.top),
      );

      UniversalOverlayThemeData? retrievedTheme;

      await tester.pumpWidget(
        UniversalOverlayTheme(
          data: themeData,
          child: Builder(
            builder: (context) {
              retrievedTheme = UniversalOverlayTheme.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(retrievedTheme, isNotNull);
      expect(retrievedTheme!.toastTheme.position, OverlayPosition.top);
    });

    testWidgets('maybeOf returns null when no theme in tree', (tester) async {
      UniversalOverlayThemeData? retrievedTheme;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            retrievedTheme = UniversalOverlayTheme.maybeOf(context);
            return const SizedBox();
          },
        ),
      );

      expect(retrievedTheme, isNull);
    });

    testWidgets('of returns default theme when no theme in tree',
        (tester) async {
      UniversalOverlayThemeData? retrievedTheme;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            retrievedTheme = UniversalOverlayTheme.of(context);
            return const SizedBox();
          },
        ),
      );

      expect(retrievedTheme, isNotNull);
      expect(retrievedTheme, const UniversalOverlayThemeData());
    });
  });

  group('ToastThemeData', () {
    test('creates with default values', () {
      const theme = ToastThemeData();

      expect(theme.displayMode, ToastDisplayMode.queue);
      expect(theme.position, OverlayPosition.bottom);
      expect(theme.duration, const Duration(seconds: 4));
    });

    test('copyWith works correctly', () {
      const original = ToastThemeData();
      final updated = original.copyWith(
        position: OverlayPosition.top,
        duration: const Duration(seconds: 2),
      );

      expect(updated.position, OverlayPosition.top);
      expect(updated.duration, const Duration(seconds: 2));
      expect(updated.displayMode, original.displayMode);
    });
  });

  group('LoadingThemeData', () {
    test('creates with default values', () {
      const theme = LoadingThemeData();

      expect(theme.style, LoadingStyle.adaptive);
      expect(theme.barrierColor, Colors.black54);
      expect(theme.barrierDismissible, false);
    });

    test('copyWith works correctly', () {
      const original = LoadingThemeData();
      final updated = original.copyWith(
        style: LoadingStyle.material,
        barrierDismissible: true,
      );

      expect(updated.style, LoadingStyle.material);
      expect(updated.barrierDismissible, true);
      expect(updated.barrierColor, original.barrierColor);
    });
  });

  group('CustomOverlayThemeData', () {
    test('creates with default values', () {
      const theme = CustomOverlayThemeData();

      expect(theme.position, OverlayPosition.center);
      expect(theme.dismissalTypes, {DismissalType.programmatic});
    });

    test('copyWith works correctly', () {
      const original = CustomOverlayThemeData();
      final updated = original.copyWith(
        position: OverlayPosition.bottom,
        dismissalTypes: {DismissalType.tapOutside},
      );

      expect(updated.position, OverlayPosition.bottom);
      expect(updated.dismissalTypes, {DismissalType.tapOutside});
    });
  });
}

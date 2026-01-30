import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universal_overlay/universal_overlay.dart';

void main() {
  group('UniversalOverlay', () {
    testWidgets('shows simple toast', (tester) async {
      late UniversalOverlayItem toastItem;

      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => UniversalOverlay(child: child!),
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  toastItem = UniversalOverlay.of(context).showToast(
                    content: const ToastContent(message: 'Test Toast'),
                    theme: const ToastThemeData(
                      dismissalTypes: {DismissalType.programmatic},
                    ),
                  );
                },
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      // Pump to trigger addPostFrameCallback for manager initialization
      await tester.pump();

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Test Toast'), findsOneWidget);

      // Clean up before widget teardown
      toastItem.dismiss();
      await tester.pumpAndSettle();
    });

    testWidgets('shows loading overlay', (tester) async {
      late UniversalOverlayItem loadingItem;

      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => UniversalOverlay(child: child!),
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  loadingItem = UniversalOverlay.of(context).showLoading(
                    message: 'Loading...',
                  );
                },
                child: const Text('Show Loading'),
              ),
            ),
          ),
        ),
      );

      // Pump to trigger addPostFrameCallback for manager initialization
      await tester.pump();

      await tester.tap(find.text('Show Loading'));
      // Can't use pumpAndSettle because CircularProgressIndicator runs indefinitely
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Loading...'), findsOneWidget);

      // Dismiss loading before widget teardown
      loadingItem.dismiss();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Loading...'), findsNothing);
    });

    testWidgets('shows custom overlay', (tester) async {
      late UniversalOverlayItem customItem;

      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => UniversalOverlay(child: child!),
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  customItem = UniversalOverlay.of(context).showCustom(
                    builder: (context, item) => Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Custom Content'),
                          ElevatedButton(
                            onPressed: () => item.dismiss(),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    ),
                    theme: const CustomOverlayThemeData(
                      barrier: BarrierConfig(color: Colors.black54),
                    ),
                  );
                },
                child: const Text('Show Custom'),
              ),
            ),
          ),
        ),
      );

      // Pump to trigger addPostFrameCallback for manager initialization
      await tester.pump();

      await tester.tap(find.text('Show Custom'));
      await tester.pumpAndSettle();

      expect(find.text('Custom Content'), findsOneWidget);

      // Clean up before widget teardown
      customItem.dismiss();
      await tester.pumpAndSettle();
    });

    testWidgets('dismissAll clears all overlays', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => UniversalOverlay(child: child!),
          home: Builder(
            builder: (context) => Scaffold(
              body: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      UniversalOverlay.of(context).showToast(
                        content: const ToastContent(message: 'Toast 1'),
                        theme: const ToastThemeData(
                          dismissalTypes: {DismissalType.programmatic},
                        ),
                      );
                    },
                    child: const Text('Show Toast'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      UniversalOverlay.of(context).dismissAll();
                    },
                    child: const Text('Dismiss All'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Pump to trigger addPostFrameCallback for manager initialization
      await tester.pump();

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.text('Toast 1'), findsOneWidget);

      await tester.tap(find.text('Dismiss All'));
      await tester.pumpAndSettle();

      expect(find.text('Toast 1'), findsNothing);
    });
  });

  group('ToastContent', () {
    test('equals works correctly', () {
      const content1 = ToastContent(message: 'Test');
      const content2 = ToastContent(message: 'Test');
      const content3 = ToastContent(message: 'Different');

      expect(content1, equals(content2));
      expect(content1, isNot(equals(content3)));
    });

    test('copyWith works correctly', () {
      const original = ToastContent(message: 'Original');
      final copied = original.copyWith(message: 'Copied');

      expect(original.message, equals('Original'));
      expect(copied.message, equals('Copied'));
    });
  });

  group('ToastThemeData', () {
    test('merge works correctly', () {
      const base = ToastThemeData(
        backgroundColor: Colors.red,
        elevation: 4,
      );
      const override = ToastThemeData(
        backgroundColor: Colors.blue,
      );

      final merged = base.merge(override);

      expect(merged.backgroundColor, equals(Colors.blue));
      expect(merged.elevation, equals(4));
    });

    test('resolve works for dark mode', () {
      const theme = ToastThemeData(
        backgroundColor: Colors.white,
        darkBackgroundColor: Colors.black,
      );

      final resolved = theme.resolve(Brightness.dark);

      expect(resolved.backgroundColor, equals(Colors.black));
    });
  });

  group('LoadingThemeData', () {
    test('copyWith preserves unset values', () {
      const original = LoadingThemeData(
        barrierColor: Colors.red,
        indicatorSize: 40,
      );

      final copied = original.copyWith(barrierColor: Colors.blue);

      expect(copied.barrierColor, equals(Colors.blue));
      expect(copied.indicatorSize, equals(40));
    });
  });

  group('BarrierConfig', () {
    test('default values are correct', () {
      const config = BarrierConfig();

      expect(config.color, equals(Colors.black54));
      expect(config.dismissible, isFalse);
      expect(config.label, isNull);
    });
  });

  group('StackConfig', () {
    test('default values are correct', () {
      const config = StackConfig();

      expect(config.maxVisible, equals(3));
      expect(config.spacing, equals(8.0));
      expect(config.direction, equals(StackDirection.up));
      expect(config.overflowBehavior, equals(StackOverflowBehavior.queue));
    });
  });
}

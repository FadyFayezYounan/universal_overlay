# Universal Overlay

A comprehensive Flutter overlay system for toasts, loading indicators, and custom overlays using InheritedWidget pattern.

[![pub package](https://img.shields.io/pub/v/universal_overlay.svg)](https://pub.dev/packages/universal_overlay)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Features

- 🍞 **Toast Notifications** - Display brief messages with icons, actions, and progress indicators
- ⏳ **Loading Indicators** - Block UI with customizable loading overlays
- 🎨 **Custom Overlays** - Build any overlay widget with full control
- 🎭 **Theming System** - Comprehensive light/dark mode support
- 🎬 **Animation Presets** - Built-in animations with custom builder support
- 📱 **Display Modes** - Queue, stack, or replace overlays
- 🧪 **Testing Utilities** - Built-in finders and test helpers

## Getting Started

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  universal_overlay: ^1.0.0
```

### Basic Setup

Wrap your app with `UniversalOverlayScope`:

```dart
import 'package:flutter/material.dart';
import 'package:universal_overlay/universal_overlay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return UniversalOverlayScope(
          toastTheme: ToastThemeData(
            position: OverlayPosition.bottom,
            displayMode: ToastDisplayMode.queue,
          ),
          child: child!,
        );
      },
      home: HomePage(),
    );
  }
}
```

## Usage

### Simple Toast

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Hello, World!"),
);
```

### Toast with Icon

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "File saved successfully",
    leading: Icon(Icons.check_circle, color: Colors.green),
  ),
);
```

### Toast with Action

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "Message deleted",
    action: ToastAction(
      label: "Undo",
      onPressed: () => restoreMessage(),
    ),
  ),
);
```

### Toast with Preset Theme

```dart
// Success toast
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "Operation successful!",
    leading: Icon(Icons.check_circle),
  ),
  theme: ToastPresets.material3Success(),
);

// Error toast
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "Something went wrong",
    leading: Icon(Icons.error),
  ),
  theme: ToastPresets.material3Error(),
);
```

### Toast with Progress

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "Uploading file...",
    leading: Icon(Icons.cloud_upload),
    progress: ToastProgress(
      value: 0.65, // 65% complete
      color: Colors.blue,
    ),
  ),
);
```

### Loading Indicator

```dart
// Show loading
final loading = UniversalOverlay.of(context).showLoading(
  message: "Processing...",
);

// Perform async operation
await performOperation();

// Dismiss loading
loading.dismiss();
```

### Custom Overlay

```dart
UniversalOverlay.of(context).showCustom(
  builder: (context, item) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Custom Overlay'),
          ElevatedButton(
            onPressed: () => item.dismiss(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  },
  config: CustomOverlayConfig(
    barrier: BarrierConfig(
      color: Colors.black54,
      dismissible: true,
    ),
  ),
);
```

### Custom Animations

```dart
// Using preset animations
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Bouncy!"),
  config: ToastConfig(
    animationBuilder: OverlayAnimations.bounce(),
  ),
);

// Separate enter/exit animations
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Slide in, fade out!"),
  config: ToastConfig(
    enterAnimationBuilder: OverlayAnimations.slideFromTop(),
    exitAnimationBuilder: OverlayAnimations.fade(),
  ),
);
```

### Dismissal

```dart
// Dismiss specific overlay
final item = UniversalOverlay.of(context).showToast(...);
item.dismiss();

// Dismiss all
UniversalOverlay.of(context).dismissAll();

// Dismiss by type
UniversalOverlay.of(context).dismissAllToasts();
UniversalOverlay.of(context).dismissAllLoading();
```

### Check State

```dart
final overlay = UniversalOverlay.of(context);

if (overlay.isLoadingVisible) {
  print("Loading is showing");
}

print("Active toasts: ${overlay.activeToastCount}");
print("Has overlays: ${overlay.hasActiveOverlays}");
```

## Available Presets

### Toast Themes
- `ToastPresets.material3Success()`
- `ToastPresets.material3Error()`
- `ToastPresets.material3Warning()`
- `ToastPresets.material3Info()`
- `ToastPresets.minimal()`
- `ToastPresets.elevated()`
- `ToastPresets.rounded()`
- `ToastPresets.ios()`

### Animations
- `OverlayAnimations.slideFromTop()`
- `OverlayAnimations.slideFromBottom()`
- `OverlayAnimations.slideFromLeft()`
- `OverlayAnimations.slideFromRight()`
- `OverlayAnimations.fade()`
- `OverlayAnimations.scale()`
- `OverlayAnimations.bounce()`
- `OverlayAnimations.elastic()`
- `OverlayAnimations.none()`

## Testing

The package includes testing utilities:

```dart
testWidgets('shows toast', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      builder: (context, child) => UniversalOverlayScope(child: child!),
      home: MyWidget(),
    ),
  );

  // Trigger toast
  await tester.tap(find.text('Show Toast'));
  await tester.pump();
  await tester.pump(Duration(milliseconds: 300));

  // Find toast
  expect(find.universalOverlayToast('Success!'), findsOneWidget);

  // Use tester helper
  final overlayTester = UniversalOverlayTester.of(tester);
  expect(overlayTester.activeToastCount, equals(1));
});
```

## Additional Information

### Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### License

This project is licensed under the MIT License - see the LICENSE file for details.
